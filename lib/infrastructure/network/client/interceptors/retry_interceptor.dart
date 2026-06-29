import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

class RetryInterceptor extends Interceptor {
  final LoggerService _logger;
  final int maxRetries;
  final Duration retryDelay;
  final Set<int> retryStatusCodes;

  RetryInterceptor({
    required LoggerService logger,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.retryStatusCodes = const {500, 502, 503, 504},
  }) : _logger = logger;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldRetry(err)) {
      final requestOptions = err.requestOptions;
      final retryCount = requestOptions.extra['retry_count'] as int? ?? 0;

      if (retryCount < maxRetries) {
        await Future.delayed(retryDelay * (retryCount + 1));

        requestOptions.extra['retry_count'] = retryCount + 1;

        _logger.i('🔄 Retrying request (${retryCount + 1}/$maxRetries)...');

        try {
          final response = await Dio().fetch<dynamic>(requestOptions);
          handler.resolve(response);
        } catch (e) {
          handler.next(err);
        }
        return;
      }
    }

    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    // Retry on network errors
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }

    // Retry on specific status codes
    if (err.response != null &&
        retryStatusCodes.contains(err.response!.statusCode)) {
      return true;
    }

    return false;
  }

}