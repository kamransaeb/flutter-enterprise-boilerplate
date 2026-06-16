// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'UploadResponse',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'id',
            'url',
            'file_name',
            'original_name',
            'file_size',
            'mime_type',
            'path',
            'thumb_url',
            'medium_url',
            'large_url',
            'metadata',
            'uploaded_at',
          ],
        );
        final val = UploadResponse(
          id: $checkedConvert('id', (v) => v as String?),
          url: $checkedConvert('url', (v) => v as String?),
          fileName: $checkedConvert('file_name', (v) => v as String?),
          originalName: $checkedConvert('original_name', (v) => v as String?),
          fileSize: $checkedConvert('file_size', (v) => (v as num?)?.toInt()),
          mimeType: $checkedConvert('mime_type', (v) => v as String?),
          path: $checkedConvert('path', (v) => v as String?),
          thumbUrl: $checkedConvert('thumb_url', (v) => v as String?),
          mediumUrl: $checkedConvert('medium_url', (v) => v as String?),
          largeUrl: $checkedConvert('large_url', (v) => v as String?),
          metadata: $checkedConvert(
            'metadata',
            (v) => v as Map<String, dynamic>?,
          ),
          uploadedAt: $checkedConvert(
            'uploaded_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'fileName': 'file_name',
        'originalName': 'original_name',
        'fileSize': 'file_size',
        'mimeType': 'mime_type',
        'thumbUrl': 'thumb_url',
        'mediumUrl': 'medium_url',
        'largeUrl': 'large_url',
        'uploadedAt': 'uploaded_at',
      },
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'file_name': instance.fileName,
      'original_name': instance.originalName,
      'file_size': instance.fileSize,
      'mime_type': instance.mimeType,
      'path': instance.path,
      'thumb_url': instance.thumbUrl,
      'medium_url': instance.mediumUrl,
      'large_url': instance.largeUrl,
      'metadata': instance.metadata,
      'uploaded_at': instance.uploadedAt?.toIso8601String(),
    };

BatchUploadResponse _$BatchUploadResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('BatchUploadResponse', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['uploads', 'failed', 'total']);
      final val = BatchUploadResponse(
        uploads: $checkedConvert(
          'uploads',
          (v) => (v as List<dynamic>)
              .map((e) => UploadResponse.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        failed: $checkedConvert(
          'failed',
          (v) => (v as List<dynamic>?)
              ?.map((e) => FailedUpload.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        total: $checkedConvert('total', (v) => (v as num).toInt()),
      );
      return val;
    });

Map<String, dynamic> _$BatchUploadResponseToJson(
  BatchUploadResponse instance,
) => <String, dynamic>{
  'uploads': instance.uploads.map((e) => e.toJson()).toList(),
  'failed': instance.failed?.map((e) => e.toJson()).toList(),
  'total': instance.total,
};

FailedUpload _$FailedUploadFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FailedUpload', json, ($checkedConvert) {
      $checkKeys(json, allowedKeys: const ['filename', 'error', 'error_code']);
      final val = FailedUpload(
        filename: $checkedConvert('filename', (v) => v as String),
        error: $checkedConvert('error', (v) => v as String),
        errorCode: $checkedConvert('error_code', (v) => v as String?),
      );
      return val;
    }, fieldKeyMap: const {'errorCode': 'error_code'});

Map<String, dynamic> _$FailedUploadToJson(FailedUpload instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'error': instance.error,
      'error_code': instance.errorCode,
    };
