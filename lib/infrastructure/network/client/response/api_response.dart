// import 'package:freezed_annotation/freezed_annotation.dart';

// part '../../response/api_response.freezed.dart';
// part '../../response/api_response.g.dart';

// @freezed
// class ApiResponse<T> with _$ApiResponse<T> {
//   const factory ApiResponse.success({
//     required T data,
//     required String message,
//     @Default(200) int statusCode,
//     String? token,
//   }) = ApiSuccess<T>;

//   const factory ApiResponse.error({
//     required String message,
//     @Default(400) int statusCode,
//     dynamic errors,
//     String? code,
//   }) = ApiError<T>;

//   const factory ApiResponse.loading() = ApiLoading<T>;

//   factory ApiResponse.fromJson(Map<String, dynamic> json) {
//     return _$ApiResponseFromJson<T>(json);
//   }
// }

// class PaginatedResponse<T> {
//   final List<T> items;
//   final int currentPage;
//   final int totalPages;
//   final int totalItems;
//   final int itemsPerPage;
//   final bool hasNextPage;
//   final bool hasPreviousPage;

//   PaginatedResponse({
//     required this.items,
//     required this.currentPage,
//     required this.totalPages,
//     required this.totalItems,
//     required this.itemsPerPage,
//   })  : hasNextPage = currentPage < totalPages,
//         hasPreviousPage = currentPage > 1;

//   PaginatedResponse.empty()
//       : items = [],
//         currentPage = 1,
//         totalPages = 1,
//         totalItems = 0,
//         itemsPerPage = 20,
//         hasNextPage = false,
//         hasPreviousPage = false;

//   Map<String, dynamic> toJson(T Function(T) toJsonT) {
//     return {
//       'items': items.map(toJsonT).toList(),
//       'current_page': currentPage,
//       'total_pages': totalPages,
//       'total_items': totalItems,
//       'items_per_page': itemsPerPage,
//     };
//   }

//   factory PaginatedResponse.fromJson(
//     Map<String, dynamic> json,
//     T Function(Map<String, dynamic>) fromJsonT,
//   ) {
//     return PaginatedResponse(
//       items: (json['items'] as List)
//           .map((item) => fromJsonT(item as Map<String, dynamic>))
//           .toList(),
//       currentPage: json['current_page'] as int,
//       totalPages: json['total_pages'] as int,
//       totalItems: json['total_items'] as int,
//       itemsPerPage: json['items_per_page'] as int,
//     );
//   }
// }




// // import 'package:dio/dio.dart';
// // import 'package:equatable/equatable.dart';

// // /// Standard API response wrapper
// // class ApiResponse<T> extends Equatable {
// //   final T? data;
// //   final bool isSuccess;
// //   final String? errorMessage;
// //   final int? statusCode;
// //   final String? errorCode;
// //   final Map<String, List<String>>? errors;

// //   const ApiResponse({
// //     this.data,
// //     required this.isSuccess,
// //     this.errorMessage,
// //     this.statusCode,
// //     this.errorCode,
// //     this.errors,
// //   });

// //   factory ApiResponse.success(T data) {
// //     return ApiResponse(
// //       data: data,
// //       isSuccess: true,
// //     );
// //   }

// //   factory ApiResponse.error(
// //     String message, {
// //     int? statusCode,
// //     String? errorCode,
// //     Map<String, List<String>>? errors,
// //   }) {
// //     return ApiResponse(
// //       isSuccess: false,
// //       errorMessage: message,
// //       statusCode: statusCode,
// //       errorCode: errorCode,
// //       errors: errors,
// //     );
// //   }

// //   factory ApiResponse.fromResponse(Response response) {
// //     try {
// //       final data = response.data as Map<String, dynamic>;
      
// //       // Check if response has success flag or status
// //       final isSuccess = response.statusCode != null &&
// //           response.statusCode! >= 200 &&
// //           response.statusCode! < 300;

// //       if (isSuccess) {
// //         return ApiResponse(
// //           data: data,
// //           isSuccess: true,
// //           statusCode: response.statusCode,
// //         );
// //       }

// //       // Handle error response
// //       final errorMessage = data['message'] ?? data['error'] ?? 'Unknown error';
// //       final errorCode = data['code']?.toString();
// //       final errors = (data['errors'] as Map<String, dynamic>?)?.map(
// //         (key, value) => MapEntry(key, List<String>.from(value)),
// //       );

// //       return ApiResponse(
// //         isSuccess: false,
// //         errorMessage: errorMessage,
// //         statusCode: response.statusCode,
// //         errorCode: errorCode,
// //         errors: errors,
// //       );
// //     } catch (e) {
// //       return ApiResponse(
// //         isSuccess: false,
// //         errorMessage: 'Failed to parse response: $e',
// //         statusCode: response.statusCode,
// //       );
// //     }
// //   }

// //   factory ApiResponse.fromError(DioException error) {
// //     String errorMessage;
// //     int? statusCode;
// //     String? errorCode;

// //     switch (error.type) {
// //       case DioExceptionType.connectionTimeout:
// //         errorMessage = 'Connection timeout';
// //         break;
// //       case DioExceptionType.sendTimeout:
// //         errorMessage = 'Send timeout';
// //         break;
// //       case DioExceptionType.receiveTimeout:
// //         errorMessage = 'Receive timeout';
// //         break;
// //       case DioExceptionType.badResponse:
// //         statusCode = error.response?.statusCode;
// //         errorMessage = _extractErrorMessage(error.response?.data);
// //         errorCode = _extractErrorCode(error.response?.data);
// //         break;
// //       case DioExceptionType.cancel:
// //         errorMessage = 'Request cancelled';
// //         break;
// //       case DioExceptionType.connectionError:
// //         errorMessage = 'No internet connection';
// //         break;
// //       case DioExceptionType.unknown:
// //         errorMessage = 'Unknown error occurred';
// //         break;
// //       default:
// //         errorMessage = 'Something went wrong';
// //     }

// //     return ApiResponse(
// //       isSuccess: false,
// //       errorMessage: errorMessage,
// //       statusCode: statusCode,
// //       errorCode: errorCode,
// //     );
// //   }

// //   static String _extractErrorMessage(dynamic data) {
// //     if (data == null) return 'Server error';
// //     if (data is String) return data;
// //     if (data is Map) {
// //       return data['message'] ?? data['error'] ?? 'Server error';
// //     }
// //     return 'Server error';
// //   }

// //   static String? _extractErrorCode(dynamic data) {
// //     if (data is Map && data['code'] != null) {
// //       return data['code'].toString();
// //     }
// //     return null;
// //   }

// //   @override
// //   List<Object?> get props => [
// //         data,
// //         isSuccess,
// //         errorMessage,
// //         statusCode,
// //         errorCode,
// //         errors,
// //       ];
// // }



import 'package:equatable/equatable.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/error_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

/// Generic API Response wrapper for all API responses
@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> extends Equatable {
  @JsonKey(name: 'status')
  final String? status;
  
  @JsonKey(name: 'message')
  final String? message;
  
  @JsonKey(name: 'data')
  final T? data;
  
  @JsonKey(name: 'status_code')
  final int? statusCode;
  
  @JsonKey(name: 'timestamp')
  final DateTime? timestamp;
  
  @JsonKey(name: 'path')
  final String? path;
  
  @JsonKey(name: 'error')
  final ErrorResponse? error;

  const ApiResponse({
    this.status,
    this.message,
    this.data,
    this.statusCode,
    this.timestamp,
    this.path,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  /// Check if the response is successful
  bool get isSuccess {
    return statusCode != null && statusCode! >= 200 && statusCode! < 300;
  }

  /// Check if the response has data
  bool get hasData => data != null;

  /// Get the error message if any
  String get errorMessage {
    if (error != null) return error!.message ?? 'Unknown error';
    if (message != null) return message!;
    return 'An error occurred';
  }

  @override
  List<Object?> get props => [
        status,
        message,
        data,
        statusCode,
        timestamp,
        path,
        error,
      ];
}

/// Success Response Wrapper
class SuccessResponse<T> extends ApiResponse<T> {
  const SuccessResponse({
    required T data,
    String? message,
    int? statusCode,
    DateTime? timestamp,
    String? path,
  }) : super(
          status: 'success',
          data: data,
          message: message,
          statusCode: statusCode,
          timestamp: timestamp,
          path: path,
        );

  /// Create success response with data
  factory SuccessResponse.fromData(T data) {
    return SuccessResponse(
      data: data,
      statusCode: 200,
      timestamp: DateTime.now(),
    );
  }

  /// Create success response with custom message
  factory SuccessResponse.withMessage({
    required T data,
    required String message,
    int statusCode = 200,
  }) {
    return SuccessResponse(
      data: data,
      message: message,
      statusCode: statusCode,
      timestamp: DateTime.now(),
    );
  }
}

/// Error Response Wrapper
class ErrorApiResponse<T> extends ApiResponse<T> {
  const ErrorApiResponse({
    required ErrorResponse error,
    String? message,
    int? statusCode,
    DateTime? timestamp,
    String? path,
  }) : super(
          status: 'error',
          error: error,
          message: message,
          statusCode: statusCode,
          timestamp: timestamp,
          path: path,
        );

  /// Create error response from exception
  factory ErrorApiResponse.fromException(
    dynamic exception, {
    StackTrace? stackTrace,
    int? statusCode,
    String? path,
  }) {
    final errorResponse = ErrorResponse(
      code: statusCode?.toString() ?? 'UNKNOWN_ERROR',
      message: exception.toString(),
      details: {'exception': exception.runtimeType.toString()},
      debugInfo: {'stack_trace': stackTrace?.toString()},
      );
    return ErrorApiResponse(
      error: errorResponse,
      statusCode: statusCode ?? 500,
      timestamp: DateTime.now(),
      path: path,
    );
  }
}
