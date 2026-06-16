import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/exceptions/api_exceptions.dart';
import 'package:injectable/injectable.dart';

/// Interceptor to handle errors from the network.
@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Transform error to AppExcetpion
    final transformedError = _transformError(err);

    // Reject with transformed error
    handler.reject(transformedError);
  }

  DioException _transformError(DioException error) {
    final requestOptions = error.requestOptions;
    final response = error.response;

    // Network error
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return DioException(
        requestOptions: requestOptions,
        error: ApiException(
          message:
              'Request timeout. Please check your connection and try again',
          statusCode: 408,
        ),
        type: error.type,
        response: response,
      );
    }

    // No internet connection
    if (error.type == DioExceptionType.connectionError) {
      return DioException(
        requestOptions: requestOptions,
        error: ApiException(
          message:
              'No internet connection. Please check your connection and try again',
          statusCode: 0,
        ),
        type: error.type,
        response: response,
      );
    }

    // Request cancelled
    if (error.type == DioExceptionType.cancel) {
      return DioException(
        requestOptions: requestOptions,
        error: ApiException(
          message: 'Request cancelled. Please try again.',
          statusCode: 400,
        ),
        type: error.type,
        response: response,
      );
    }

    // Handle response errors
    if (response != null) {
      final statusCode = response.statusCode;
      return DioException(
        requestOptions: requestOptions,
        error: ApiException(
          message: response.statusMessage ?? 'Error $statusCode occurred.',
          statusCode: statusCode!,
          responseData: response.data,
        ),
        type: DioExceptionType.badResponse,
        response: response,
      );
    } else {
      // Unknown error
      return DioException(
        requestOptions: requestOptions,
        error: ApiException(
          message: error.message ?? 'An unexpected error occurred.',
          statusCode: error.response?.statusCode ?? 500,
        ),
        type: error.type,
        response: response,
      );
    }
  }
}
