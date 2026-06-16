import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_response.g.dart';

/// File upload response
@JsonSerializable()
class UploadResponse extends Equatable {
 
  final String? id;
  final String? url;
  @JsonKey(name: 'file_name')
  final String? fileName;
  @JsonKey(name: 'original_name')
  final String? originalName;
  @JsonKey(name: 'file_size')
  final int? fileSize;
  @JsonKey(name: 'mime_type')
  final String? mimeType;
  final String? path;
  @JsonKey(name: 'thumb_url')
  final String? thumbUrl;
  @JsonKey(name: 'medium_url')
  final String? mediumUrl;
  @JsonKey(name: 'large_url')
  final String? largeUrl;
  final Map<String, dynamic>? metadata;
  @JsonKey(name: 'uploaded_at')
  final DateTime? uploadedAt;

  const UploadResponse({
    this.id,
    this.url,
    this.fileName,
    this.originalName,
    this.fileSize,
    this.mimeType,
    this.path,
    this.thumbUrl,
    this.mediumUrl,
    this.largeUrl,
    this.metadata,
    this.uploadedAt,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);

  bool get isImage => mimeType?.startsWith('image/') ?? false;
  bool get isVideo => mimeType?.startsWith('video/') ?? false;
  bool get isDocument => !isImage && !isVideo;

  String get formattedFileSize {
    if (fileSize == null) return 'Unknown size';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    var i = 0;
    var size = fileSize!.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  @override
  List<Object?> get props => [
        id,
        url,
        fileName,
        originalName,
        fileSize,
        mimeType,
        path,
        thumbUrl,
        mediumUrl,
        largeUrl,
        metadata,
        uploadedAt,
      ];
}

/// Batch upload response
@JsonSerializable()
class BatchUploadResponse extends Equatable {
  @JsonKey(name: 'uploads')
  final List<UploadResponse> uploads;
  
  @JsonKey(name: 'failed')
  final List<FailedUpload>? failed;
  
  @JsonKey(name: 'total')
  final int total;

  const BatchUploadResponse({
    required this.uploads,
    this.failed,
    required this.total,
  });

  factory BatchUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BatchUploadResponseToJson(this);

  /// Check if all uploads succeeded
  bool get allSucceeded => failed == null || failed!.isEmpty;

  /// Get number of successful uploads
  int get successfulCount => uploads.length;

  @override
  List<Object?> get props => [uploads, failed, total];
}

/// Failed upload information
@JsonSerializable()
class FailedUpload extends Equatable {
  @JsonKey(name: 'filename')
  final String filename;
  
  @JsonKey(name: 'error')
  final String error;
  
  @JsonKey(name: 'error_code')
  final String? errorCode;

  const FailedUpload({
    required this.filename,
    required this.error,
    this.errorCode,
  });

  factory FailedUpload.fromJson(Map<String, dynamic> json) =>
      _$FailedUploadFromJson(json);

  Map<String, dynamic> toJson() => _$FailedUploadToJson(this);

  @override
  List<Object?> get props => [filename, error, errorCode];
}