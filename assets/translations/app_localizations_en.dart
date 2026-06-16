// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Enterprise Template';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get signInToContinue => 'Sign in to continue';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get logout => 'Logout';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String get networkErrorMessage =>
      'Network error. Please check your connection.';

  @override
  String get serverErrorMessage => 'Server error. Please try again later.';

  @override
  String get authenticationErrorMessage => 'Please log in again.';

  @override
  String get authorizationErrorMessage =>
      'Access denied. You don\'t have permission to perform this action.';

  @override
  String validationErrorMessage(String message) {
    return 'Validation error: $message';
  }

  @override
  String get notFoundErrorMessage => 'Resource not found.';

  @override
  String get cacheErrorMessage => 'Cache error. Please try again.';

  @override
  String get timeoutErrorMessage => 'Request timeout. Please try again.';

  @override
  String businessErrorMessage(String message) {
    return '$message';
  }

  @override
  String get unknownErrorMessage => 'An unexpected error occurred.';

  @override
  String get tryAgain => 'Try Again';

  @override
  String welcomeUser(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get signUp => 'Sign Up';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get resetPasswordTitle => 'Reset Your Password';

  @override
  String get resetPasswordSubtitle =>
      'Enter your email address and we\'ll send you a link to reset your password';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get backToLogin => 'Back to Login';
}
