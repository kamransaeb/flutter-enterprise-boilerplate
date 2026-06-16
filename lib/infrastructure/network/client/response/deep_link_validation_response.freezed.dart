// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deep_link_validation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RequiredVersionInfo {

@JsonKey(name: 'minimum_version') String get minimumVersion;@JsonKey(name: 'latest_version') String? get latestVersion;@JsonKey(name: 'update_url') String? get updateUrl;@JsonKey(name: 'is_force_update') bool get isForceUpdate;@JsonKey(name: 'release_notes') String? get releaseNotes;@JsonKey(name: 'update_deadline') DateTime? get updateDeadline;
/// Create a copy of RequiredVersionInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RequiredVersionInfoCopyWith<RequiredVersionInfo> get copyWith => _$RequiredVersionInfoCopyWithImpl<RequiredVersionInfo>(this as RequiredVersionInfo, _$identity);

  /// Serializes this RequiredVersionInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RequiredVersionInfo&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.updateUrl, updateUrl) || other.updateUrl == updateUrl)&&(identical(other.isForceUpdate, isForceUpdate) || other.isForceUpdate == isForceUpdate)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.updateDeadline, updateDeadline) || other.updateDeadline == updateDeadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimumVersion,latestVersion,updateUrl,isForceUpdate,releaseNotes,updateDeadline);

@override
String toString() {
  return 'RequiredVersionInfo(minimumVersion: $minimumVersion, latestVersion: $latestVersion, updateUrl: $updateUrl, isForceUpdate: $isForceUpdate, releaseNotes: $releaseNotes, updateDeadline: $updateDeadline)';
}


}

/// @nodoc
abstract mixin class $RequiredVersionInfoCopyWith<$Res>  {
  factory $RequiredVersionInfoCopyWith(RequiredVersionInfo value, $Res Function(RequiredVersionInfo) _then) = _$RequiredVersionInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'minimum_version') String minimumVersion,@JsonKey(name: 'latest_version') String? latestVersion,@JsonKey(name: 'update_url') String? updateUrl,@JsonKey(name: 'is_force_update') bool isForceUpdate,@JsonKey(name: 'release_notes') String? releaseNotes,@JsonKey(name: 'update_deadline') DateTime? updateDeadline
});




}
/// @nodoc
class _$RequiredVersionInfoCopyWithImpl<$Res>
    implements $RequiredVersionInfoCopyWith<$Res> {
  _$RequiredVersionInfoCopyWithImpl(this._self, this._then);

  final RequiredVersionInfo _self;
  final $Res Function(RequiredVersionInfo) _then;

/// Create a copy of RequiredVersionInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? minimumVersion = null,Object? latestVersion = freezed,Object? updateUrl = freezed,Object? isForceUpdate = null,Object? releaseNotes = freezed,Object? updateDeadline = freezed,}) {
  return _then(_self.copyWith(
minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: freezed == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String?,updateUrl: freezed == updateUrl ? _self.updateUrl : updateUrl // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: null == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,updateDeadline: freezed == updateDeadline ? _self.updateDeadline : updateDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RequiredVersionInfo].
extension RequiredVersionInfoPatterns on RequiredVersionInfo {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'minimum_version')  String minimumVersion, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'is_force_update')  bool isForceUpdate, @JsonKey(name: 'release_notes')  String? releaseNotes, @JsonKey(name: 'update_deadline')  DateTime? updateDeadline)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RequiredVersionInfo() when $default != null:
return $default(_that.minimumVersion,_that.latestVersion,_that.updateUrl,_that.isForceUpdate,_that.releaseNotes,_that.updateDeadline);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'minimum_version')  String minimumVersion, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'is_force_update')  bool isForceUpdate, @JsonKey(name: 'release_notes')  String? releaseNotes, @JsonKey(name: 'update_deadline')  DateTime? updateDeadline)  $default,) {final _that = this;
switch (_that) {
case _RequiredVersionInfo():
return $default(_that.minimumVersion,_that.latestVersion,_that.updateUrl,_that.isForceUpdate,_that.releaseNotes,_that.updateDeadline);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'minimum_version')  String minimumVersion, @JsonKey(name: 'latest_version')  String? latestVersion, @JsonKey(name: 'update_url')  String? updateUrl, @JsonKey(name: 'is_force_update')  bool isForceUpdate, @JsonKey(name: 'release_notes')  String? releaseNotes, @JsonKey(name: 'update_deadline')  DateTime? updateDeadline)?  $default,) {final _that = this;
switch (_that) {
case _RequiredVersionInfo() when $default != null:
return $default(_that.minimumVersion,_that.latestVersion,_that.updateUrl,_that.isForceUpdate,_that.releaseNotes,_that.updateDeadline);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RequiredVersionInfo implements RequiredVersionInfo {
  const _RequiredVersionInfo({@JsonKey(name: 'minimum_version') required this.minimumVersion, @JsonKey(name: 'latest_version') this.latestVersion, @JsonKey(name: 'update_url') this.updateUrl, @JsonKey(name: 'is_force_update') this.isForceUpdate = false, @JsonKey(name: 'release_notes') this.releaseNotes, @JsonKey(name: 'update_deadline') this.updateDeadline});
  factory _RequiredVersionInfo.fromJson(Map<String, dynamic> json) => _$RequiredVersionInfoFromJson(json);

@override@JsonKey(name: 'minimum_version') final  String minimumVersion;
@override@JsonKey(name: 'latest_version') final  String? latestVersion;
@override@JsonKey(name: 'update_url') final  String? updateUrl;
@override@JsonKey(name: 'is_force_update') final  bool isForceUpdate;
@override@JsonKey(name: 'release_notes') final  String? releaseNotes;
@override@JsonKey(name: 'update_deadline') final  DateTime? updateDeadline;

/// Create a copy of RequiredVersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequiredVersionInfoCopyWith<_RequiredVersionInfo> get copyWith => __$RequiredVersionInfoCopyWithImpl<_RequiredVersionInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RequiredVersionInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequiredVersionInfo&&(identical(other.minimumVersion, minimumVersion) || other.minimumVersion == minimumVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.updateUrl, updateUrl) || other.updateUrl == updateUrl)&&(identical(other.isForceUpdate, isForceUpdate) || other.isForceUpdate == isForceUpdate)&&(identical(other.releaseNotes, releaseNotes) || other.releaseNotes == releaseNotes)&&(identical(other.updateDeadline, updateDeadline) || other.updateDeadline == updateDeadline));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,minimumVersion,latestVersion,updateUrl,isForceUpdate,releaseNotes,updateDeadline);

@override
String toString() {
  return 'RequiredVersionInfo(minimumVersion: $minimumVersion, latestVersion: $latestVersion, updateUrl: $updateUrl, isForceUpdate: $isForceUpdate, releaseNotes: $releaseNotes, updateDeadline: $updateDeadline)';
}


}

/// @nodoc
abstract mixin class _$RequiredVersionInfoCopyWith<$Res> implements $RequiredVersionInfoCopyWith<$Res> {
  factory _$RequiredVersionInfoCopyWith(_RequiredVersionInfo value, $Res Function(_RequiredVersionInfo) _then) = __$RequiredVersionInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'minimum_version') String minimumVersion,@JsonKey(name: 'latest_version') String? latestVersion,@JsonKey(name: 'update_url') String? updateUrl,@JsonKey(name: 'is_force_update') bool isForceUpdate,@JsonKey(name: 'release_notes') String? releaseNotes,@JsonKey(name: 'update_deadline') DateTime? updateDeadline
});




}
/// @nodoc
class __$RequiredVersionInfoCopyWithImpl<$Res>
    implements _$RequiredVersionInfoCopyWith<$Res> {
  __$RequiredVersionInfoCopyWithImpl(this._self, this._then);

  final _RequiredVersionInfo _self;
  final $Res Function(_RequiredVersionInfo) _then;

/// Create a copy of RequiredVersionInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? minimumVersion = null,Object? latestVersion = freezed,Object? updateUrl = freezed,Object? isForceUpdate = null,Object? releaseNotes = freezed,Object? updateDeadline = freezed,}) {
  return _then(_RequiredVersionInfo(
minimumVersion: null == minimumVersion ? _self.minimumVersion : minimumVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: freezed == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String?,updateUrl: freezed == updateUrl ? _self.updateUrl : updateUrl // ignore: cast_nullable_to_non_nullable
as String?,isForceUpdate: null == isForceUpdate ? _self.isForceUpdate : isForceUpdate // ignore: cast_nullable_to_non_nullable
as bool,releaseNotes: freezed == releaseNotes ? _self.releaseNotes : releaseNotes // ignore: cast_nullable_to_non_nullable
as String?,updateDeadline: freezed == updateDeadline ? _self.updateDeadline : updateDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DeepLinkPayload {

/// Resource ID (product ID, user ID, order ID, etc.)
 String? get id;/// Resource type specific data
@JsonKey(name: 'resource_type') String? get resourceType;/// Additional parameters
 Map<String, dynamic>? get params;/// Query parameters from the URL
@JsonKey(name: 'query_params') Map<String, String>? get queryParams;/// Path segments
@JsonKey(name: 'path_segments') List<String>? get pathSegments;/// Fragment/Anchor
 String? get fragment;/// Metadata about the link source
@JsonKey(name: 'source') String? get source;/// Campaign tracking parameters
@JsonKey(name: 'campaign') String? get campaign;/// Medium (email, sms, push, etc.)
@JsonKey(name: 'medium') String? get medium;/// Content identifier
@JsonKey(name: 'content') String? get content;/// Timestamp when link was generated
@JsonKey(name: 'generated_at') DateTime? get generatedAt;/// Expiration timestamp
@JsonKey(name: 'expires_at') DateTime? get expiresAt;/// Max number of uses (for one-time links)
@JsonKey(name: 'max_uses') int? get maxUses;/// Current number of uses
@JsonKey(name: 'current_uses') int? get currentUses;/// Custom data
@JsonKey(name: 'custom_data') Map<String, dynamic>? get customData;
/// Create a copy of DeepLinkPayload
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepLinkPayloadCopyWith<DeepLinkPayload> get copyWith => _$DeepLinkPayloadCopyWithImpl<DeepLinkPayload>(this as DeepLinkPayload, _$identity);

  /// Serializes this DeepLinkPayload to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepLinkPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.resourceType, resourceType) || other.resourceType == resourceType)&&const DeepCollectionEquality().equals(other.params, params)&&const DeepCollectionEquality().equals(other.queryParams, queryParams)&&const DeepCollectionEquality().equals(other.pathSegments, pathSegments)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.source, source) || other.source == source)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.content, content) || other.content == content)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&const DeepCollectionEquality().equals(other.customData, customData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,resourceType,const DeepCollectionEquality().hash(params),const DeepCollectionEquality().hash(queryParams),const DeepCollectionEquality().hash(pathSegments),fragment,source,campaign,medium,content,generatedAt,expiresAt,maxUses,currentUses,const DeepCollectionEquality().hash(customData));

@override
String toString() {
  return 'DeepLinkPayload(id: $id, resourceType: $resourceType, params: $params, queryParams: $queryParams, pathSegments: $pathSegments, fragment: $fragment, source: $source, campaign: $campaign, medium: $medium, content: $content, generatedAt: $generatedAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, customData: $customData)';
}


}

/// @nodoc
abstract mixin class $DeepLinkPayloadCopyWith<$Res>  {
  factory $DeepLinkPayloadCopyWith(DeepLinkPayload value, $Res Function(DeepLinkPayload) _then) = _$DeepLinkPayloadCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'resource_type') String? resourceType, Map<String, dynamic>? params,@JsonKey(name: 'query_params') Map<String, String>? queryParams,@JsonKey(name: 'path_segments') List<String>? pathSegments, String? fragment,@JsonKey(name: 'source') String? source,@JsonKey(name: 'campaign') String? campaign,@JsonKey(name: 'medium') String? medium,@JsonKey(name: 'content') String? content,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'max_uses') int? maxUses,@JsonKey(name: 'current_uses') int? currentUses,@JsonKey(name: 'custom_data') Map<String, dynamic>? customData
});




}
/// @nodoc
class _$DeepLinkPayloadCopyWithImpl<$Res>
    implements $DeepLinkPayloadCopyWith<$Res> {
  _$DeepLinkPayloadCopyWithImpl(this._self, this._then);

  final DeepLinkPayload _self;
  final $Res Function(DeepLinkPayload) _then;

/// Create a copy of DeepLinkPayload
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? resourceType = freezed,Object? params = freezed,Object? queryParams = freezed,Object? pathSegments = freezed,Object? fragment = freezed,Object? source = freezed,Object? campaign = freezed,Object? medium = freezed,Object? content = freezed,Object? generatedAt = freezed,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = freezed,Object? customData = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,resourceType: freezed == resourceType ? _self.resourceType : resourceType // ignore: cast_nullable_to_non_nullable
as String?,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,queryParams: freezed == queryParams ? _self.queryParams : queryParams // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,pathSegments: freezed == pathSegments ? _self.pathSegments : pathSegments // ignore: cast_nullable_to_non_nullable
as List<String>?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: freezed == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int?,customData: freezed == customData ? _self.customData : customData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeepLinkPayload].
extension DeepLinkPayloadPatterns on DeepLinkPayload {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'resource_type')  String? resourceType,  Map<String, dynamic>? params, @JsonKey(name: 'query_params')  Map<String, String>? queryParams, @JsonKey(name: 'path_segments')  List<String>? pathSegments,  String? fragment, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'campaign')  String? campaign, @JsonKey(name: 'medium')  String? medium, @JsonKey(name: 'content')  String? content, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'max_uses')  int? maxUses, @JsonKey(name: 'current_uses')  int? currentUses, @JsonKey(name: 'custom_data')  Map<String, dynamic>? customData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepLinkPayload() when $default != null:
return $default(_that.id,_that.resourceType,_that.params,_that.queryParams,_that.pathSegments,_that.fragment,_that.source,_that.campaign,_that.medium,_that.content,_that.generatedAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.customData);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'resource_type')  String? resourceType,  Map<String, dynamic>? params, @JsonKey(name: 'query_params')  Map<String, String>? queryParams, @JsonKey(name: 'path_segments')  List<String>? pathSegments,  String? fragment, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'campaign')  String? campaign, @JsonKey(name: 'medium')  String? medium, @JsonKey(name: 'content')  String? content, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'max_uses')  int? maxUses, @JsonKey(name: 'current_uses')  int? currentUses, @JsonKey(name: 'custom_data')  Map<String, dynamic>? customData)  $default,) {final _that = this;
switch (_that) {
case _DeepLinkPayload():
return $default(_that.id,_that.resourceType,_that.params,_that.queryParams,_that.pathSegments,_that.fragment,_that.source,_that.campaign,_that.medium,_that.content,_that.generatedAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.customData);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'resource_type')  String? resourceType,  Map<String, dynamic>? params, @JsonKey(name: 'query_params')  Map<String, String>? queryParams, @JsonKey(name: 'path_segments')  List<String>? pathSegments,  String? fragment, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'campaign')  String? campaign, @JsonKey(name: 'medium')  String? medium, @JsonKey(name: 'content')  String? content, @JsonKey(name: 'generated_at')  DateTime? generatedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'max_uses')  int? maxUses, @JsonKey(name: 'current_uses')  int? currentUses, @JsonKey(name: 'custom_data')  Map<String, dynamic>? customData)?  $default,) {final _that = this;
switch (_that) {
case _DeepLinkPayload() when $default != null:
return $default(_that.id,_that.resourceType,_that.params,_that.queryParams,_that.pathSegments,_that.fragment,_that.source,_that.campaign,_that.medium,_that.content,_that.generatedAt,_that.expiresAt,_that.maxUses,_that.currentUses,_that.customData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepLinkPayload implements DeepLinkPayload {
  const _DeepLinkPayload({this.id, @JsonKey(name: 'resource_type') this.resourceType, final  Map<String, dynamic>? params, @JsonKey(name: 'query_params') final  Map<String, String>? queryParams, @JsonKey(name: 'path_segments') final  List<String>? pathSegments, this.fragment, @JsonKey(name: 'source') this.source, @JsonKey(name: 'campaign') this.campaign, @JsonKey(name: 'medium') this.medium, @JsonKey(name: 'content') this.content, @JsonKey(name: 'generated_at') this.generatedAt, @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'max_uses') this.maxUses, @JsonKey(name: 'current_uses') this.currentUses, @JsonKey(name: 'custom_data') final  Map<String, dynamic>? customData}): _params = params,_queryParams = queryParams,_pathSegments = pathSegments,_customData = customData;
  factory _DeepLinkPayload.fromJson(Map<String, dynamic> json) => _$DeepLinkPayloadFromJson(json);

/// Resource ID (product ID, user ID, order ID, etc.)
@override final  String? id;
/// Resource type specific data
@override@JsonKey(name: 'resource_type') final  String? resourceType;
/// Additional parameters
 final  Map<String, dynamic>? _params;
/// Additional parameters
@override Map<String, dynamic>? get params {
  final value = _params;
  if (value == null) return null;
  if (_params is EqualUnmodifiableMapView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Query parameters from the URL
 final  Map<String, String>? _queryParams;
/// Query parameters from the URL
@override@JsonKey(name: 'query_params') Map<String, String>? get queryParams {
  final value = _queryParams;
  if (value == null) return null;
  if (_queryParams is EqualUnmodifiableMapView) return _queryParams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Path segments
 final  List<String>? _pathSegments;
/// Path segments
@override@JsonKey(name: 'path_segments') List<String>? get pathSegments {
  final value = _pathSegments;
  if (value == null) return null;
  if (_pathSegments is EqualUnmodifiableListView) return _pathSegments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Fragment/Anchor
@override final  String? fragment;
/// Metadata about the link source
@override@JsonKey(name: 'source') final  String? source;
/// Campaign tracking parameters
@override@JsonKey(name: 'campaign') final  String? campaign;
/// Medium (email, sms, push, etc.)
@override@JsonKey(name: 'medium') final  String? medium;
/// Content identifier
@override@JsonKey(name: 'content') final  String? content;
/// Timestamp when link was generated
@override@JsonKey(name: 'generated_at') final  DateTime? generatedAt;
/// Expiration timestamp
@override@JsonKey(name: 'expires_at') final  DateTime? expiresAt;
/// Max number of uses (for one-time links)
@override@JsonKey(name: 'max_uses') final  int? maxUses;
/// Current number of uses
@override@JsonKey(name: 'current_uses') final  int? currentUses;
/// Custom data
 final  Map<String, dynamic>? _customData;
/// Custom data
@override@JsonKey(name: 'custom_data') Map<String, dynamic>? get customData {
  final value = _customData;
  if (value == null) return null;
  if (_customData is EqualUnmodifiableMapView) return _customData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DeepLinkPayload
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepLinkPayloadCopyWith<_DeepLinkPayload> get copyWith => __$DeepLinkPayloadCopyWithImpl<_DeepLinkPayload>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepLinkPayloadToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepLinkPayload&&(identical(other.id, id) || other.id == id)&&(identical(other.resourceType, resourceType) || other.resourceType == resourceType)&&const DeepCollectionEquality().equals(other._params, _params)&&const DeepCollectionEquality().equals(other._queryParams, _queryParams)&&const DeepCollectionEquality().equals(other._pathSegments, _pathSegments)&&(identical(other.fragment, fragment) || other.fragment == fragment)&&(identical(other.source, source) || other.source == source)&&(identical(other.campaign, campaign) || other.campaign == campaign)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.content, content) || other.content == content)&&(identical(other.generatedAt, generatedAt) || other.generatedAt == generatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.currentUses, currentUses) || other.currentUses == currentUses)&&const DeepCollectionEquality().equals(other._customData, _customData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,resourceType,const DeepCollectionEquality().hash(_params),const DeepCollectionEquality().hash(_queryParams),const DeepCollectionEquality().hash(_pathSegments),fragment,source,campaign,medium,content,generatedAt,expiresAt,maxUses,currentUses,const DeepCollectionEquality().hash(_customData));

@override
String toString() {
  return 'DeepLinkPayload(id: $id, resourceType: $resourceType, params: $params, queryParams: $queryParams, pathSegments: $pathSegments, fragment: $fragment, source: $source, campaign: $campaign, medium: $medium, content: $content, generatedAt: $generatedAt, expiresAt: $expiresAt, maxUses: $maxUses, currentUses: $currentUses, customData: $customData)';
}


}

/// @nodoc
abstract mixin class _$DeepLinkPayloadCopyWith<$Res> implements $DeepLinkPayloadCopyWith<$Res> {
  factory _$DeepLinkPayloadCopyWith(_DeepLinkPayload value, $Res Function(_DeepLinkPayload) _then) = __$DeepLinkPayloadCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'resource_type') String? resourceType, Map<String, dynamic>? params,@JsonKey(name: 'query_params') Map<String, String>? queryParams,@JsonKey(name: 'path_segments') List<String>? pathSegments, String? fragment,@JsonKey(name: 'source') String? source,@JsonKey(name: 'campaign') String? campaign,@JsonKey(name: 'medium') String? medium,@JsonKey(name: 'content') String? content,@JsonKey(name: 'generated_at') DateTime? generatedAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'max_uses') int? maxUses,@JsonKey(name: 'current_uses') int? currentUses,@JsonKey(name: 'custom_data') Map<String, dynamic>? customData
});




}
/// @nodoc
class __$DeepLinkPayloadCopyWithImpl<$Res>
    implements _$DeepLinkPayloadCopyWith<$Res> {
  __$DeepLinkPayloadCopyWithImpl(this._self, this._then);

  final _DeepLinkPayload _self;
  final $Res Function(_DeepLinkPayload) _then;

/// Create a copy of DeepLinkPayload
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? resourceType = freezed,Object? params = freezed,Object? queryParams = freezed,Object? pathSegments = freezed,Object? fragment = freezed,Object? source = freezed,Object? campaign = freezed,Object? medium = freezed,Object? content = freezed,Object? generatedAt = freezed,Object? expiresAt = freezed,Object? maxUses = freezed,Object? currentUses = freezed,Object? customData = freezed,}) {
  return _then(_DeepLinkPayload(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,resourceType: freezed == resourceType ? _self.resourceType : resourceType // ignore: cast_nullable_to_non_nullable
as String?,params: freezed == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,queryParams: freezed == queryParams ? _self._queryParams : queryParams // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,pathSegments: freezed == pathSegments ? _self._pathSegments : pathSegments // ignore: cast_nullable_to_non_nullable
as List<String>?,fragment: freezed == fragment ? _self.fragment : fragment // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,campaign: freezed == campaign ? _self.campaign : campaign // ignore: cast_nullable_to_non_nullable
as String?,medium: freezed == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,generatedAt: freezed == generatedAt ? _self.generatedAt : generatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,currentUses: freezed == currentUses ? _self.currentUses : currentUses // ignore: cast_nullable_to_non_nullable
as int?,customData: freezed == customData ? _self._customData : customData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$DeepLinkError {

 String get code; String get message; String? get details; String? get helpUrl; Map<String, dynamic>? get metadata;
/// Create a copy of DeepLinkError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepLinkErrorCopyWith<DeepLinkError> get copyWith => _$DeepLinkErrorCopyWithImpl<DeepLinkError>(this as DeepLinkError, _$identity);

  /// Serializes this DeepLinkError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepLinkError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.details, details) || other.details == details)&&(identical(other.helpUrl, helpUrl) || other.helpUrl == helpUrl)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,details,helpUrl,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'DeepLinkError(code: $code, message: $message, details: $details, helpUrl: $helpUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $DeepLinkErrorCopyWith<$Res>  {
  factory $DeepLinkErrorCopyWith(DeepLinkError value, $Res Function(DeepLinkError) _then) = _$DeepLinkErrorCopyWithImpl;
@useResult
$Res call({
 String code, String message, String? details, String? helpUrl, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$DeepLinkErrorCopyWithImpl<$Res>
    implements $DeepLinkErrorCopyWith<$Res> {
  _$DeepLinkErrorCopyWithImpl(this._self, this._then);

  final DeepLinkError _self;
  final $Res Function(DeepLinkError) _then;

/// Create a copy of DeepLinkError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? details = freezed,Object? helpUrl = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,helpUrl: freezed == helpUrl ? _self.helpUrl : helpUrl // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeepLinkError].
extension DeepLinkErrorPatterns on DeepLinkError {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  String message,  String? details,  String? helpUrl,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepLinkError() when $default != null:
return $default(_that.code,_that.message,_that.details,_that.helpUrl,_that.metadata);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  String message,  String? details,  String? helpUrl,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _DeepLinkError():
return $default(_that.code,_that.message,_that.details,_that.helpUrl,_that.metadata);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  String message,  String? details,  String? helpUrl,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _DeepLinkError() when $default != null:
return $default(_that.code,_that.message,_that.details,_that.helpUrl,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepLinkError implements DeepLinkError {
  const _DeepLinkError({required this.code, required this.message, this.details, this.helpUrl, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _DeepLinkError.fromJson(Map<String, dynamic> json) => _$DeepLinkErrorFromJson(json);

@override final  String code;
@override final  String message;
@override final  String? details;
@override final  String? helpUrl;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DeepLinkError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepLinkErrorCopyWith<_DeepLinkError> get copyWith => __$DeepLinkErrorCopyWithImpl<_DeepLinkError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepLinkErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepLinkError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.details, details) || other.details == details)&&(identical(other.helpUrl, helpUrl) || other.helpUrl == helpUrl)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,details,helpUrl,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'DeepLinkError(code: $code, message: $message, details: $details, helpUrl: $helpUrl, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$DeepLinkErrorCopyWith<$Res> implements $DeepLinkErrorCopyWith<$Res> {
  factory _$DeepLinkErrorCopyWith(_DeepLinkError value, $Res Function(_DeepLinkError) _then) = __$DeepLinkErrorCopyWithImpl;
@override @useResult
$Res call({
 String code, String message, String? details, String? helpUrl, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$DeepLinkErrorCopyWithImpl<$Res>
    implements _$DeepLinkErrorCopyWith<$Res> {
  __$DeepLinkErrorCopyWithImpl(this._self, this._then);

  final _DeepLinkError _self;
  final $Res Function(_DeepLinkError) _then;

/// Create a copy of DeepLinkError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? details = freezed,Object? helpUrl = freezed,Object? metadata = freezed,}) {
  return _then(_DeepLinkError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,details: freezed == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as String?,helpUrl: freezed == helpUrl ? _self.helpUrl : helpUrl // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$DeepLinkValidationResponse {

/// Validation status
 DeepLinkValidationStatus get status;/// Original deep link URL
@JsonKey(name: 'original_url') String get originalUrl;/// Normalized/Canonical URL
@JsonKey(name: 'canonical_url') String? get canonicalUrl;/// Type of deep link
@JsonKey(name: 'link_type') DeepLinkType get linkType;/// Validated payload data
 DeepLinkPayload? get payload;/// Error details if validation failed
 DeepLinkError? get error;/// Required version info if version required
@JsonKey(name: 'required_version') RequiredVersionInfo? get requiredVersion;/// Redirect URL if applicable
@JsonKey(name: 'redirect_url') String? get redirectUrl;/// Authentication required
@JsonKey(name: 'requires_auth') bool get requiresAuth;/// Required permissions
@JsonKey(name: 'required_permissions') List<String>? get requiredPermissions;/// Validation timestamp
@JsonKey(name: 'validated_at') DateTime get validatedAt;/// TTL in seconds
@JsonKey(name: 'ttl_seconds') int? get ttlSeconds;/// Cache control headers
@JsonKey(name: 'cache_control') String? get cacheControl;/// Analytics tracking ID
@JsonKey(name: 'tracking_id') String? get trackingId;/// Metadata for analytics
@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata;/// Suggested UI action (push, modal, etc.)
@JsonKey(name: 'suggested_action') String? get suggestedAction;/// Priority of the deep link (for queuing)
@JsonKey(name: 'priority') int get priority;/// Is this a deferred deep link
@JsonKey(name: 'is_deferred') bool get isDeferred;/// Fallback URL if app not installed
@JsonKey(name: 'fallback_url') String? get fallbackUrl;/// Web URL alternative
@JsonKey(name: 'web_url') String? get webUrl;
/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeepLinkValidationResponseCopyWith<DeepLinkValidationResponse> get copyWith => _$DeepLinkValidationResponseCopyWithImpl<DeepLinkValidationResponse>(this as DeepLinkValidationResponse, _$identity);

  /// Serializes this DeepLinkValidationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeepLinkValidationResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.canonicalUrl, canonicalUrl) || other.canonicalUrl == canonicalUrl)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.error, error) || other.error == error)&&(identical(other.requiredVersion, requiredVersion) || other.requiredVersion == requiredVersion)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.requiresAuth, requiresAuth) || other.requiresAuth == requiresAuth)&&const DeepCollectionEquality().equals(other.requiredPermissions, requiredPermissions)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.ttlSeconds, ttlSeconds) || other.ttlSeconds == ttlSeconds)&&(identical(other.cacheControl, cacheControl) || other.cacheControl == cacheControl)&&(identical(other.trackingId, trackingId) || other.trackingId == trackingId)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.suggestedAction, suggestedAction) || other.suggestedAction == suggestedAction)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isDeferred, isDeferred) || other.isDeferred == isDeferred)&&(identical(other.fallbackUrl, fallbackUrl) || other.fallbackUrl == fallbackUrl)&&(identical(other.webUrl, webUrl) || other.webUrl == webUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,status,originalUrl,canonicalUrl,linkType,payload,error,requiredVersion,redirectUrl,requiresAuth,const DeepCollectionEquality().hash(requiredPermissions),validatedAt,ttlSeconds,cacheControl,trackingId,const DeepCollectionEquality().hash(metadata),suggestedAction,priority,isDeferred,fallbackUrl,webUrl]);

@override
String toString() {
  return 'DeepLinkValidationResponse(status: $status, originalUrl: $originalUrl, canonicalUrl: $canonicalUrl, linkType: $linkType, payload: $payload, error: $error, requiredVersion: $requiredVersion, redirectUrl: $redirectUrl, requiresAuth: $requiresAuth, requiredPermissions: $requiredPermissions, validatedAt: $validatedAt, ttlSeconds: $ttlSeconds, cacheControl: $cacheControl, trackingId: $trackingId, metadata: $metadata, suggestedAction: $suggestedAction, priority: $priority, isDeferred: $isDeferred, fallbackUrl: $fallbackUrl, webUrl: $webUrl)';
}


}

/// @nodoc
abstract mixin class $DeepLinkValidationResponseCopyWith<$Res>  {
  factory $DeepLinkValidationResponseCopyWith(DeepLinkValidationResponse value, $Res Function(DeepLinkValidationResponse) _then) = _$DeepLinkValidationResponseCopyWithImpl;
@useResult
$Res call({
 DeepLinkValidationStatus status,@JsonKey(name: 'original_url') String originalUrl,@JsonKey(name: 'canonical_url') String? canonicalUrl,@JsonKey(name: 'link_type') DeepLinkType linkType, DeepLinkPayload? payload, DeepLinkError? error,@JsonKey(name: 'required_version') RequiredVersionInfo? requiredVersion,@JsonKey(name: 'redirect_url') String? redirectUrl,@JsonKey(name: 'requires_auth') bool requiresAuth,@JsonKey(name: 'required_permissions') List<String>? requiredPermissions,@JsonKey(name: 'validated_at') DateTime validatedAt,@JsonKey(name: 'ttl_seconds') int? ttlSeconds,@JsonKey(name: 'cache_control') String? cacheControl,@JsonKey(name: 'tracking_id') String? trackingId,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata,@JsonKey(name: 'suggested_action') String? suggestedAction,@JsonKey(name: 'priority') int priority,@JsonKey(name: 'is_deferred') bool isDeferred,@JsonKey(name: 'fallback_url') String? fallbackUrl,@JsonKey(name: 'web_url') String? webUrl
});


$DeepLinkPayloadCopyWith<$Res>? get payload;$DeepLinkErrorCopyWith<$Res>? get error;$RequiredVersionInfoCopyWith<$Res>? get requiredVersion;

}
/// @nodoc
class _$DeepLinkValidationResponseCopyWithImpl<$Res>
    implements $DeepLinkValidationResponseCopyWith<$Res> {
  _$DeepLinkValidationResponseCopyWithImpl(this._self, this._then);

  final DeepLinkValidationResponse _self;
  final $Res Function(DeepLinkValidationResponse) _then;

/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? originalUrl = null,Object? canonicalUrl = freezed,Object? linkType = null,Object? payload = freezed,Object? error = freezed,Object? requiredVersion = freezed,Object? redirectUrl = freezed,Object? requiresAuth = null,Object? requiredPermissions = freezed,Object? validatedAt = null,Object? ttlSeconds = freezed,Object? cacheControl = freezed,Object? trackingId = freezed,Object? metadata = freezed,Object? suggestedAction = freezed,Object? priority = null,Object? isDeferred = null,Object? fallbackUrl = freezed,Object? webUrl = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeepLinkValidationStatus,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,canonicalUrl: freezed == canonicalUrl ? _self.canonicalUrl : canonicalUrl // ignore: cast_nullable_to_non_nullable
as String?,linkType: null == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as DeepLinkType,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as DeepLinkPayload?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DeepLinkError?,requiredVersion: freezed == requiredVersion ? _self.requiredVersion : requiredVersion // ignore: cast_nullable_to_non_nullable
as RequiredVersionInfo?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,requiresAuth: null == requiresAuth ? _self.requiresAuth : requiresAuth // ignore: cast_nullable_to_non_nullable
as bool,requiredPermissions: freezed == requiredPermissions ? _self.requiredPermissions : requiredPermissions // ignore: cast_nullable_to_non_nullable
as List<String>?,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,ttlSeconds: freezed == ttlSeconds ? _self.ttlSeconds : ttlSeconds // ignore: cast_nullable_to_non_nullable
as int?,cacheControl: freezed == cacheControl ? _self.cacheControl : cacheControl // ignore: cast_nullable_to_non_nullable
as String?,trackingId: freezed == trackingId ? _self.trackingId : trackingId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,suggestedAction: freezed == suggestedAction ? _self.suggestedAction : suggestedAction // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isDeferred: null == isDeferred ? _self.isDeferred : isDeferred // ignore: cast_nullable_to_non_nullable
as bool,fallbackUrl: freezed == fallbackUrl ? _self.fallbackUrl : fallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,webUrl: freezed == webUrl ? _self.webUrl : webUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepLinkPayloadCopyWith<$Res>? get payload {
    if (_self.payload == null) {
    return null;
  }

  return $DeepLinkPayloadCopyWith<$Res>(_self.payload!, (value) {
    return _then(_self.copyWith(payload: value));
  });
}/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepLinkErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $DeepLinkErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequiredVersionInfoCopyWith<$Res>? get requiredVersion {
    if (_self.requiredVersion == null) {
    return null;
  }

  return $RequiredVersionInfoCopyWith<$Res>(_self.requiredVersion!, (value) {
    return _then(_self.copyWith(requiredVersion: value));
  });
}
}


/// Adds pattern-matching-related methods to [DeepLinkValidationResponse].
extension DeepLinkValidationResponsePatterns on DeepLinkValidationResponse {
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DeepLinkValidationStatus status, @JsonKey(name: 'original_url')  String originalUrl, @JsonKey(name: 'canonical_url')  String? canonicalUrl, @JsonKey(name: 'link_type')  DeepLinkType linkType,  DeepLinkPayload? payload,  DeepLinkError? error, @JsonKey(name: 'required_version')  RequiredVersionInfo? requiredVersion, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'requires_auth')  bool requiresAuth, @JsonKey(name: 'required_permissions')  List<String>? requiredPermissions, @JsonKey(name: 'validated_at')  DateTime validatedAt, @JsonKey(name: 'ttl_seconds')  int? ttlSeconds, @JsonKey(name: 'cache_control')  String? cacheControl, @JsonKey(name: 'tracking_id')  String? trackingId, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata, @JsonKey(name: 'suggested_action')  String? suggestedAction, @JsonKey(name: 'priority')  int priority, @JsonKey(name: 'is_deferred')  bool isDeferred, @JsonKey(name: 'fallback_url')  String? fallbackUrl, @JsonKey(name: 'web_url')  String? webUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeepLinkValidationResponse() when $default != null:
return $default(_that.status,_that.originalUrl,_that.canonicalUrl,_that.linkType,_that.payload,_that.error,_that.requiredVersion,_that.redirectUrl,_that.requiresAuth,_that.requiredPermissions,_that.validatedAt,_that.ttlSeconds,_that.cacheControl,_that.trackingId,_that.metadata,_that.suggestedAction,_that.priority,_that.isDeferred,_that.fallbackUrl,_that.webUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DeepLinkValidationStatus status, @JsonKey(name: 'original_url')  String originalUrl, @JsonKey(name: 'canonical_url')  String? canonicalUrl, @JsonKey(name: 'link_type')  DeepLinkType linkType,  DeepLinkPayload? payload,  DeepLinkError? error, @JsonKey(name: 'required_version')  RequiredVersionInfo? requiredVersion, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'requires_auth')  bool requiresAuth, @JsonKey(name: 'required_permissions')  List<String>? requiredPermissions, @JsonKey(name: 'validated_at')  DateTime validatedAt, @JsonKey(name: 'ttl_seconds')  int? ttlSeconds, @JsonKey(name: 'cache_control')  String? cacheControl, @JsonKey(name: 'tracking_id')  String? trackingId, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata, @JsonKey(name: 'suggested_action')  String? suggestedAction, @JsonKey(name: 'priority')  int priority, @JsonKey(name: 'is_deferred')  bool isDeferred, @JsonKey(name: 'fallback_url')  String? fallbackUrl, @JsonKey(name: 'web_url')  String? webUrl)  $default,) {final _that = this;
switch (_that) {
case _DeepLinkValidationResponse():
return $default(_that.status,_that.originalUrl,_that.canonicalUrl,_that.linkType,_that.payload,_that.error,_that.requiredVersion,_that.redirectUrl,_that.requiresAuth,_that.requiredPermissions,_that.validatedAt,_that.ttlSeconds,_that.cacheControl,_that.trackingId,_that.metadata,_that.suggestedAction,_that.priority,_that.isDeferred,_that.fallbackUrl,_that.webUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DeepLinkValidationStatus status, @JsonKey(name: 'original_url')  String originalUrl, @JsonKey(name: 'canonical_url')  String? canonicalUrl, @JsonKey(name: 'link_type')  DeepLinkType linkType,  DeepLinkPayload? payload,  DeepLinkError? error, @JsonKey(name: 'required_version')  RequiredVersionInfo? requiredVersion, @JsonKey(name: 'redirect_url')  String? redirectUrl, @JsonKey(name: 'requires_auth')  bool requiresAuth, @JsonKey(name: 'required_permissions')  List<String>? requiredPermissions, @JsonKey(name: 'validated_at')  DateTime validatedAt, @JsonKey(name: 'ttl_seconds')  int? ttlSeconds, @JsonKey(name: 'cache_control')  String? cacheControl, @JsonKey(name: 'tracking_id')  String? trackingId, @JsonKey(name: 'metadata')  Map<String, dynamic>? metadata, @JsonKey(name: 'suggested_action')  String? suggestedAction, @JsonKey(name: 'priority')  int priority, @JsonKey(name: 'is_deferred')  bool isDeferred, @JsonKey(name: 'fallback_url')  String? fallbackUrl, @JsonKey(name: 'web_url')  String? webUrl)?  $default,) {final _that = this;
switch (_that) {
case _DeepLinkValidationResponse() when $default != null:
return $default(_that.status,_that.originalUrl,_that.canonicalUrl,_that.linkType,_that.payload,_that.error,_that.requiredVersion,_that.redirectUrl,_that.requiresAuth,_that.requiredPermissions,_that.validatedAt,_that.ttlSeconds,_that.cacheControl,_that.trackingId,_that.metadata,_that.suggestedAction,_that.priority,_that.isDeferred,_that.fallbackUrl,_that.webUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeepLinkValidationResponse extends DeepLinkValidationResponse {
  const _DeepLinkValidationResponse({required this.status, @JsonKey(name: 'original_url') required this.originalUrl, @JsonKey(name: 'canonical_url') this.canonicalUrl, @JsonKey(name: 'link_type') required this.linkType, this.payload, this.error, @JsonKey(name: 'required_version') this.requiredVersion, @JsonKey(name: 'redirect_url') this.redirectUrl, @JsonKey(name: 'requires_auth') this.requiresAuth = false, @JsonKey(name: 'required_permissions') final  List<String>? requiredPermissions, @JsonKey(name: 'validated_at') required this.validatedAt, @JsonKey(name: 'ttl_seconds') this.ttlSeconds, @JsonKey(name: 'cache_control') this.cacheControl, @JsonKey(name: 'tracking_id') this.trackingId, @JsonKey(name: 'metadata') final  Map<String, dynamic>? metadata, @JsonKey(name: 'suggested_action') this.suggestedAction, @JsonKey(name: 'priority') this.priority = 0, @JsonKey(name: 'is_deferred') this.isDeferred = false, @JsonKey(name: 'fallback_url') this.fallbackUrl, @JsonKey(name: 'web_url') this.webUrl}): _requiredPermissions = requiredPermissions,_metadata = metadata,super._();
  factory _DeepLinkValidationResponse.fromJson(Map<String, dynamic> json) => _$DeepLinkValidationResponseFromJson(json);

/// Validation status
@override final  DeepLinkValidationStatus status;
/// Original deep link URL
@override@JsonKey(name: 'original_url') final  String originalUrl;
/// Normalized/Canonical URL
@override@JsonKey(name: 'canonical_url') final  String? canonicalUrl;
/// Type of deep link
@override@JsonKey(name: 'link_type') final  DeepLinkType linkType;
/// Validated payload data
@override final  DeepLinkPayload? payload;
/// Error details if validation failed
@override final  DeepLinkError? error;
/// Required version info if version required
@override@JsonKey(name: 'required_version') final  RequiredVersionInfo? requiredVersion;
/// Redirect URL if applicable
@override@JsonKey(name: 'redirect_url') final  String? redirectUrl;
/// Authentication required
@override@JsonKey(name: 'requires_auth') final  bool requiresAuth;
/// Required permissions
 final  List<String>? _requiredPermissions;
/// Required permissions
@override@JsonKey(name: 'required_permissions') List<String>? get requiredPermissions {
  final value = _requiredPermissions;
  if (value == null) return null;
  if (_requiredPermissions is EqualUnmodifiableListView) return _requiredPermissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Validation timestamp
@override@JsonKey(name: 'validated_at') final  DateTime validatedAt;
/// TTL in seconds
@override@JsonKey(name: 'ttl_seconds') final  int? ttlSeconds;
/// Cache control headers
@override@JsonKey(name: 'cache_control') final  String? cacheControl;
/// Analytics tracking ID
@override@JsonKey(name: 'tracking_id') final  String? trackingId;
/// Metadata for analytics
 final  Map<String, dynamic>? _metadata;
/// Metadata for analytics
@override@JsonKey(name: 'metadata') Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Suggested UI action (push, modal, etc.)
@override@JsonKey(name: 'suggested_action') final  String? suggestedAction;
/// Priority of the deep link (for queuing)
@override@JsonKey(name: 'priority') final  int priority;
/// Is this a deferred deep link
@override@JsonKey(name: 'is_deferred') final  bool isDeferred;
/// Fallback URL if app not installed
@override@JsonKey(name: 'fallback_url') final  String? fallbackUrl;
/// Web URL alternative
@override@JsonKey(name: 'web_url') final  String? webUrl;

/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepLinkValidationResponseCopyWith<_DeepLinkValidationResponse> get copyWith => __$DeepLinkValidationResponseCopyWithImpl<_DeepLinkValidationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeepLinkValidationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepLinkValidationResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.canonicalUrl, canonicalUrl) || other.canonicalUrl == canonicalUrl)&&(identical(other.linkType, linkType) || other.linkType == linkType)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.error, error) || other.error == error)&&(identical(other.requiredVersion, requiredVersion) || other.requiredVersion == requiredVersion)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.requiresAuth, requiresAuth) || other.requiresAuth == requiresAuth)&&const DeepCollectionEquality().equals(other._requiredPermissions, _requiredPermissions)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.ttlSeconds, ttlSeconds) || other.ttlSeconds == ttlSeconds)&&(identical(other.cacheControl, cacheControl) || other.cacheControl == cacheControl)&&(identical(other.trackingId, trackingId) || other.trackingId == trackingId)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.suggestedAction, suggestedAction) || other.suggestedAction == suggestedAction)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.isDeferred, isDeferred) || other.isDeferred == isDeferred)&&(identical(other.fallbackUrl, fallbackUrl) || other.fallbackUrl == fallbackUrl)&&(identical(other.webUrl, webUrl) || other.webUrl == webUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,status,originalUrl,canonicalUrl,linkType,payload,error,requiredVersion,redirectUrl,requiresAuth,const DeepCollectionEquality().hash(_requiredPermissions),validatedAt,ttlSeconds,cacheControl,trackingId,const DeepCollectionEquality().hash(_metadata),suggestedAction,priority,isDeferred,fallbackUrl,webUrl]);

@override
String toString() {
  return 'DeepLinkValidationResponse(status: $status, originalUrl: $originalUrl, canonicalUrl: $canonicalUrl, linkType: $linkType, payload: $payload, error: $error, requiredVersion: $requiredVersion, redirectUrl: $redirectUrl, requiresAuth: $requiresAuth, requiredPermissions: $requiredPermissions, validatedAt: $validatedAt, ttlSeconds: $ttlSeconds, cacheControl: $cacheControl, trackingId: $trackingId, metadata: $metadata, suggestedAction: $suggestedAction, priority: $priority, isDeferred: $isDeferred, fallbackUrl: $fallbackUrl, webUrl: $webUrl)';
}


}

/// @nodoc
abstract mixin class _$DeepLinkValidationResponseCopyWith<$Res> implements $DeepLinkValidationResponseCopyWith<$Res> {
  factory _$DeepLinkValidationResponseCopyWith(_DeepLinkValidationResponse value, $Res Function(_DeepLinkValidationResponse) _then) = __$DeepLinkValidationResponseCopyWithImpl;
@override @useResult
$Res call({
 DeepLinkValidationStatus status,@JsonKey(name: 'original_url') String originalUrl,@JsonKey(name: 'canonical_url') String? canonicalUrl,@JsonKey(name: 'link_type') DeepLinkType linkType, DeepLinkPayload? payload, DeepLinkError? error,@JsonKey(name: 'required_version') RequiredVersionInfo? requiredVersion,@JsonKey(name: 'redirect_url') String? redirectUrl,@JsonKey(name: 'requires_auth') bool requiresAuth,@JsonKey(name: 'required_permissions') List<String>? requiredPermissions,@JsonKey(name: 'validated_at') DateTime validatedAt,@JsonKey(name: 'ttl_seconds') int? ttlSeconds,@JsonKey(name: 'cache_control') String? cacheControl,@JsonKey(name: 'tracking_id') String? trackingId,@JsonKey(name: 'metadata') Map<String, dynamic>? metadata,@JsonKey(name: 'suggested_action') String? suggestedAction,@JsonKey(name: 'priority') int priority,@JsonKey(name: 'is_deferred') bool isDeferred,@JsonKey(name: 'fallback_url') String? fallbackUrl,@JsonKey(name: 'web_url') String? webUrl
});


@override $DeepLinkPayloadCopyWith<$Res>? get payload;@override $DeepLinkErrorCopyWith<$Res>? get error;@override $RequiredVersionInfoCopyWith<$Res>? get requiredVersion;

}
/// @nodoc
class __$DeepLinkValidationResponseCopyWithImpl<$Res>
    implements _$DeepLinkValidationResponseCopyWith<$Res> {
  __$DeepLinkValidationResponseCopyWithImpl(this._self, this._then);

  final _DeepLinkValidationResponse _self;
  final $Res Function(_DeepLinkValidationResponse) _then;

/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? originalUrl = null,Object? canonicalUrl = freezed,Object? linkType = null,Object? payload = freezed,Object? error = freezed,Object? requiredVersion = freezed,Object? redirectUrl = freezed,Object? requiresAuth = null,Object? requiredPermissions = freezed,Object? validatedAt = null,Object? ttlSeconds = freezed,Object? cacheControl = freezed,Object? trackingId = freezed,Object? metadata = freezed,Object? suggestedAction = freezed,Object? priority = null,Object? isDeferred = null,Object? fallbackUrl = freezed,Object? webUrl = freezed,}) {
  return _then(_DeepLinkValidationResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as DeepLinkValidationStatus,originalUrl: null == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String,canonicalUrl: freezed == canonicalUrl ? _self.canonicalUrl : canonicalUrl // ignore: cast_nullable_to_non_nullable
as String?,linkType: null == linkType ? _self.linkType : linkType // ignore: cast_nullable_to_non_nullable
as DeepLinkType,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as DeepLinkPayload?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as DeepLinkError?,requiredVersion: freezed == requiredVersion ? _self.requiredVersion : requiredVersion // ignore: cast_nullable_to_non_nullable
as RequiredVersionInfo?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,requiresAuth: null == requiresAuth ? _self.requiresAuth : requiresAuth // ignore: cast_nullable_to_non_nullable
as bool,requiredPermissions: freezed == requiredPermissions ? _self._requiredPermissions : requiredPermissions // ignore: cast_nullable_to_non_nullable
as List<String>?,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,ttlSeconds: freezed == ttlSeconds ? _self.ttlSeconds : ttlSeconds // ignore: cast_nullable_to_non_nullable
as int?,cacheControl: freezed == cacheControl ? _self.cacheControl : cacheControl // ignore: cast_nullable_to_non_nullable
as String?,trackingId: freezed == trackingId ? _self.trackingId : trackingId // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,suggestedAction: freezed == suggestedAction ? _self.suggestedAction : suggestedAction // ignore: cast_nullable_to_non_nullable
as String?,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as int,isDeferred: null == isDeferred ? _self.isDeferred : isDeferred // ignore: cast_nullable_to_non_nullable
as bool,fallbackUrl: freezed == fallbackUrl ? _self.fallbackUrl : fallbackUrl // ignore: cast_nullable_to_non_nullable
as String?,webUrl: freezed == webUrl ? _self.webUrl : webUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepLinkPayloadCopyWith<$Res>? get payload {
    if (_self.payload == null) {
    return null;
  }

  return $DeepLinkPayloadCopyWith<$Res>(_self.payload!, (value) {
    return _then(_self.copyWith(payload: value));
  });
}/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DeepLinkErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $DeepLinkErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}/// Create a copy of DeepLinkValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RequiredVersionInfoCopyWith<$Res>? get requiredVersion {
    if (_self.requiredVersion == null) {
    return null;
  }

  return $RequiredVersionInfoCopyWith<$Res>(_self.requiredVersion!, (value) {
    return _then(_self.copyWith(requiredVersion: value));
  });
}
}

// dart format on
