
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/cache_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

/// Interceptor for caching GET requests
@lazySingleton
class CacheInterceptor extends Interceptor {
  final LoggerService _logger;
  final CacheManager _cacheManager;

  CacheInterceptor({required CacheManager cacheManager, required LoggerService logger})
      : _cacheManager = cacheManager,
        _logger = logger;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Only cache GET requests
    if (options.method != 'GET') {
      return handler.next(options);
    }

    // Skip cache if explicitly disabled
    if (options.extra['skipCache'] == true) {
      return handler.next(options);
    }

    // Check if cache should be bypassed (force refresh)
    if (options.extra['forceRefresh'] == true) {
      return handler.next(options);
    }

    // Generate cache key
    final cacheKey = _generateCacheKey(options);

    // Check if we have a cached response
    Either<Failure, String?> result = await _cacheManager.getDataFromCache(cacheKey, boxName: 'api_cache');
    result.fold(ErrorHandler.handleError, (cachedData) {
      if (cachedData != null) {
        try {
          final responseData = jsonDecode(cachedData) as Map<String, dynamic>;
          final response = Response(
            requestOptions: options,
            statusCode: 200,
            data: responseData,
            extra: {
              'fromCache': true,
              'cachedAt': DateTime.now().toIso8601String(),
            },
          );
          return handler.resolve(response);
        } catch (e) {
          // Failed to parse cached data, return original request
          _logger.e('Failed to parse cached data for key: $cacheKey', error: e);
        }
      }
    });
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    
    // Only cache successful GET requests
    if (response.requestOptions.method == 'GET' &&
    response.statusCode == 200 &&
    (response.requestOptions.extra['skipCache'] ?? false) == false) {
      // Don't cache if there's an error in response data
      if (response.data is Map<String, dynamic> && response.data['error'] != null) {
        return handler.next(response);
      }

      // Generate cache key
      final cacheKey = _generateCacheKey(response.requestOptions);

      // Cache the response data
      try {
        Either<Failure, Unit> result = await _cacheManager.cacheData(
          cacheKey,
          jsonEncode(response.data),          
          boxName: 'api_cache',
        );
        // Tear-off is passing a function itself as value, instead of wrapping it in a closure.
        result.fold(ErrorHandler.handleError,            
        (_) {
          response.extra['cached'] = true;
          response.extra['cachedAt'] = DateTime.now().toIso8601String();
        });        
      } catch (e) {
        // Failed to cache data, return original response
        _logger.e('Failed to cache data for key: $cacheKey', error: e);
      }
    }
    handler.next(response);
  }

  @override
  onError(DioException err, ErrorInterceptorHandler handler) async {
    // If we have a cached response for this request, use it as fallback
    if (err.requestOptions.method == 'GET') {
      final cacheKey = _generateCacheKey(err.requestOptions);
      Either<Failure, String?> result = await _cacheManager.getDataFromCache(cacheKey);
      result.fold(ErrorHandler.handleError, (cachedData) {
        if (cachedData != null) {
          try {
            final responseData = jsonDecode(cachedData) as Map<String, dynamic>;
            final response = Response(
              requestOptions: err.requestOptions,
              statusCode: 200,
              data: responseData,
                extra: {
              'fromCache': true,
              'cachedAt': DateTime.now().toIso8601String(),
              'isFallback': true,
            },
            );

          return handler.resolve(response);
          } catch (e) {
            // Failed to parse cached data, return original error
            _logger.e('Failed to parse cached data for key: $cacheKey', error: e);
          }
        }
      });
    }
    handler.next(err);
  }

   /// Generate a unique cache key based on request
  String _generateCacheKey(RequestOptions options) {
    // Sort query parameters to ensure consistent keys
    final sortedParams = options.queryParameters.keys.toList()..sort();
    final queryString = sortedParams
        .map((key) => '$key=${options.queryParameters[key]}')
        .join('&');
    
    return '${options.method}_${options.path}_$queryString';
  }
}
