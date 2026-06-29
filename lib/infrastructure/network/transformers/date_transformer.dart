import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';


/// Custom JSON converter for DateTime fields
class DateTransformer {
  static LoggerService get _logger => getIt<LoggerService>();
  static const _defaultFormat = 'yyyy-MM-dd HH:mm:ss';
  static const _isoFormat = 'yyyy-MM-ddTHH:mm:ss.SSSZ';
  static const _utcFormat = 'yyyy-MM-ddTHH:mm:ssZ';
  static const _dateOnlyFormat = 'yyyy-MM-dd';
  

  /// Convert DateTime to ISO 8601 string
  static String? dateTimeToString(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.toIso8601String();
  }

  /// Convert ISO 8601 string to DateTime
  static DateTime? dateTimeFromString(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return null;
    
    try {
      // Try parsing ISO 8601 format
      return DateTime.parse(dateTimeString);
    } catch (e) {
      try {
        // Try alternative formats
        final formats = [
          _defaultFormat,
          _isoFormat,
          _utcFormat,
          _dateOnlyFormat,
          'dd/MM/yyyy HH:mm:ss',
          'MM/dd/yyyy HH:mm:ss',
          'yyyy/MM/dd HH:mm:ss',
        ];
        
        for (final format in formats) {
          try {
            return DateFormat(format).parse(dateTimeString);
          } catch (_) {}
        }
        
        _logger.w('Failed to parse date: $dateTimeString');
        return null;
      } catch (e, stackTrace) {
        _logger.w('Failed to parse date: $dateTimeString', error: e, stackTrace: stackTrace);
        return null;
      }
    }
  }

  /// Convert timestamp to DateTime
  static DateTime? timestampFromInt(int? timestamp) {
    if (timestamp == null || timestamp == 0) return null;
    
    try {
      // Check if timestamp is in milliseconds or seconds
      if (timestamp.toString().length == 10) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      }
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    } catch (e, stackTrace) {
      _logger.w('Failed to parse timestamp: $timestamp - $e', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  /// Convert DateTime to timestamp
  static int? dateTimeToTimestamp(DateTime? dateTime) {
    if (dateTime == null) return null;
    return dateTime.millisecondsSinceEpoch;
  }

  /// Format DateTime to custom string
  static String? formatDateTime(
    DateTime? dateTime, {
    String format = _defaultFormat,
  }) {
    if (dateTime == null) return null;
    return DateFormat(format).format(dateTime);
  }
}

/// JSON converter for nullable DateTime
class NullableDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    return DateTransformer.dateTimeFromString(json);
  }

  @override
  String? toJson(DateTime? object) {
    return DateTransformer.dateTimeToString(object);
  }
}

/// JSON converter for non-nullable DateTime
class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTransformer.dateTimeFromString(json) ?? DateTime.now();
  }

  @override
  String toJson(DateTime object) {
    return DateTransformer.dateTimeToString(object) ?? '';
  }
}

/// JSON converter for timestamp (int) to DateTime
class TimestampConverter implements JsonConverter<DateTime?, int?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(int? json) {
    return DateTransformer.timestampFromInt(json);
  }

  @override
  int? toJson(DateTime? object) {
    return DateTransformer.dateTimeToTimestamp(object);
  }
}