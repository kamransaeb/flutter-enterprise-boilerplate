import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

/// Standard error response structure from API
@JsonSerializable()
class ErrorResponse extends Equatable {

  @JsonKey(name: 'code')
  final String? code;
  
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'details')
  final Map<String, dynamic>? details;
  
  @JsonKey(name: 'errors')
  final List<ValidationError>? errors;
  
  @JsonKey(name: 'debug_info')
  final Map<String, dynamic>? debugInfo;

  const ErrorResponse({
    this.code,
    this.message,
    this.details,
    this.errors,
    this.debugInfo,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  /// Get formatted error message
  String get formattedMessage {
    if (errors != null && errors!.isNotEmpty) {
      return errors!.map((e) => e.formattedMessage).join('\n');
    }
    return message ?? 'An unknown error occurred';
  }

  @override
  List<Object?> get props => [
        code,
        message,
        details,
        errors,
        debugInfo,
      ];
}

/// Validation error for specific fields
@JsonSerializable()
class ValidationError extends Equatable {
  @JsonKey(name: 'field')
  final String? field;
  
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'rejected_value')
  final dynamic rejectedValue;
  
  @JsonKey(name: 'constraints')
  final Map<String, String>? constraints;

  const ValidationError({
    this.field,
    this.message,
    this.rejectedValue,
    this.constraints,
  });

  factory ValidationError.fromJson(Map<String, dynamic> json) =>
      _$ValidationErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ValidationErrorToJson(this);

  /// Get formatted validation message
  String get formattedMessage {
    if (message != null) return '$field: $message';
    if (constraints != null && constraints!.isNotEmpty) {
      return '$field: ${constraints!.values.first}';
    }
    return '$field: Invalid value';
  }

  @override
  List<Object?> get props => [
        field,
        message,
        rejectedValue,
        constraints,
      ];
}

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'error_response.freezed.dart';
// part 'error_response.g.dart';

// @freezed
// class ErrorResponse with _$ErrorResponse {
//   const factory ErrorResponse({
//     required String message,
//     @Default('unknown') String code,
//     Map<String, List<String>>? errors,
//     @JsonKey(name: 'status_code') int? statusCode,
//     String? timestamp,
//     String? path,
//     String? stackTrace,
//   }) = _ErrorResponse;

//   factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
//       _$ErrorResponseFromJson(json);

//   factory ErrorResponse.fromDioException(dynamic error) {
//     if (error is Map<String, dynamic>) {
//       return ErrorResponse.fromJson(error);
//     }

//     return ErrorResponse(
//       message: error.toString(),
//       code: 'parse_error',
//     );
//   }

//   String getFormattedErrors() {
//     if (errors == null || errors!.isEmpty) {
//       return message;
//     }

//     final buffer = StringBuffer();
//     buffer.writeln(message);
//     buffer.writeln();

//     errors!.forEach((field, fieldErrors) {
//       buffer.writeln('• $field:');
//       for (final error in fieldErrors) {
//         buffer.writeln('  - $error');
//       }
//     });

//     return buffer.toString();
//   }

//   bool get hasFieldErrors => errors != null && errors!.isNotEmpty;

//   List<String>? getFieldErrors(String fieldName) {
//     return errors?[fieldName];
//   }

//   String? getFirstFieldError(String fieldName) {
//     final fieldErrors = getFieldErrors(fieldName);
//     return fieldErrors?.isNotEmpty == true ? fieldErrors!.first : null;
//   }

//   Map<String, String> getFieldErrorsMap() {
//     if (errors == null) return {};
    
//     final map = <String, String>{};
//     errors!.forEach((field, fieldErrors) {
//       if (fieldErrors.isNotEmpty) {
//         map[field] = fieldErrors.first;
//       }
//     });
    
//     return map;
//   }
// }

// class ApiError implements Exception {
//   final ErrorResponse errorResponse;

//   ApiError(this.errorResponse);

//   @override
//   String toString() => errorResponse.message;
// }

// class ValidationError extends ApiError {
//   ValidationError(ErrorResponse errorResponse) : super(errorResponse);

//   Map<String, String> get fieldErrors => errorResponse.getFieldErrorsMap();
// }

// class AuthenticationError extends ApiError {
//   AuthenticationError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class AuthorizationError extends ApiError {
//   AuthorizationError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class NotFoundError extends ApiError {
//   NotFoundError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class ServerError extends ApiError {
//   ServerError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class NetworkError extends ApiError {
//   NetworkError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class TimeoutError extends ApiError {
//   TimeoutError(ErrorResponse errorResponse) : super(errorResponse);
// }

// class RateLimitError extends ApiError {
//   final Duration retryAfter;

//   RateLimitError(ErrorResponse errorResponse, this.retryAfter)
//       : super(errorResponse);
// }
