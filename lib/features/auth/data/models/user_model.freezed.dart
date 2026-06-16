// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get id; String get email;@JsonKey(name: 'first_name') String? get firstName;@JsonKey(name: 'last_name') String? get lastName;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'phone_number') String? get phoneNumber;@JsonKey(name: 'email_verified') bool? get emailVerified;@JsonKey(name: 'phone_verified') bool get phoneVerified;@JsonKey(name: 'roles') List<String>? get roles;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'logged_in_at') DateTime? get loggedInAt;@JsonKey(name: 'is_profile_completed') bool? get isProfileCompleted;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.phoneVerified, phoneVerified) || other.phoneVerified == phoneVerified)&&const DeepCollectionEquality().equals(other.roles, roles)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.loggedInAt, loggedInAt) || other.loggedInAt == loggedInAt)&&(identical(other.isProfileCompleted, isProfileCompleted) || other.isProfileCompleted == isProfileCompleted)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,avatarUrl,phoneNumber,emailVerified,phoneVerified,const DeepCollectionEquality().hash(roles),createdAt,updatedAt,loggedInAt,isProfileCompleted,isActive);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, emailVerified: $emailVerified, phoneVerified: $phoneVerified, roles: $roles, createdAt: $createdAt, updatedAt: $updatedAt, loggedInAt: $loggedInAt, isProfileCompleted: $isProfileCompleted, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String id, String email,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'email_verified') bool? emailVerified,@JsonKey(name: 'phone_verified') bool phoneVerified,@JsonKey(name: 'roles') List<String>? roles,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'logged_in_at') DateTime? loggedInAt,@JsonKey(name: 'is_profile_completed') bool? isProfileCompleted,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? avatarUrl = freezed,Object? phoneNumber = freezed,Object? emailVerified = freezed,Object? phoneVerified = null,Object? roles = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? loggedInAt = freezed,Object? isProfileCompleted = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,roles: freezed == roles ? _self.roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,loggedInAt: freezed == loggedInAt ? _self.loggedInAt : loggedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isProfileCompleted: freezed == isProfileCompleted ? _self.isProfileCompleted : isProfileCompleted // ignore: cast_nullable_to_non_nullable
as bool?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'email_verified')  bool? emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified, @JsonKey(name: 'roles')  List<String>? roles, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'logged_in_at')  DateTime? loggedInAt, @JsonKey(name: 'is_profile_completed')  bool? isProfileCompleted, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatarUrl,_that.phoneNumber,_that.emailVerified,_that.phoneVerified,_that.roles,_that.createdAt,_that.updatedAt,_that.loggedInAt,_that.isProfileCompleted,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String email, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'email_verified')  bool? emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified, @JsonKey(name: 'roles')  List<String>? roles, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'logged_in_at')  DateTime? loggedInAt, @JsonKey(name: 'is_profile_completed')  bool? isProfileCompleted, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatarUrl,_that.phoneNumber,_that.emailVerified,_that.phoneVerified,_that.roles,_that.createdAt,_that.updatedAt,_that.loggedInAt,_that.isProfileCompleted,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String email, @JsonKey(name: 'first_name')  String? firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'phone_number')  String? phoneNumber, @JsonKey(name: 'email_verified')  bool? emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified, @JsonKey(name: 'roles')  List<String>? roles, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'logged_in_at')  DateTime? loggedInAt, @JsonKey(name: 'is_profile_completed')  bool? isProfileCompleted, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.id,_that.email,_that.firstName,_that.lastName,_that.avatarUrl,_that.phoneNumber,_that.emailVerified,_that.phoneVerified,_that.roles,_that.createdAt,_that.updatedAt,_that.loggedInAt,_that.isProfileCompleted,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.id, required this.email, @JsonKey(name: 'first_name') this.firstName, @JsonKey(name: 'last_name') this.lastName, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'phone_number') this.phoneNumber, @JsonKey(name: 'email_verified') this.emailVerified, @JsonKey(name: 'phone_verified') this.phoneVerified = false, @JsonKey(name: 'roles') final  List<String>? roles, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'logged_in_at') this.loggedInAt, @JsonKey(name: 'is_profile_completed') this.isProfileCompleted, @JsonKey(name: 'is_active') this.isActive = true}): _roles = roles,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String id;
@override final  String email;
@override@JsonKey(name: 'first_name') final  String? firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'phone_number') final  String? phoneNumber;
@override@JsonKey(name: 'email_verified') final  bool? emailVerified;
@override@JsonKey(name: 'phone_verified') final  bool phoneVerified;
 final  List<String>? _roles;
@override@JsonKey(name: 'roles') List<String>? get roles {
  final value = _roles;
  if (value == null) return null;
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'logged_in_at') final  DateTime? loggedInAt;
@override@JsonKey(name: 'is_profile_completed') final  bool? isProfileCompleted;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.email, email) || other.email == email)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.phoneVerified, phoneVerified) || other.phoneVerified == phoneVerified)&&const DeepCollectionEquality().equals(other._roles, _roles)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.loggedInAt, loggedInAt) || other.loggedInAt == loggedInAt)&&(identical(other.isProfileCompleted, isProfileCompleted) || other.isProfileCompleted == isProfileCompleted)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,email,firstName,lastName,avatarUrl,phoneNumber,emailVerified,phoneVerified,const DeepCollectionEquality().hash(_roles),createdAt,updatedAt,loggedInAt,isProfileCompleted,isActive);

@override
String toString() {
  return 'UserModel(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, emailVerified: $emailVerified, phoneVerified: $phoneVerified, roles: $roles, createdAt: $createdAt, updatedAt: $updatedAt, loggedInAt: $loggedInAt, isProfileCompleted: $isProfileCompleted, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String email,@JsonKey(name: 'first_name') String? firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'phone_number') String? phoneNumber,@JsonKey(name: 'email_verified') bool? emailVerified,@JsonKey(name: 'phone_verified') bool phoneVerified,@JsonKey(name: 'roles') List<String>? roles,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'logged_in_at') DateTime? loggedInAt,@JsonKey(name: 'is_profile_completed') bool? isProfileCompleted,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? email = null,Object? firstName = freezed,Object? lastName = freezed,Object? avatarUrl = freezed,Object? phoneNumber = freezed,Object? emailVerified = freezed,Object? phoneVerified = null,Object? roles = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? loggedInAt = freezed,Object? isProfileCompleted = freezed,Object? isActive = null,}) {
  return _then(_UserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool?,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,roles: freezed == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,loggedInAt: freezed == loggedInAt ? _self.loggedInAt : loggedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isProfileCompleted: freezed == isProfileCompleted ? _self.isProfileCompleted : isProfileCompleted // ignore: cast_nullable_to_non_nullable
as bool?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
