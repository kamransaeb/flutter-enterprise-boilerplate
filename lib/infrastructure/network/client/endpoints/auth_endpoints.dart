abstract class AuthEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String verifyEmail = '/auth/verify-email';
  static const String resendVerificationEmail = '/auth/resend-verification-email';
  static const String sendPasswordResetEmail = '/auth/send-password-reset-email';
  static const String changePassword = '/auth/change-password';
  static const String socialLogin = '/auth/social-login';
  static const String resendVerification = '/auth/resend-verification';
  static const String currentUser = '/auth/current-user';
}