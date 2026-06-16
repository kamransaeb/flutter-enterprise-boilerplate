class RouteConstants {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  
  // Main
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String settings = '/settings';
  
  // Products
  static const String products = '/products';
  static const String productDetail = '/products/:id';
  static const String categories = '/categories';
  
  // Orders
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderDetail = '/orders/:id';
  
  // Settings
  static const String editProfile = '/edit-profile';
  static const String changePassword = '/change-password';
  static const String notifications = '/notifications';
  static const String privacy = '/privacy';
  static const String about = '/about';
  
  // Onboarding
  static const String onboarding = '/onboarding';
  
  // Deep Links
  static const String productDeepLink = '/product/:id';
  static const String orderDeepLink = '/order/:id';
}