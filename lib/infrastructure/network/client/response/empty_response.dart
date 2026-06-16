import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'empty_response.g.dart';

/// Empty response for endpoints that return no data
@JsonSerializable()
class EmptyResponse extends Equatable {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'timestamp')
  final DateTime? timestamp;

  @JsonKey(name: 'message')
  final String? message;

  const EmptyResponse({
    this.success = true,
    this.message,
    this.code,
    this.timestamp,
  });

  factory EmptyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EmptyResponseToJson(this);

  /// Success empty response
  //static const EmptyResponse success = EmptyResponse(success: true);
  
  /// Failed empty response with message
  factory EmptyResponse.failed(String message) {
    return EmptyResponse(
      success: false,
      message: message,
      code: 400,
      timestamp: DateTime.now(),
    );
  }

  /// Success empty response
  factory EmptyResponse.success({String? message}) {
    return EmptyResponse(
      success: true,
      code: 200,
      timestamp: DateTime.now(),
      message: message ?? 'Operation completed successfully',
    );
  }

  /// Deleted empty response
  factory EmptyResponse.deleted({String? message}) {
    return EmptyResponse(
      success: true,
      code: 204,
      timestamp: DateTime.now(),
      message: message ?? 'Resource deleted successfully',
    );
  }

  /// Created empty response
  factory EmptyResponse.created({String? message}) {
    return EmptyResponse(
      success: true,
      code: 201,
      timestamp: DateTime.now(),
      message: message ?? 'Resource created successfully',
    );
  }
  @override
  List<Object?> get props => [success, message, code, timestamp];
}