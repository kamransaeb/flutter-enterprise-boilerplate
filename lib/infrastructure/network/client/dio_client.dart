import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/cache/cache_manager.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/auth_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/cache_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/error_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/header_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/logging_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/interceptors/retry_interceptor.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/response_converter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

@singleton
class DioClient {

  DioClient(
    this._appConfig,
    this._deviceInfoPlugin,
    @Named('secure_storage') this._secureStorage,
    this._cacheManager,
    this._logger,
  ) {
    _dio = _createDio();
    _addInterceptors();
  }

  final LoggerService _logger;
  late final Dio _dio;
  final AppConfig _appConfig;
  final DeviceInfoPlugin _deviceInfoPlugin;
  final LocalStorage _secureStorage;
  final CacheManager _cacheManager;

  Dio get dio => _dio;

  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: _appConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: _appConfig.apiConnectTimeout),
        receiveTimeout: Duration(milliseconds: _appConfig.apiReceiveTimeout),
        sendTimeout: Duration(milliseconds: _appConfig.apiSendTimeout),
        headers: _defaultHeaders,
        validateStatus: (status) => status != null && status < 500,
      ),
    );
  }

  Map<String, dynamic> get _defaultHeaders => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Accept-Language': 'en',
    'Platform': 'mobile',
    'App-Version': _appConfig.appVersion,
    // 'App-Build': _appConfig.buildNumber,
    // 'Device-ID': _appConfig.deviceId,
    // 'Device-Model': _appConfig.deviceModel,
    // 'OS-Version': _appConfig.osVersion,
  };

  void _addInterceptors() {
    // Order is important: interceptors are executed in reverse order
    // The last interceptor you add runs first on request and last on responses.
    // Request flow: Request -> AuthInterceptor -> ErrorInterceptor -> LoggingInterceptor -> RetryInterceptor -> Response
    // Response flow: Response -> RetryInterceptor -> LoggingInterceptor -> ErrorInterceptor -> AuthInterceptor -> Request
    _dio.interceptors.clear();
    _dio.interceptors.addAll([
      HeaderInterceptor(_appConfig, _deviceInfoPlugin, _logger),
      AuthInterceptor(secureStorage: _secureStorage, logger: _logger),
      CacheInterceptor(cacheManager: _cacheManager, logger: _logger),
      RetryInterceptor(logger: _logger),
      ErrorInterceptor(),
      if (_appConfig.enableLogging) LoggingInterceptor(_logger),
    ]);
  }

  // Generic GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      _logger.e('Get request failed $path', error: e);
      rethrow;
    }
  }

  // Generic POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      _logger.e('Post request failed $path', error: e);
      rethrow;
    }
  }

  // Generic PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      _logger.e('Put request failed $path', error: e);
      rethrow;
    }
  }

  // Generic DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _logger.e('Delete request failed $path', error: e);
      rethrow;
    }
  }

  // Generic PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _logger.e('Patch request failed $path', error: e);
      rethrow;
    }
  }

  // Generic HEAD request
  Future<Response<T>> head<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.head<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      _logger.e('Head request failed $path', error: e);
      rethrow;
    }
  }

  // Generic download request
  Future<Response> download(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      _logger.e('Download request failed $urlPath', error: e);
      rethrow;
    }
  }

  // Generic upload request
  Future<Response<T>> upload<T>(
    String path,
    FormData formData, {
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: formData,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } catch (e) {
      _logger.e('Upload request failed $path', error: e);
      rethrow;
    }
  }

  // Set Auth token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Remove Auth token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  void setLanguage(String language) {
    _dio.options.headers['Accept-Language'] = language;
  }

  void clearLanguage() {
    _dio.options.headers.remove('Accept-Language');
  }

  void setPlatform(String platform) {
    _dio.options.headers['Platform'] = platform;
  }

  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  void clearHeaders() {
    _dio.options.headers.clear();
  }

  void setQueryParameters(Map<String, dynamic> queryParameters) {
    _dio.options.queryParameters.addAll(queryParameters);
  }

  void clearQueryParameters() {
    _dio.options.queryParameters.clear();
  }
}
