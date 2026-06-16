class ApiConstants {
  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  
  // Users
  static const String users = '/users';
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile';
  static const String changePassword = '/users/change-password';
  
  // Products
  static const String products = '/products';
  static const String categories = '/categories';
  
  // Orders
  static const String orders = '/orders';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  
  // Files
  static const String upload = '/upload';
}