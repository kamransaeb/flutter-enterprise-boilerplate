part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const AuthEvent._();

  const factory AuthEvent.appStarted() = _EventAppStarted;

  const factory AuthEvent.checkStatusRequested() = _EventCheckStatusRequested;

  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
    @Default(false) bool rememberMe,
  }) = _EventLoginRequested;
  
  const factory AuthEvent.reqisterRequested({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) = _EventRegisterRequested;

  const factory AuthEvent.logoutRequested() = _EventLogoutRequested;

  const factory AuthEvent.refreshTokenRequested() = _EventRefreshTokenRequested;

  const factory AuthEvent.updateUserRequested(User user) = _EventUpdateUserRequested;
  
  const factory AuthEvent.loginWithGoogleRequested() = _EventLoginWithGoogleRequested;

  const factory AuthEvent.loginWithAppleRequested() = _EventLoginWithAppleRequested;

  const factory AuthEvent.loginWithFacebookRequested() = _EventLoginWithFacebookRequested;

  const factory AuthEvent.forgotPasswordRequested({
    required String email,
  }) = _EventForgotPasswordRequested;

  const factory AuthEvent.resetPasswordRequested({
    required String token,
    required String newPassword,
  }) = _EventResetPasswordRequested;


  const factory AuthEvent.verifyEmailRequested({
    required String token,
    required String email,
  }) = _EventVerifyEmailRequested;

  const factory AuthEvent.resendVerificationEmailRequested({
    required String email,
  }) = _EventResendVerificationEmailRequested;

  const factory AuthEvent.onboardingCompleted() = _EventOnboardingCompleted;

  const factory AuthEvent.firstLaunchDetected() = _EventFirstLaunchDetected;
}



// // App Lifecycle Events
// class AuthAppStarted extends AuthEvent {}

// // Authentication Events
// class AuthLoginRequested extends AuthEvent {
//   final String email;
//   final String password;
//   final bool rememberMe;

//   const AuthLoginRequested({
//     required this.email,
//     required this.password,
//     this.rememberMe = false,
//   });

//   @override
//   List<Object?> get props => [email, password, rememberMe];
// }

// class AuthRegisterRequested extends AuthEvent {
//   final String email;
//   final String password;
//   final String firstName;
//   final String lastName;  

//   const AuthRegisterRequested({
//     required this.email,
//     required this.password,
//     required this.firstName,
//     required this.lastName,
    
//   });

//   @override
//   List<Object?> get props => [email, password, firstName, lastName];
// }

// class AuthLogoutRequested extends AuthEvent {
//   const AuthLogoutRequested();
// }

// class AuthCheckStatusRequested extends AuthEvent {
//   const AuthCheckStatusRequested();
// }

// class AuthRefreshTokenRequested extends AuthEvent {
//   const AuthRefreshTokenRequested();
// }

// class AuthUpdateUserRequested extends AuthEvent {
//   final User user;

//   const AuthUpdateUserRequested(this.user);

//   @override
//   List<Object?> get props => [user];
// }

// // Social Login Events
// class AuthGoogleLoginRequested extends AuthEvent {
//   const AuthGoogleLoginRequested();
// }

// class AuthAppleLoginRequested extends AuthEvent {
//   const AuthAppleLoginRequested();
// }

// class AuthFacebookLoginRequested extends AuthEvent {
//   const AuthFacebookLoginRequested();
// }

// // Password Recovery Events
// class AuthForgotPasswordRequested extends AuthEvent {
//   final String email;

//   const AuthForgotPasswordRequested(this.email);

//   @override
//   List<Object?> get props => [email];
// }

// class AuthResetPasswordRequested extends AuthEvent {
//   final String token;
//   final String newPassword;

//   const AuthResetPasswordRequested({
//     required this.token,
//     required this.newPassword,
//   });

//   @override
//   List<Object?> get props => [token, newPassword];
// }

// // Verification Events
// class AuthVerifyEmailRequested extends AuthEvent {
//   final String token;
//   final String email;

//   const AuthVerifyEmailRequested({
//     required this.token,
//     required this.email,
//   });

//   @override
//   List<Object?> get props => [token, email];
// }

// class AuthResendVerificationEmailRequested extends AuthEvent {
//   final String email;

//   const AuthResendVerificationEmailRequested(this.email);

//   @override
//   List<Object?> get props => [email];
// }

// // Onboarding Events
// class AuthOnboardingCompleted extends AuthEvent {}

// class AuthFirstLaunchDetected extends AuthEvent {}

