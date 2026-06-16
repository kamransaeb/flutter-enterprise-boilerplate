// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  appStarted,TResult Function()?  checkStatusRequested,TResult Function( String email,  String password,  bool rememberMe)?  loginRequested,TResult Function( String email,  String password,  String firstName,  String lastName)?  reqisterRequested,TResult Function()?  logoutRequested,TResult Function()?  refreshTokenRequested,TResult Function( User user)?  updateUserRequested,TResult Function()?  loginWithGoogleRequested,TResult Function()?  loginWithAppleRequested,TResult Function()?  loginWithFacebookRequested,TResult Function( String email)?  forgotPasswordRequested,TResult Function( String token,  String newPassword)?  resetPasswordRequested,TResult Function( String token,  String email)?  verifyEmailRequested,TResult Function( String email)?  resendVerificationEmailRequested,TResult Function()?  onboardingCompleted,TResult Function()?  firstLaunchDetected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAppStarted() when appStarted != null:
return appStarted();case _EventCheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case _EventLoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password,_that.rememberMe);case _EventRegisterRequested() when reqisterRequested != null:
return reqisterRequested(_that.email,_that.password,_that.firstName,_that.lastName);case _EventLogoutRequested() when logoutRequested != null:
return logoutRequested();case _EventRefreshTokenRequested() when refreshTokenRequested != null:
return refreshTokenRequested();case _EventUpdateUserRequested() when updateUserRequested != null:
return updateUserRequested(_that.user);case _EventLoginWithGoogleRequested() when loginWithGoogleRequested != null:
return loginWithGoogleRequested();case _EventLoginWithAppleRequested() when loginWithAppleRequested != null:
return loginWithAppleRequested();case _EventLoginWithFacebookRequested() when loginWithFacebookRequested != null:
return loginWithFacebookRequested();case _EventForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case _EventResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.token,_that.newPassword);case _EventVerifyEmailRequested() when verifyEmailRequested != null:
return verifyEmailRequested(_that.token,_that.email);case _EventResendVerificationEmailRequested() when resendVerificationEmailRequested != null:
return resendVerificationEmailRequested(_that.email);case _EventOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case _EventFirstLaunchDetected() when firstLaunchDetected != null:
return firstLaunchDetected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  appStarted,required TResult Function()  checkStatusRequested,required TResult Function( String email,  String password,  bool rememberMe)  loginRequested,required TResult Function( String email,  String password,  String firstName,  String lastName)  reqisterRequested,required TResult Function()  logoutRequested,required TResult Function()  refreshTokenRequested,required TResult Function( User user)  updateUserRequested,required TResult Function()  loginWithGoogleRequested,required TResult Function()  loginWithAppleRequested,required TResult Function()  loginWithFacebookRequested,required TResult Function( String email)  forgotPasswordRequested,required TResult Function( String token,  String newPassword)  resetPasswordRequested,required TResult Function( String token,  String email)  verifyEmailRequested,required TResult Function( String email)  resendVerificationEmailRequested,required TResult Function()  onboardingCompleted,required TResult Function()  firstLaunchDetected,}) {final _that = this;
switch (_that) {
case _EventAppStarted():
return appStarted();case _EventCheckStatusRequested():
return checkStatusRequested();case _EventLoginRequested():
return loginRequested(_that.email,_that.password,_that.rememberMe);case _EventRegisterRequested():
return reqisterRequested(_that.email,_that.password,_that.firstName,_that.lastName);case _EventLogoutRequested():
return logoutRequested();case _EventRefreshTokenRequested():
return refreshTokenRequested();case _EventUpdateUserRequested():
return updateUserRequested(_that.user);case _EventLoginWithGoogleRequested():
return loginWithGoogleRequested();case _EventLoginWithAppleRequested():
return loginWithAppleRequested();case _EventLoginWithFacebookRequested():
return loginWithFacebookRequested();case _EventForgotPasswordRequested():
return forgotPasswordRequested(_that.email);case _EventResetPasswordRequested():
return resetPasswordRequested(_that.token,_that.newPassword);case _EventVerifyEmailRequested():
return verifyEmailRequested(_that.token,_that.email);case _EventResendVerificationEmailRequested():
return resendVerificationEmailRequested(_that.email);case _EventOnboardingCompleted():
return onboardingCompleted();case _EventFirstLaunchDetected():
return firstLaunchDetected();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  appStarted,TResult? Function()?  checkStatusRequested,TResult? Function( String email,  String password,  bool rememberMe)?  loginRequested,TResult? Function( String email,  String password,  String firstName,  String lastName)?  reqisterRequested,TResult? Function()?  logoutRequested,TResult? Function()?  refreshTokenRequested,TResult? Function( User user)?  updateUserRequested,TResult? Function()?  loginWithGoogleRequested,TResult? Function()?  loginWithAppleRequested,TResult? Function()?  loginWithFacebookRequested,TResult? Function( String email)?  forgotPasswordRequested,TResult? Function( String token,  String newPassword)?  resetPasswordRequested,TResult? Function( String token,  String email)?  verifyEmailRequested,TResult? Function( String email)?  resendVerificationEmailRequested,TResult? Function()?  onboardingCompleted,TResult? Function()?  firstLaunchDetected,}) {final _that = this;
switch (_that) {
case _EventAppStarted() when appStarted != null:
return appStarted();case _EventCheckStatusRequested() when checkStatusRequested != null:
return checkStatusRequested();case _EventLoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password,_that.rememberMe);case _EventRegisterRequested() when reqisterRequested != null:
return reqisterRequested(_that.email,_that.password,_that.firstName,_that.lastName);case _EventLogoutRequested() when logoutRequested != null:
return logoutRequested();case _EventRefreshTokenRequested() when refreshTokenRequested != null:
return refreshTokenRequested();case _EventUpdateUserRequested() when updateUserRequested != null:
return updateUserRequested(_that.user);case _EventLoginWithGoogleRequested() when loginWithGoogleRequested != null:
return loginWithGoogleRequested();case _EventLoginWithAppleRequested() when loginWithAppleRequested != null:
return loginWithAppleRequested();case _EventLoginWithFacebookRequested() when loginWithFacebookRequested != null:
return loginWithFacebookRequested();case _EventForgotPasswordRequested() when forgotPasswordRequested != null:
return forgotPasswordRequested(_that.email);case _EventResetPasswordRequested() when resetPasswordRequested != null:
return resetPasswordRequested(_that.token,_that.newPassword);case _EventVerifyEmailRequested() when verifyEmailRequested != null:
return verifyEmailRequested(_that.token,_that.email);case _EventResendVerificationEmailRequested() when resendVerificationEmailRequested != null:
return resendVerificationEmailRequested(_that.email);case _EventOnboardingCompleted() when onboardingCompleted != null:
return onboardingCompleted();case _EventFirstLaunchDetected() when firstLaunchDetected != null:
return firstLaunchDetected();case _:
  return null;

}
}

}

/// @nodoc


class _EventAppStarted extends AuthEvent {
  const _EventAppStarted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAppStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.appStarted()';
}


}




/// @nodoc


class _EventCheckStatusRequested extends AuthEvent {
  const _EventCheckStatusRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventCheckStatusRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.checkStatusRequested()';
}


}




/// @nodoc


class _EventLoginRequested extends AuthEvent {
  const _EventLoginRequested({required this.email, required this.password, this.rememberMe = false}): super._();
  

 final  String email;
 final  String password;
@JsonKey() final  bool rememberMe;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventLoginRequestedCopyWith<_EventLoginRequested> get copyWith => __$EventLoginRequestedCopyWithImpl<_EventLoginRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoginRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.rememberMe, rememberMe) || other.rememberMe == rememberMe));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,rememberMe);

@override
String toString() {
  return 'AuthEvent.loginRequested(email: $email, password: $password, rememberMe: $rememberMe)';
}


}

/// @nodoc
abstract mixin class _$EventLoginRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventLoginRequestedCopyWith(_EventLoginRequested value, $Res Function(_EventLoginRequested) _then) = __$EventLoginRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool rememberMe
});




}
/// @nodoc
class __$EventLoginRequestedCopyWithImpl<$Res>
    implements _$EventLoginRequestedCopyWith<$Res> {
  __$EventLoginRequestedCopyWithImpl(this._self, this._then);

  final _EventLoginRequested _self;
  final $Res Function(_EventLoginRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? rememberMe = null,}) {
  return _then(_EventLoginRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,rememberMe: null == rememberMe ? _self.rememberMe : rememberMe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _EventRegisterRequested extends AuthEvent {
  const _EventRegisterRequested({required this.email, required this.password, required this.firstName, required this.lastName}): super._();
  

 final  String email;
 final  String password;
 final  String firstName;
 final  String lastName;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventRegisterRequestedCopyWith<_EventRegisterRequested> get copyWith => __$EventRegisterRequestedCopyWithImpl<_EventRegisterRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRegisterRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,firstName,lastName);

@override
String toString() {
  return 'AuthEvent.reqisterRequested(email: $email, password: $password, firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$EventRegisterRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventRegisterRequestedCopyWith(_EventRegisterRequested value, $Res Function(_EventRegisterRequested) _then) = __$EventRegisterRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password, String firstName, String lastName
});




}
/// @nodoc
class __$EventRegisterRequestedCopyWithImpl<$Res>
    implements _$EventRegisterRequestedCopyWith<$Res> {
  __$EventRegisterRequestedCopyWithImpl(this._self, this._then);

  final _EventRegisterRequested _self;
  final $Res Function(_EventRegisterRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? firstName = null,Object? lastName = null,}) {
  return _then(_EventRegisterRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EventLogoutRequested extends AuthEvent {
  const _EventLogoutRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




/// @nodoc


class _EventRefreshTokenRequested extends AuthEvent {
  const _EventRefreshTokenRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventRefreshTokenRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.refreshTokenRequested()';
}


}




/// @nodoc


class _EventUpdateUserRequested extends AuthEvent {
  const _EventUpdateUserRequested(this.user): super._();
  

 final  User user;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventUpdateUserRequestedCopyWith<_EventUpdateUserRequested> get copyWith => __$EventUpdateUserRequestedCopyWithImpl<_EventUpdateUserRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventUpdateUserRequested&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthEvent.updateUserRequested(user: $user)';
}


}

/// @nodoc
abstract mixin class _$EventUpdateUserRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventUpdateUserRequestedCopyWith(_EventUpdateUserRequested value, $Res Function(_EventUpdateUserRequested) _then) = __$EventUpdateUserRequestedCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$EventUpdateUserRequestedCopyWithImpl<$Res>
    implements _$EventUpdateUserRequestedCopyWith<$Res> {
  __$EventUpdateUserRequestedCopyWithImpl(this._self, this._then);

  final _EventUpdateUserRequested _self;
  final $Res Function(_EventUpdateUserRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_EventUpdateUserRequested(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _EventLoginWithGoogleRequested extends AuthEvent {
  const _EventLoginWithGoogleRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoginWithGoogleRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loginWithGoogleRequested()';
}


}




/// @nodoc


class _EventLoginWithAppleRequested extends AuthEvent {
  const _EventLoginWithAppleRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoginWithAppleRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loginWithAppleRequested()';
}


}




/// @nodoc


class _EventLoginWithFacebookRequested extends AuthEvent {
  const _EventLoginWithFacebookRequested(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventLoginWithFacebookRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.loginWithFacebookRequested()';
}


}




/// @nodoc


class _EventForgotPasswordRequested extends AuthEvent {
  const _EventForgotPasswordRequested({required this.email}): super._();
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventForgotPasswordRequestedCopyWith<_EventForgotPasswordRequested> get copyWith => __$EventForgotPasswordRequestedCopyWithImpl<_EventForgotPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventForgotPasswordRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.forgotPasswordRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EventForgotPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventForgotPasswordRequestedCopyWith(_EventForgotPasswordRequested value, $Res Function(_EventForgotPasswordRequested) _then) = __$EventForgotPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EventForgotPasswordRequestedCopyWithImpl<$Res>
    implements _$EventForgotPasswordRequestedCopyWith<$Res> {
  __$EventForgotPasswordRequestedCopyWithImpl(this._self, this._then);

  final _EventForgotPasswordRequested _self;
  final $Res Function(_EventForgotPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EventForgotPasswordRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EventResetPasswordRequested extends AuthEvent {
  const _EventResetPasswordRequested({required this.token, required this.newPassword}): super._();
  

 final  String token;
 final  String newPassword;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventResetPasswordRequestedCopyWith<_EventResetPasswordRequested> get copyWith => __$EventResetPasswordRequestedCopyWithImpl<_EventResetPasswordRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResetPasswordRequested&&(identical(other.token, token) || other.token == token)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,token,newPassword);

@override
String toString() {
  return 'AuthEvent.resetPasswordRequested(token: $token, newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class _$EventResetPasswordRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventResetPasswordRequestedCopyWith(_EventResetPasswordRequested value, $Res Function(_EventResetPasswordRequested) _then) = __$EventResetPasswordRequestedCopyWithImpl;
@useResult
$Res call({
 String token, String newPassword
});




}
/// @nodoc
class __$EventResetPasswordRequestedCopyWithImpl<$Res>
    implements _$EventResetPasswordRequestedCopyWith<$Res> {
  __$EventResetPasswordRequestedCopyWithImpl(this._self, this._then);

  final _EventResetPasswordRequested _self;
  final $Res Function(_EventResetPasswordRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,Object? newPassword = null,}) {
  return _then(_EventResetPasswordRequested(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EventVerifyEmailRequested extends AuthEvent {
  const _EventVerifyEmailRequested({required this.token, required this.email}): super._();
  

 final  String token;
 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventVerifyEmailRequestedCopyWith<_EventVerifyEmailRequested> get copyWith => __$EventVerifyEmailRequestedCopyWithImpl<_EventVerifyEmailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventVerifyEmailRequested&&(identical(other.token, token) || other.token == token)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,token,email);

@override
String toString() {
  return 'AuthEvent.verifyEmailRequested(token: $token, email: $email)';
}


}

/// @nodoc
abstract mixin class _$EventVerifyEmailRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventVerifyEmailRequestedCopyWith(_EventVerifyEmailRequested value, $Res Function(_EventVerifyEmailRequested) _then) = __$EventVerifyEmailRequestedCopyWithImpl;
@useResult
$Res call({
 String token, String email
});




}
/// @nodoc
class __$EventVerifyEmailRequestedCopyWithImpl<$Res>
    implements _$EventVerifyEmailRequestedCopyWith<$Res> {
  __$EventVerifyEmailRequestedCopyWithImpl(this._self, this._then);

  final _EventVerifyEmailRequested _self;
  final $Res Function(_EventVerifyEmailRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? token = null,Object? email = null,}) {
  return _then(_EventVerifyEmailRequested(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EventResendVerificationEmailRequested extends AuthEvent {
  const _EventResendVerificationEmailRequested({required this.email}): super._();
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventResendVerificationEmailRequestedCopyWith<_EventResendVerificationEmailRequested> get copyWith => __$EventResendVerificationEmailRequestedCopyWithImpl<_EventResendVerificationEmailRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventResendVerificationEmailRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.resendVerificationEmailRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EventResendVerificationEmailRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory _$EventResendVerificationEmailRequestedCopyWith(_EventResendVerificationEmailRequested value, $Res Function(_EventResendVerificationEmailRequested) _then) = __$EventResendVerificationEmailRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EventResendVerificationEmailRequestedCopyWithImpl<$Res>
    implements _$EventResendVerificationEmailRequestedCopyWith<$Res> {
  __$EventResendVerificationEmailRequestedCopyWithImpl(this._self, this._then);

  final _EventResendVerificationEmailRequested _self;
  final $Res Function(_EventResendVerificationEmailRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EventResendVerificationEmailRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EventOnboardingCompleted extends AuthEvent {
  const _EventOnboardingCompleted(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventOnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.onboardingCompleted()';
}


}




/// @nodoc


class _EventFirstLaunchDetected extends AuthEvent {
  const _EventFirstLaunchDetected(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventFirstLaunchDetected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.firstLaunchDetected()';
}


}




/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  checkingAuth,TResult Function()?  loading,TResult Function( User user)?  authenticated,TResult Function( bool isFirstLaunch,  bool requiresOnboarding)?  unauthenticated,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateCheckingAuth() when checkingAuth != null:
return checkingAuth();case _StateLoading() when loading != null:
return loading();case _StateAuthenticated() when authenticated != null:
return authenticated(_that.user);case _StateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.isFirstLaunch,_that.requiresOnboarding);case _StateFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  checkingAuth,required TResult Function()  loading,required TResult Function( User user)  authenticated,required TResult Function( bool isFirstLaunch,  bool requiresOnboarding)  unauthenticated,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case _StateInitial():
return initial();case _StateCheckingAuth():
return checkingAuth();case _StateLoading():
return loading();case _StateAuthenticated():
return authenticated(_that.user);case _StateUnauthenticated():
return unauthenticated(_that.isFirstLaunch,_that.requiresOnboarding);case _StateFailure():
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  checkingAuth,TResult? Function()?  loading,TResult? Function( User user)?  authenticated,TResult? Function( bool isFirstLaunch,  bool requiresOnboarding)?  unauthenticated,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case _StateInitial() when initial != null:
return initial();case _StateCheckingAuth() when checkingAuth != null:
return checkingAuth();case _StateLoading() when loading != null:
return loading();case _StateAuthenticated() when authenticated != null:
return authenticated(_that.user);case _StateUnauthenticated() when unauthenticated != null:
return unauthenticated(_that.isFirstLaunch,_that.requiresOnboarding);case _StateFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _StateInitial extends AuthState {
  const _StateInitial(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.initial()';
}


}




/// @nodoc


class _StateCheckingAuth extends AuthState {
  const _StateCheckingAuth(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateCheckingAuth);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.checkingAuth()';
}


}




/// @nodoc


class _StateLoading extends AuthState {
  const _StateLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.loading()';
}


}




/// @nodoc


class _StateAuthenticated extends AuthState {
  const _StateAuthenticated({required this.user}): super._();
  

 final  User user;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateAuthenticatedCopyWith<_StateAuthenticated> get copyWith => __$StateAuthenticatedCopyWithImpl<_StateAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateAuthenticated&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthState.authenticated(user: $user)';
}


}

/// @nodoc
abstract mixin class _$StateAuthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$StateAuthenticatedCopyWith(_StateAuthenticated value, $Res Function(_StateAuthenticated) _then) = __$StateAuthenticatedCopyWithImpl;
@useResult
$Res call({
 User user
});


$UserCopyWith<$Res> get user;

}
/// @nodoc
class __$StateAuthenticatedCopyWithImpl<$Res>
    implements _$StateAuthenticatedCopyWith<$Res> {
  __$StateAuthenticatedCopyWithImpl(this._self, this._then);

  final _StateAuthenticated _self;
  final $Res Function(_StateAuthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(_StateAuthenticated(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get user {
  
  return $UserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class _StateUnauthenticated extends AuthState {
  const _StateUnauthenticated({this.isFirstLaunch = false, this.requiresOnboarding = false}): super._();
  

@JsonKey() final  bool isFirstLaunch;
@JsonKey() final  bool requiresOnboarding;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateUnauthenticatedCopyWith<_StateUnauthenticated> get copyWith => __$StateUnauthenticatedCopyWithImpl<_StateUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateUnauthenticated&&(identical(other.isFirstLaunch, isFirstLaunch) || other.isFirstLaunch == isFirstLaunch)&&(identical(other.requiresOnboarding, requiresOnboarding) || other.requiresOnboarding == requiresOnboarding));
}


@override
int get hashCode => Object.hash(runtimeType,isFirstLaunch,requiresOnboarding);

@override
String toString() {
  return 'AuthState.unauthenticated(isFirstLaunch: $isFirstLaunch, requiresOnboarding: $requiresOnboarding)';
}


}

/// @nodoc
abstract mixin class _$StateUnauthenticatedCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$StateUnauthenticatedCopyWith(_StateUnauthenticated value, $Res Function(_StateUnauthenticated) _then) = __$StateUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 bool isFirstLaunch, bool requiresOnboarding
});




}
/// @nodoc
class __$StateUnauthenticatedCopyWithImpl<$Res>
    implements _$StateUnauthenticatedCopyWith<$Res> {
  __$StateUnauthenticatedCopyWithImpl(this._self, this._then);

  final _StateUnauthenticated _self;
  final $Res Function(_StateUnauthenticated) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isFirstLaunch = null,Object? requiresOnboarding = null,}) {
  return _then(_StateUnauthenticated(
isFirstLaunch: null == isFirstLaunch ? _self.isFirstLaunch : isFirstLaunch // ignore: cast_nullable_to_non_nullable
as bool,requiresOnboarding: null == requiresOnboarding ? _self.requiresOnboarding : requiresOnboarding // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _StateFailure extends AuthState {
  const _StateFailure({required this.failure}): super._();
  

 final  Failure failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StateFailureCopyWith<_StateFailure> get copyWith => __$StateFailureCopyWithImpl<_StateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StateFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$StateFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$StateFailureCopyWith(_StateFailure value, $Res Function(_StateFailure) _then) = __$StateFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class __$StateFailureCopyWithImpl<$Res>
    implements _$StateFailureCopyWith<$Res> {
  __$StateFailureCopyWithImpl(this._self, this._then);

  final _StateFailure _self;
  final $Res Function(_StateFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(_StateFailure(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
