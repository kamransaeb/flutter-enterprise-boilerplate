import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';
import '../../../core/constants/regex_constants.dart';

/// JSON transformer for handling JSON serialization/deserialization
@singleton
class JsonTransformer {

  JsonTransformer();

  /// Transform response to JSON
  Map<String, dynamic> toJson(dynamic data) {
    try {
      if (data == null) {
        return {};
      }
      
      if (data is Map<String, dynamic>) {
        return data;
      }
      
      if (data is String) {
        if (data.trim().isEmpty) {
          return {};
        }
        return json.decode(data) as Map<String, dynamic>;
      }
      
      if (data is Response) {
        return toJson(data.data);
      }
      
      throw ArgumentError('Cannot convert ${data.runtimeType} to JSON');
    } catch (e, stackTrace) {
      logger.e('Failed to convert to JSON', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Transform response to JSON list
  List<dynamic> toJsonList(dynamic data) {
    try {
      if (data == null) {
        return [];
      }
      
      if (data is List) {
        return data;
      }
      
      if (data is String) {
        if (data.trim().isEmpty) {
          return [];
        }
        final decoded = json.decode(data);
        if (decoded is List) {
          return decoded;
        }
        throw FormatException('Decoded value is not a List');
      }
      
      if (data is Response) {
        return toJsonList(data.data);
      }
      
      throw ArgumentError('Cannot convert ${data.runtimeType} to JSON List');
    } catch (e, stackTrace) {
      logger.e('Failed to convert to JSON list', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Sanitize JSON string
  String sanitizeJsonString(String jsonString) {
    // Remove BOM if present
    if (jsonString.startsWith('\uFEFF')) {
      jsonString = jsonString.substring(1);
    }
    
    // Remove null bytes
    jsonString = jsonString.replaceAll(RegexConstants.nullBytePattern, '');
    
    // Fix common JSON issues
    jsonString = _fixJsonIssues(jsonString);
    
    return jsonString;
  }

  /// Fix common JSON formatting issues
  String _fixJsonIssues(String jsonString) {
    // Fix trailing commas
    jsonString = jsonString.replaceAll(RegexConstants.trailingCommaPattern, '}');
    jsonString = jsonString.replaceAll(RegexConstants.trailingCommaArrayPattern, ']');
    
    // Fix single quotes (only if not inside strings)
    // This is a simplified approach - in production, use a proper JSON parser
    if (!jsonString.contains('"')) {
      jsonString = jsonString.replaceAll("'", '"');
    }
    
    // Fix unquoted keys
    jsonString = jsonString.replaceAllMapped(
      RegexConstants.unquotedKeyPattern,
      (match) => '"${match.group(1)}":',
    );
    
    return jsonString;
  }

  /// Pretty print JSON
  String prettyPrint(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json);
    } catch (e, stackTrace) {
      logger.e('Failed to pretty print JSON', error: e, stackTrace: stackTrace);
      return json.toString();
    }
  }

  /// Minify JSON
  String minify(Map<String, dynamic> json) {
    try {
      const encoder = JsonEncoder();
      return encoder.convert(json);
    } catch (e, stackTrace) {
      logger.e('Failed to minify JSON', error: e, stackTrace: stackTrace);
      return json.toString();
    }
  }
}