import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor(this._logger);

  final LoggerService _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('''
🌐 Request:
  URL: ${options.uri}
  Method: ${options.method}
  Headers: ${options.headers}
  Data: ${options.data}
  Query Parameters: ${options.queryParameters}
''');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('''
✅ Response:
  URL: ${response.requestOptions.uri}
  Status: ${response.statusCode}
  Headers: ${response.headers}
  Data: ${response.data}
''');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('''
❌ Error:
  URL: ${err.requestOptions.uri}
  Method: ${err.requestOptions.method}
  Error: ${err.error}
  Response: ${err.response?.data}
  Status Code: ${err.response?.statusCode}
  Stack Trace: ${err.stackTrace}
''');
    handler.next(err);
  }
}
