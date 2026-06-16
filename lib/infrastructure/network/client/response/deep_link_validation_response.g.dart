// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deep_link_validation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RequiredVersionInfo _$RequiredVersionInfoFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_RequiredVersionInfo',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'minimum_version',
            'latest_version',
            'update_url',
            'is_force_update',
            'release_notes',
            'update_deadline',
          ],
        );
        final val = _RequiredVersionInfo(
          minimumVersion: $checkedConvert(
            'minimum_version',
            (v) => v as String,
          ),
          latestVersion: $checkedConvert('latest_version', (v) => v as String?),
          updateUrl: $checkedConvert('update_url', (v) => v as String?),
          isForceUpdate: $checkedConvert(
            'is_force_update',
            (v) => v as bool? ?? false,
          ),
          releaseNotes: $checkedConvert('release_notes', (v) => v as String?),
          updateDeadline: $checkedConvert(
            'update_deadline',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'minimumVersion': 'minimum_version',
        'latestVersion': 'latest_version',
        'updateUrl': 'update_url',
        'isForceUpdate': 'is_force_update',
        'releaseNotes': 'release_notes',
        'updateDeadline': 'update_deadline',
      },
    );

Map<String, dynamic> _$RequiredVersionInfoToJson(
  _RequiredVersionInfo instance,
) => <String, dynamic>{
  'minimum_version': instance.minimumVersion,
  'latest_version': instance.latestVersion,
  'update_url': instance.updateUrl,
  'is_force_update': instance.isForceUpdate,
  'release_notes': instance.releaseNotes,
  'update_deadline': instance.updateDeadline?.toIso8601String(),
};

_DeepLinkPayload _$DeepLinkPayloadFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_DeepLinkPayload',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          allowedKeys: const [
            'id',
            'resource_type',
            'params',
            'query_params',
            'path_segments',
            'fragment',
            'source',
            'campaign',
            'medium',
            'content',
            'generated_at',
            'expires_at',
            'max_uses',
            'current_uses',
            'custom_data',
          ],
        );
        final val = _DeepLinkPayload(
          id: $checkedConvert('id', (v) => v as String?),
          resourceType: $checkedConvert('resource_type', (v) => v as String?),
          params: $checkedConvert('params', (v) => v as Map<String, dynamic>?),
          queryParams: $checkedConvert(
            'query_params',
            (v) => (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(k, e as String),
            ),
          ),
          pathSegments: $checkedConvert(
            'path_segments',
            (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
          ),
          fragment: $checkedConvert('fragment', (v) => v as String?),
          source: $checkedConvert('source', (v) => v as String?),
          campaign: $checkedConvert('campaign', (v) => v as String?),
          medium: $checkedConvert('medium', (v) => v as String?),
          content: $checkedConvert('content', (v) => v as String?),
          generatedAt: $checkedConvert(
            'generated_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          expiresAt: $checkedConvert(
            'expires_at',
            (v) => v == null ? null : DateTime.parse(v as String),
          ),
          maxUses: $checkedConvert('max_uses', (v) => (v as num?)?.toInt()),
          currentUses: $checkedConvert(
            'current_uses',
            (v) => (v as num?)?.toInt(),
          ),
          customData: $checkedConvert(
            'custom_data',
            (v) => v as Map<String, dynamic>?,
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'resourceType': 'resource_type',
        'queryParams': 'query_params',
        'pathSegments': 'path_segments',
        'generatedAt': 'generated_at',
        'expiresAt': 'expires_at',
        'maxUses': 'max_uses',
        'currentUses': 'current_uses',
        'customData': 'custom_data',
      },
    );

Map<String, dynamic> _$DeepLinkPayloadToJson(_DeepLinkPayload instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_type': instance.resourceType,
      'params': instance.params,
      'query_params': instance.queryParams,
      'path_segments': instance.pathSegments,
      'fragment': instance.fragment,
      'source': instance.source,
      'campaign': instance.campaign,
      'medium': instance.medium,
      'content': instance.content,
      'generated_at': instance.generatedAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'max_uses': instance.maxUses,
      'current_uses': instance.currentUses,
      'custom_data': instance.customData,
    };

_DeepLinkError _$DeepLinkErrorFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_DeepLinkError', json, ($checkedConvert) {
  $checkKeys(
    json,
    allowedKeys: const ['code', 'message', 'details', 'helpUrl', 'metadata'],
  );
  final val = _DeepLinkError(
    code: $checkedConvert('code', (v) => v as String),
    message: $checkedConvert('message', (v) => v as String),
    details: $checkedConvert('details', (v) => v as String?),
    helpUrl: $checkedConvert('helpUrl', (v) => v as String?),
    metadata: $checkedConvert('metadata', (v) => v as Map<String, dynamic>?),
  );
  return val;
});

Map<String, dynamic> _$DeepLinkErrorToJson(_DeepLinkError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'details': instance.details,
      'helpUrl': instance.helpUrl,
      'metadata': instance.metadata,
    };

_DeepLinkValidationResponse _$DeepLinkValidationResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_DeepLinkValidationResponse',
  json,
  ($checkedConvert) {
    $checkKeys(
      json,
      allowedKeys: const [
        'status',
        'original_url',
        'canonical_url',
        'link_type',
        'payload',
        'error',
        'required_version',
        'redirect_url',
        'requires_auth',
        'required_permissions',
        'validated_at',
        'ttl_seconds',
        'cache_control',
        'tracking_id',
        'metadata',
        'suggested_action',
        'priority',
        'is_deferred',
        'fallback_url',
        'web_url',
      ],
    );
    final val = _DeepLinkValidationResponse(
      status: $checkedConvert(
        'status',
        (v) => $enumDecode(_$DeepLinkValidationStatusEnumMap, v),
      ),
      originalUrl: $checkedConvert('original_url', (v) => v as String),
      canonicalUrl: $checkedConvert('canonical_url', (v) => v as String?),
      linkType: $checkedConvert(
        'link_type',
        (v) => $enumDecode(_$DeepLinkTypeEnumMap, v),
      ),
      payload: $checkedConvert(
        'payload',
        (v) => v == null
            ? null
            : DeepLinkPayload.fromJson(v as Map<String, dynamic>),
      ),
      error: $checkedConvert(
        'error',
        (v) => v == null
            ? null
            : DeepLinkError.fromJson(v as Map<String, dynamic>),
      ),
      requiredVersion: $checkedConvert(
        'required_version',
        (v) => v == null
            ? null
            : RequiredVersionInfo.fromJson(v as Map<String, dynamic>),
      ),
      redirectUrl: $checkedConvert('redirect_url', (v) => v as String?),
      requiresAuth: $checkedConvert(
        'requires_auth',
        (v) => v as bool? ?? false,
      ),
      requiredPermissions: $checkedConvert(
        'required_permissions',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
      ),
      validatedAt: $checkedConvert(
        'validated_at',
        (v) => DateTime.parse(v as String),
      ),
      ttlSeconds: $checkedConvert('ttl_seconds', (v) => (v as num?)?.toInt()),
      cacheControl: $checkedConvert('cache_control', (v) => v as String?),
      trackingId: $checkedConvert('tracking_id', (v) => v as String?),
      metadata: $checkedConvert('metadata', (v) => v as Map<String, dynamic>?),
      suggestedAction: $checkedConvert('suggested_action', (v) => v as String?),
      priority: $checkedConvert('priority', (v) => (v as num?)?.toInt() ?? 0),
      isDeferred: $checkedConvert('is_deferred', (v) => v as bool? ?? false),
      fallbackUrl: $checkedConvert('fallback_url', (v) => v as String?),
      webUrl: $checkedConvert('web_url', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {
    'originalUrl': 'original_url',
    'canonicalUrl': 'canonical_url',
    'linkType': 'link_type',
    'requiredVersion': 'required_version',
    'redirectUrl': 'redirect_url',
    'requiresAuth': 'requires_auth',
    'requiredPermissions': 'required_permissions',
    'validatedAt': 'validated_at',
    'ttlSeconds': 'ttl_seconds',
    'cacheControl': 'cache_control',
    'trackingId': 'tracking_id',
    'suggestedAction': 'suggested_action',
    'isDeferred': 'is_deferred',
    'fallbackUrl': 'fallback_url',
    'webUrl': 'web_url',
  },
);

Map<String, dynamic> _$DeepLinkValidationResponseToJson(
  _DeepLinkValidationResponse instance,
) => <String, dynamic>{
  'status': _$DeepLinkValidationStatusEnumMap[instance.status]!,
  'original_url': instance.originalUrl,
  'canonical_url': instance.canonicalUrl,
  'link_type': _$DeepLinkTypeEnumMap[instance.linkType]!,
  'payload': instance.payload?.toJson(),
  'error': instance.error?.toJson(),
  'required_version': instance.requiredVersion?.toJson(),
  'redirect_url': instance.redirectUrl,
  'requires_auth': instance.requiresAuth,
  'required_permissions': instance.requiredPermissions,
  'validated_at': instance.validatedAt.toIso8601String(),
  'ttl_seconds': instance.ttlSeconds,
  'cache_control': instance.cacheControl,
  'tracking_id': instance.trackingId,
  'metadata': instance.metadata,
  'suggested_action': instance.suggestedAction,
  'priority': instance.priority,
  'is_deferred': instance.isDeferred,
  'fallback_url': instance.fallbackUrl,
  'web_url': instance.webUrl,
};

const _$DeepLinkValidationStatusEnumMap = {
  DeepLinkValidationStatus.valid: 'valid',
  DeepLinkValidationStatus.expired: 'expired',
  DeepLinkValidationStatus.invalid: 'invalid',
  DeepLinkValidationStatus.revoked: 'revoked',
  DeepLinkValidationStatus.rateLimited: 'rate_limited',
  DeepLinkValidationStatus.requiresAuth: 'requires_auth',
  DeepLinkValidationStatus.requiresPermission: 'requires_permission',
  DeepLinkValidationStatus.maintenance: 'maintenance',
  DeepLinkValidationStatus.regionBlocked: 'region_blocked',
  DeepLinkValidationStatus.versionRequired: 'version_required',
  DeepLinkValidationStatus.versionUpdateRequired: 'version_update_required',
  DeepLinkValidationStatus.deviceNotSupported: 'device_not_supported',
  DeepLinkValidationStatus.alreadyUsed: 'already_used',
  DeepLinkValidationStatus.userNotFound: 'user_not_found',
  DeepLinkValidationStatus.contentNotFound: 'content_not_found',
  DeepLinkValidationStatus.quotaExceeded: 'quota_exceeded',
};

const _$DeepLinkTypeEnumMap = {
  DeepLinkType.product: 'product',
  DeepLinkType.profile: 'profile',
  DeepLinkType.order: 'order',
  DeepLinkType.payment: 'payment',
  DeepLinkType.promotion: 'promotion',
  DeepLinkType.invite: 'invite',
  DeepLinkType.referral: 'referral',
  DeepLinkType.notification: 'notification',
  DeepLinkType.message: 'message',
  DeepLinkType.settings: 'settings',
  DeepLinkType.support: 'support',
  DeepLinkType.external: 'external',
  DeepLinkType.deeplink: 'deeplink',
  DeepLinkType.universalLink: 'universal_link',
  DeepLinkType.customScheme: 'custom_scheme',
};
