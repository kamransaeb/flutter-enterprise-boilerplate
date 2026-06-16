// import 'package:dio/dio.dart';

// class AuthInterceptor extends Interceptor {
//   final Future<String?> Function() getAccessToken;
//   final Future<String?> Function() getRefreshToken;
//   final Future<void> Function() onTokenExpired;
//   final Future<void> Function(String token) onTokenRefreshed;

//   AuthInterceptor({
//     required this.getAccessToken,
//     required this.getRefreshToken,
//     required this.onTokenExpired,
//     required this.onTokenRefreshed,
//   });

//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     final token = await getAccessToken();
//     if (token != null) {
//       options.headers['Authorization'] = 'Bearer $token';
//     }
//     handler.next(options);
//   }

//   @override
//   Future<void> onError(
//     DioException err,
//     ErrorInterceptorHandler handler,
//   ) async {
//     if (err.response?.statusCode == 401) {
//       // Handle token refresh
//       try {
//         final refreshToken = await getRefreshToken();
//         if (refreshToken != null) {
//           // Implement token refresh logic
//           // final newToken = await refreshToken(refreshToken);
//           // await onTokenRefreshed(newToken);

//           // Retry the original request
//           final response = await _retry(err.requestOptions);
//           handler.resolve(response);
//           return;
//         } else {
//           await onTokenExpired();
//           handler.reject(err);
//         }
//       } catch (_) {
//         await onTokenExpired();
//         handler.reject(err);
//       }
//     }
//     handler.next(err);
//   }

//   Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
//     final options = Options(
//       method: requestOptions.method,
//       headers: requestOptions.headers,
//     );

//     return Dio().request<dynamic>(
//       requestOptions.path,
//       data: requestOptions.data,
//       queryParameters: requestOptions.queryParameters,
//       options: options,
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/queued_interceptor_callback.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorage _secureStorage;
  String? _accessToken;
  String? _refreshToken;
  bool _isRefreshing = false;
  final List<QueuedInterceptorCallback> _pendingRequests = [];

  AuthInterceptor({required SecureStorage secureStorage})
    : _secureStorage = secureStorage {
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    _accessToken = await _secureStorage.read('access_token');
    _refreshToken = await _secureStorage.read('refresh_token');
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check if the endpoint requires authentication
    final requiresAuth = options.headers['requireAuth'] as bool? ?? true;

    // Remove the custom header to avoid sending it to the server
    options.headers.remove('requireAuth');

    if (requiresAuth) {
      if (_accessToken == null) {
        await _loadTokens();
      }

      if (_accessToken != null && _accessToken!.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $_accessToken';
        super.onRequest(options, handler);
      } else {
        // Token is required but not available, add it to the pending requests
        handler.reject(
          DioException(
            requestOptions: options,
            error: 'Authentication required',
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } else {
      super.onRequest(options, handler);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - token expired or invalid
    if (err.response?.statusCode == 401 && _refreshToken != null) {
      // Prevent multiple refresh attempts
      if (_isRefreshing) {
        // Queue the request to retry after token refresh
        _pendingRequests.add(
          QueuedInterceptorCallback(
            handler, err.requestOptions,
                         err.requestOptions.headers['X-Correlation-ID'] as String?,
                         DateTime.now(),
            ), 
            );
                logger.d(
          'Request queued for token refresh. '
          'Queue size: ${_pendingRequests.length}'
        );
        return;
      }
      _isRefreshing = true;
      try {
        // Attempt to refresh token
        final success = await _refreshAccessToken();

        if (success) {
          // Retry all queued requests
          await _retryQueuedRequests();

          // Retry the original request
          final newOptions = _updateRequestOptionsWithNewToken(
            err.requestOptions,
          );
          final response = await _retryRequest(newOptions);
          handler.resolve(response);
        } else {
          // Failed to refresh token, clear tokens and reject the request
          await _clearTokens();
          _rejectAllQueuedRequests(err);
          handler.next(err);
        }
      } catch (_) {
        // Failed to refresh token, clear tokens and reject the request
        await _clearTokens();
        _rejectAllQueuedRequests(err);
        handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }

  Future<bool> _refreshAccessToken() async {
    try {
      // This should be implemented by the your API client
      // For now, we'll simulate or use a service
      // final apiClient = getIt<ApiClient>();
      // final response = await apiClient.refreshToken();
      // if (response.statusCode == 200) {
      //   _accessToken = response.data['access_token'];
      //   _refreshToken = response.data['refresh_token'];
      //   return true;
      // }
      // return false;
      // For demonstration, we'll assume we have a refresh method
      // In production, you'd inject a refresh token service
      await Future.delayed(const Duration(seconds: 2));
      final newAccessToken = await _performTokenRefresh();
      if (newAccessToken != null) {
        await _setToken(newAccessToken);
        return true;
      }
      return false;
    } catch (e) {
      logger.e('Failed to refresh access token: $e');
      return false;
    }
  }

  Future<String?> _performTokenRefresh() async {
    // TODO: Implement actual token refresh logic
    // This should call your refresh token endpoint
    // For now, return null to simulate failure
    return null;
  }

  RequestOptions _updateRequestOptionsWithNewToken(RequestOptions options) {
    options.headers['Authorization'] = 'Bearer $_accessToken';
    return options;
  }

  Future<Response> _retryRequest(RequestOptions options) async {
    final dio = Dio();
    return dio.request(
      options.path,
      options: Options(method: options.method, headers: options.headers),
      data: options.data,
      queryParameters: options.queryParameters,
    );
  }

  Future<void> _retryQueuedRequests() async {
    final queuedRequests = List<QueuedInterceptorCallback>.from(
      _pendingRequests,
    );
    _pendingRequests.clear();
        logger.d('Retrying ${queuedRequests.length} queued requests');


    for (final queued in queuedRequests) {
      final waitTime = queued.waitingDuration;
       logger.d('Retrying request after ${waitTime.inMilliseconds}ms: '
          '${queued.requestOptions.method} ${queued.requestOptions.path}');
      
      try {
        // Update the request with new token
       final newOptions = _updateRequestOptionsWithNewToken(queued.requestOptions);
       final response = await _retryRequest(newOptions);
       // Resolve the queued request with the new response
      if (queued.isValid) {
        queued.resolve(response);
                  logger.d('Successfully retried: ${queued.requestOptions.path}');

      }
      
      
      } catch (e) {
        logger.e('Failed to retry: ${queued.requestOptions.path}', error: e);

        // If retry fails, reject the queued request
        if (queued.isValid) {
          queued.reject(
            DioException(
              requestOptions: queued.requestOptions,
              error: e,
              type: DioExceptionType.badResponse,
            ),
          );
        }
      }
     
    }
  }

  void _rejectAllQueuedRequests(DioException error) {
     logger.w('Rejecting ${_pendingRequests.length} queued requests due to refresh failure');
    for (final queued in _pendingRequests) {

      if (queued.isValid) {
        queued.reject(error);
          logger.d('Rejected: ${queued.requestOptions.path} '
            '(waited ${queued.waitingDuration.inMilliseconds}ms)');
      }
    }
    _pendingRequests.clear();
  }

  Future<void> _setToken(String token) async {
    _accessToken = token;
    await _secureStorage.write('access_token', token);
  }

  Future<void> setRefreshToken(String token) async {
    _refreshToken = token;
    await _secureStorage.write('refresh_token', token);
  }

  Future<void> _clearAccessToken() async {
    _accessToken = null;
    await _secureStorage.delete('access_token');
  }

  Future<void> _clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    await _secureStorage.delete('access_token');
    await _secureStorage.delete('refresh_token');
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  bool get isAuthenticated => _accessToken != null && _accessToken!.isNotEmpty;

  /// Get the number of pending requests in queue
  int get pendingRequestsCount => _pendingRequests.length;

  /// Clear all pending requests
  void clearPendingRequests() {
    _pendingRequests.clear();
  }
}


