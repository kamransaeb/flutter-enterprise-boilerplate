// lib/infrastructure/services/deep_link_validation_response.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'deep_link_validation_response.freezed.dart';
part 'deep_link_validation_response.g.dart';

/// Deep link validation result status
enum DeepLinkValidationStatus {
  @JsonValue('valid')
  valid,
  
  @JsonValue('expired')
  expired,
  
  @JsonValue('invalid')
  invalid,
  
  @JsonValue('revoked')
  revoked,
  
  @JsonValue('rate_limited')
  rateLimited,
  
  @JsonValue('requires_auth')
  requiresAuth,
  
  @JsonValue('requires_permission')
  requiresPermission,
  
  @JsonValue('maintenance')
  maintenance,
  
  @JsonValue('region_blocked')
  regionBlocked,
  
  @JsonValue('version_required')
  versionRequired,
  
  @JsonValue('version_update_required')
  versionUpdateRequired,
  
  @JsonValue('device_not_supported')
  deviceNotSupported,
  
  @JsonValue('already_used')
  alreadyUsed,
  
  @JsonValue('user_not_found')
  userNotFound,
  
  @JsonValue('content_not_found')
  contentNotFound,
  
  @JsonValue('quota_exceeded')
  quotaExceeded,
}

/// Deep link type classification
enum DeepLinkType {
  @JsonValue('product')
  product,
  
  @JsonValue('profile')
  profile,
  
  @JsonValue('order')
  order,
  
  @JsonValue('payment')
  payment,
  
  @JsonValue('promotion')
  promotion,
  
  @JsonValue('invite')
  invite,
  
  @JsonValue('referral')
  referral,
  
  @JsonValue('notification')
  notification,
  
  @JsonValue('message')
  message,
  
  @JsonValue('settings')
  settings,
  
  @JsonValue('support')
  support,
  
  @JsonValue('external')
  external,
  
  @JsonValue('deeplink')
  deeplink,
  
  @JsonValue('universal_link')
  universalLink,
  
  @JsonValue('custom_scheme')
  customScheme,
}

/// Required app version info for deep link
@freezed
abstract class RequiredVersionInfo with _$RequiredVersionInfo {
  const factory RequiredVersionInfo({
    @JsonKey(name: 'minimum_version') required String minimumVersion,
    @JsonKey(name: 'latest_version') String? latestVersion,
    @JsonKey(name: 'update_url') String? updateUrl,
    @JsonKey(name: 'is_force_update') @Default(false) bool isForceUpdate,
    @JsonKey(name: 'release_notes') String? releaseNotes,
    @JsonKey(name: 'update_deadline') DateTime? updateDeadline,
  }) = _RequiredVersionInfo;
  
  factory RequiredVersionInfo.fromJson(Map<String, dynamic> json) =>
      _$RequiredVersionInfoFromJson(json);
}

/// Deep link payload data structure
@freezed
abstract class DeepLinkPayload with _$DeepLinkPayload {
  const factory DeepLinkPayload({
    /// Resource ID (product ID, user ID, order ID, etc.)
    String? id,
    
    /// Resource type specific data
    @JsonKey(name: 'resource_type') String? resourceType,
    
    /// Additional parameters
    Map<String, dynamic>? params,
    
    /// Query parameters from the URL
    @JsonKey(name: 'query_params') Map<String, String>? queryParams,
    
    /// Path segments
    @JsonKey(name: 'path_segments') List<String>? pathSegments,
    
    /// Fragment/Anchor
    String? fragment,
    
    /// Metadata about the link source
    @JsonKey(name: 'source') String? source,
    
    /// Campaign tracking parameters
    @JsonKey(name: 'campaign') String? campaign,
    
    /// Medium (email, sms, push, etc.)
    @JsonKey(name: 'medium') String? medium,
    
    /// Content identifier
    @JsonKey(name: 'content') String? content,
    
    /// Timestamp when link was generated
    @JsonKey(name: 'generated_at') DateTime? generatedAt,
    
    /// Expiration timestamp
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    
    /// Max number of uses (for one-time links)
    @JsonKey(name: 'max_uses') int? maxUses,
    
    /// Current number of uses
    @JsonKey(name: 'current_uses') int? currentUses,
    
    /// Custom data
    @JsonKey(name: 'custom_data') Map<String, dynamic>? customData,
  }) = _DeepLinkPayload;
  
  factory DeepLinkPayload.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkPayloadFromJson(json);
}

/// Error details when deep link validation fails
@freezed
abstract class DeepLinkError with _$DeepLinkError {
  const factory DeepLinkError({
    required String code,
    required String message,
    String? details,
    String? helpUrl,
    Map<String, dynamic>? metadata,
  }) = _DeepLinkError;
  
  factory DeepLinkError.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkErrorFromJson(json);
}

/// Complete deep link validation response
@freezed
abstract class DeepLinkValidationResponse with _$DeepLinkValidationResponse {
  const DeepLinkValidationResponse._();
  
  const factory DeepLinkValidationResponse({
    /// Validation status
    required DeepLinkValidationStatus status,
    
    /// Original deep link URL
    @JsonKey(name: 'original_url') required String originalUrl,
    
    /// Normalized/Canonical URL
    @JsonKey(name: 'canonical_url') String? canonicalUrl,
    
    /// Type of deep link
    @JsonKey(name: 'link_type') required DeepLinkType linkType,
    
    /// Validated payload data
    DeepLinkPayload? payload,
    
    /// Error details if validation failed
    DeepLinkError? error,
    
    /// Required version info if version required
    @JsonKey(name: 'required_version') RequiredVersionInfo? requiredVersion,
    
    /// Redirect URL if applicable
    @JsonKey(name: 'redirect_url') String? redirectUrl,
    
    /// Authentication required
    @JsonKey(name: 'requires_auth') @Default(false) bool requiresAuth,
    
    /// Required permissions
    @JsonKey(name: 'required_permissions') List<String>? requiredPermissions,
    
    /// Validation timestamp
    @JsonKey(name: 'validated_at') required DateTime validatedAt,
    
    /// TTL in seconds
    @JsonKey(name: 'ttl_seconds') int? ttlSeconds,
    
    /// Cache control headers
    @JsonKey(name: 'cache_control') String? cacheControl,
    
    /// Analytics tracking ID
    @JsonKey(name: 'tracking_id') String? trackingId,
    
    /// Metadata for analytics
    @JsonKey(name: 'metadata') Map<String, dynamic>? metadata,
    
    /// Suggested UI action (push, modal, etc.)
    @JsonKey(name: 'suggested_action') String? suggestedAction,
    
    /// Priority of the deep link (for queuing)
    @JsonKey(name: 'priority') @Default(0) int priority,
    
    /// Is this a deferred deep link
    @JsonKey(name: 'is_deferred') @Default(false) bool isDeferred,
    
    /// Fallback URL if app not installed
    @JsonKey(name: 'fallback_url') String? fallbackUrl,
    
    /// Web URL alternative
    @JsonKey(name: 'web_url') String? webUrl,
  }) = _DeepLinkValidationResponse;
  
  /// Create a successful validation response
  factory DeepLinkValidationResponse.success({
    required String originalUrl,
    required DeepLinkType linkType,
    DeepLinkPayload? payload,
    String? canonicalUrl,
    String? trackingId,
    Map<String, dynamic>? metadata,
    String? suggestedAction,
    bool? isDeferred,
    String? fallbackUrl,
    String? webUrl,
  }) {
    return DeepLinkValidationResponse(
      status: DeepLinkValidationStatus.valid,
      originalUrl: originalUrl,
      canonicalUrl: canonicalUrl,
      linkType: linkType,
      payload: payload,
      validatedAt: DateTime.now(),
      trackingId: trackingId,
      metadata: metadata,
      suggestedAction: suggestedAction,
      isDeferred: isDeferred ?? false,
      fallbackUrl: fallbackUrl,
      webUrl: webUrl,
    );
  }
  
  /// Create an error validation response
  factory DeepLinkValidationResponse.error({
    required String originalUrl,
    required DeepLinkValidationStatus status,
    required String errorCode,
    required String errorMessage,
    DeepLinkType? linkType,
    String? errorDetails,
    String? helpUrl,
    RequiredVersionInfo? requiredVersion,
    bool? requiresAuth,
    List<String>? requiredPermissions,
    Map<String, dynamic>? metadata,
  }) {
    return DeepLinkValidationResponse(
      status: status,
      originalUrl: originalUrl,
      linkType: linkType ?? DeepLinkType.deeplink,
      error: DeepLinkError(
        code: errorCode,
        message: errorMessage,
        details: errorDetails,
        helpUrl: helpUrl,
        metadata: metadata,
      ),
      requiredVersion: requiredVersion,
      requiresAuth: requiresAuth ?? false,
      requiredPermissions: requiredPermissions,
      validatedAt: DateTime.now(),
    );
  }
  
  /// Create validation response from JSON
  factory DeepLinkValidationResponse.fromJson(Map<String, dynamic> json) =>
      _$DeepLinkValidationResponseFromJson(json);
  
  /// Check if validation was successful
  bool get isValid => status == DeepLinkValidationStatus.valid;
  
  /// Check if validation failed
  bool get isInvalid => !isValid;
  
  /// Check if validation requires app update
  bool get requiresUpdate => 
      status == DeepLinkValidationStatus.versionRequired ||
      status == DeepLinkValidationStatus.versionUpdateRequired;
  
  /// Check if validation requires authentication
  bool get requiresAuthentication => 
      status == DeepLinkValidationStatus.requiresAuth || requiresAuth;
  
  /// Get user-friendly error message
  String getUserFriendlyMessage() {
    if (isValid) return '';
    
    return error?.message ?? _getDefaultErrorMessage();
  }
  
  String _getDefaultErrorMessage() {
    switch (status) {
      case DeepLinkValidationStatus.expired:
        return 'This link has expired.';
      case DeepLinkValidationStatus.invalid:
        return 'This link is invalid.';
      case DeepLinkValidationStatus.revoked:
        return 'This link has been revoked.';
      case DeepLinkValidationStatus.rateLimited:
        return 'Too many attempts. Please try again later.';
      case DeepLinkValidationStatus.requiresAuth:
        return 'Please sign in to continue.';
      case DeepLinkValidationStatus.requiresPermission:
        return 'You don\'t have permission to access this content.';
      case DeepLinkValidationStatus.maintenance:
        return 'This feature is currently under maintenance.';
      case DeepLinkValidationStatus.regionBlocked:
        return 'This content is not available in your region.';
      case DeepLinkValidationStatus.versionRequired:
      case DeepLinkValidationStatus.versionUpdateRequired:
        return 'Please update the app to continue.';
      case DeepLinkValidationStatus.deviceNotSupported:
        return 'This device is not supported.';
      case DeepLinkValidationStatus.alreadyUsed:
        return 'This link has already been used.';
      case DeepLinkValidationStatus.userNotFound:
        return 'User not found.';
      case DeepLinkValidationStatus.contentNotFound:
        return 'Content not found.';
      case DeepLinkValidationStatus.quotaExceeded:
        return 'Quota exceeded for this link.';
      default:
        return 'Unable to process this link.';
    }
  }
  
  /// Get analytics event properties
  Map<String, dynamic> getAnalyticsProperties() {
    return {
      'status': status.name,
      'link_type': linkType.name,
      'is_valid': isValid,
      'requires_auth': requiresAuth,
      'has_payload': payload != null,
      'has_error': error != null,
      'tracking_id': trackingId,
      'priority': priority,
      'is_deferred': isDeferred,
      ...?metadata,
    };
  }
  
  /// Get cache key for this validation result
  String get cacheKey => 'deeplink_${originalUrl.hashCode}';
  
  /// Check if result should be cached
  bool get shouldCache => isValid && (ttlSeconds ?? 0) > 0;
  
  /// Get cache duration
  Duration? get cacheDuration => 
      ttlSeconds != null ? Duration(seconds: ttlSeconds!) : null;
}


/// Usage example
///// Example 1: Creating a successful validation response
// final validResponse = DeepLinkValidationResponse.success(
//   originalUrl: 'myapp://product/12345',
//   linkType: DeepLinkType.product,
//   payload: DeepLinkPayload(
//     id: '12345',
//     resourceType: 'product',
//     params: {'variant': 'blue'},
//     queryParams: {'utm_source': 'email'},
//   ),
//   trackingId: 'track_123',
//   metadata: {'campaign': 'summer_sale'},
// );

// // Example 2: Creating an error response
// final errorResponse = DeepLinkValidationResponse.error(
//   originalUrl: 'myapp://expired/invite',
//   status: DeepLinkValidationStatus.expired,
//   errorCode: 'LINK_EXPIRED',
//   errorMessage: 'This invitation link has expired',
//   helpUrl: 'https://example.com/help/invites',
// );

// // Example 3: Version required response
// final versionRequiredResponse = DeepLinkValidationResponse.error(
//   originalUrl: 'myapp://feature/new',
//   status: DeepLinkValidationStatus.versionRequired,
//   errorCode: 'VERSION_OUTDATED',
//   errorMessage: 'Update required to access this feature',
//   requiredVersion: RequiredVersionInfo(
//     minimumVersion: '2.0.0',
//     latestVersion: '2.1.0',
//     updateUrl: 'https://apps.apple.com/app/id123',
//     isForceUpdate: true,
//     releaseNotes: 'New features available!',
//   ),
// );

// // Example 4: Using the response
// void handleDeepLink(DeepLinkValidationResponse response) {
//   if (response.isValid) {
//     // Navigate based on payload
//     switch (response.linkType) {
//       case DeepLinkType.product:
//         // Navigate to product detail
//         break;
//       case DeepLinkType.profile:
//         // Navigate to profile
//         break;
//       // ... handle other types
//       default:
//         break;
//     }
//   } else {
//     // Show error dialog
//     showErrorDialog(response.getUserFriendlyMessage());
    
//     // Log analytics
//     AnalyticsService.trackDeepLinkError(response.getAnalyticsProperties());
//   }
// }

// // Example 5: From JSON (API response)
// final apiResponse = await dio.post(
//   '/api/deeplink/validate',
//   data: {'url': deepLinkUrl},
// );

// final validationResponse = DeepLinkValidationResponse.fromJson(
//   apiResponse.data,
// );

// // Cache validation result if needed
// if (validationResponse.shouldCache) {
//   await cacheService.set(
//     validationResponse.cacheKey,
//     validationResponse.toJson(),
//     duration: validationResponse.cacheDuration,
//   );
// }