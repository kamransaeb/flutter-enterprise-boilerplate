import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/exceptions/network_exceptions.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/empty_response.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/upload_response.dart';
import 'api_response.dart';
import 'error_response.dart';
import 'paginated_response.dart';

/// Response converter for handling different response types
class ResponseConverter {
  const ResponseConverter._();

  /// Convert Dio response to ApiResponse
  static ApiResponse<T> toApiResponse<T>(
    Response response,
    T Function(dynamic) fromJson,
  ) {
    try {
      final data = response.data;

      // If response is already in ApiResponse format
      if (data is Map<String, dynamic>) {
        // Handle standard API response format
        if (data.containsKey('data') ||
            data.containsKey('status') ||
            data.containsKey('status_code')) {
          return ApiResponse<T>.fromJson(data, (json) => fromJson(json));
        }

        // Handle direct data response
        return ApiResponse<T>(
          status: 'success',
          data: fromJson(data),
          statusCode: response.statusCode,
          timestamp: DateTime.now(),
          path: response.requestOptions.path,
        );
      }

      // Handle list response
      if (data is List) {
        return ApiResponse<T>(
          status: 'success',
          data: fromJson(data),
          statusCode: response.statusCode,
          timestamp: DateTime.now(),
          path: response.requestOptions.path,
        );
      }

      // Handle empty response

      return ApiResponse<T>(
        status: 'success',
        statusCode: response.statusCode,
        timestamp: DateTime.now(),
        path: response.requestOptions.path,
      );
    } catch (e) {
      return ApiResponse<T>(
        status: 'error',
        statusCode: response.statusCode,
        timestamp: DateTime.now(),
        path: response.requestOptions.path,
        error: ErrorResponse(
          code: 'PARSE_ERROR',
          message: 'Failed to parse response: ${e.toString()}',
        ),
      );
    }
  }

  /// Convert Dio response to PaginatedResponse
  static PaginatedResponse<T> toPaginatedResponse<T>(
    Response response,
    T Function(dynamic) fromJson,
  ) {
    try {
      final data = response.data;

      // If response is already in PaginatedResponse format
      if (data is Map<String, dynamic> &&
          data.containsKey('data') &&
          data.containsKey('meta')) {
        return PaginatedResponse<T>.fromJson(data, (json) => fromJson(json));
      }
      if (data is Map<String, dynamic>) {
        // Handle paginated response
        if (data.containsKey('data') && data.containsKey('meta')) {
          return PaginatedResponse<T>.fromJson(data, (json) => fromJson(json));
        }
      }

      // If response is a list, wrap in paginated response
      if (data is List) {
        final items = data.map((json) => fromJson(json)).toList();
        return items.toPaginatedResponse(
          page: 1,
          perPage: data.length,
          total: data.length,
        );
      }
      throw FormatException('Invalid paginated response format');
    } catch (e) {
      throw ResponseParsingException(
        message: 'Failed to parse paginated response: ${e.toString()}',
        code: 'PARSE_ERROR',
        endpoint: response.requestOptions.path,
        method: response.requestOptions.method,
      );
    }
  }

  /// Convert error response
  static ErrorResponse toErrorResponse(Response? response) {
    if (response?.data == null) {
      return ErrorResponse(
        code: response?.statusCode?.toString() ?? 'NO_RESPONSE',
        message:
            response?.statusMessage?.toString() ?? 'No response from server',
      );
    }

    try {
      final data = response!.data;

      if (data is Map<String, dynamic>) {
        if (data.containsKey('error') || data.containsKey('errors')) {
          // Hanlde standard error format
          return ErrorResponse.fromJson(data);
        }

        // Handle simple error message
        if (data.containsKey('message')) {
          return ErrorResponse(
            code: response.statusCode?.toString() ?? 'UNKNOWN_ERROR',
            message: data['message'] as String?,
            errors: data.containsKey('errors')
                ? data['errors'] as List<ValidationError>?
                : null,
          );
        }

        // Handle validation errors
        if (data.containsKey('errors') &&
            data['errors'] is Map<String, dynamic>) {
          final validationErrors = <ValidationError>[];

          (data['errors'] as Map<String, dynamic>).forEach((key, value) {
            if (value is List) {
              for (final item in value) {
                final validationError = item is Map<String, dynamic>
                    ? ValidationError.fromJson(item)
                    : ValidationError(field: key, message: item as String?);
                validationErrors.add(validationError);
              }
            } else if (value is String) {
              validationErrors.add(
                ValidationError(field: key.toString(), message: value),
              );
            }
          });
          return ErrorResponse(
            code: response.statusCode?.toString() ?? 'VALIDATION_ERROR',
            message: data['errors']['message'] as String?,
            errors: validationErrors,
          );
        }
      }

      // Handle String response
      if (data is String) {
        return ErrorResponse(
          code: response.statusCode?.toString() ?? 'UNKNOWN_ERROR',
          message: data,
        );
      }
      // Handle unknown error
      return ErrorResponse(
        code: response.statusCode?.toString() ?? 'UNKNOWN_ERROR',
        message: data.toString(),
      );
    } catch (e) {
      throw ResponseParsingException(
        message: 'Failed to parse error response: ${e.toString()}',
        code: 'PARSE_ERROR',
        endpoint: response?.requestOptions.path ?? 'UNKNOWN_ENDPOINT',
        method: response?.requestOptions.method ?? 'UNKNOWN_METHOD',
      );
    }
  }

  UploadResponse? toUploadResponse(Response? response) {
    final data = response?.data;
    try {
      if (data is Map<String, dynamic>) {
        return UploadResponse.fromJson(data);
      }
      throw FormatException('Invalid upload response format');
    } catch (e) {
      throw ResponseParsingException(
        message: 'Failed to parse upload response: ${e.toString()}',
        code: 'PARSE_ERROR',
        endpoint: response?.requestOptions.path ?? 'UNKNOWN_ENDPOINT',
        method: response?.requestOptions.method ?? 'UNKNOWN_METHOD',
      );
    }
  }

  /// Convert to empty response
  static EmptyResponse toEmptyResponse(Response? response) {
    try {
      if (response != null && response.data == null) {
        return EmptyResponse(
          success: response.statusCode! >= 200 && response.statusCode! < 300,
          message: response.statusMessage ?? 'No response from server',
          code: response.statusCode,
          timestamp: DateTime.now(),
        );
      }

      final data = response?.data;
      if (data is Map<String, dynamic>) {
        return EmptyResponse.fromJson(data);
      }

      return EmptyResponse(
        success: response!.statusCode! >= 200 && response!.statusCode! < 300,
        message: data.toString(),
        code: response!.statusCode,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      throw ResponseParsingException(
        message: 'Failed to parse empty response: ${e.toString()}',
        code: 'PARSE_ERROR',
        endpoint: response?.requestOptions.path ?? 'UNKNOWN_ENDPOINT',
        method: response?.requestOptions.method ?? 'UNKNOWN_METHOD',
      );
    }
  }

  /// Extract data from response
  static T? extractData<T>(dynamic response, T Function(dynamic) parser) {
    if (response is ApiResponse) {
      return response.data as T?;
    }
    if (response is PaginatedResponse) {
      return response.data as T?;
    }
    if (response is Map<String, dynamic>) {
      return parser(response);
    }
    return null;
  }
}
