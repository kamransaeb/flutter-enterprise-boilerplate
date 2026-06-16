/// Centralized route names
abstract class RouteNames {
// Splash
static const String splash = 'splash';

// Onboarding
static const String onboarding = 'onboarding';

// Auth
static const String login = 'login';
static const String register = 'register';
static const String forgotPassword = 'forgot-password';
static const String resetPassword = 'reset-password';
static const String verifyEmail = 'verify-email';

// Main tabs
static const String home = 'home';
static const String dashboard = 'dashboard';
static const String products = 'products';
static const String cart = 'cart';
static const String profile = 'profile';

// Product details
static const String productDetails = 'product-details';

// Checkout
static const String checkout = 'checkout';

// Orders
static const String orders = 'orders';
static const String orderDetails = 'order-details';

// Search
static const String search = 'search';

// Notifications
static const String notifications = 'notifications';

// Settings
static const String settings = 'settings';

// Account settings
static const String accountSettings = 'account-settings';

// Notification settings
static const String notificationSettings = 'notification-settings';

// Privacy settings
static const String privacySettings = 'privacy-settings';
static const String securitySettings = 'security-settings';
static const String languageSettings = 'language-settings';
static const String themeSettings = 'theme-settings';

// Error
static const String notFound = 'not-found';
static const String forbidden = 'forbidden';
static const String serverError = 'server-error';
static const String maintenance = 'maintenance';

}

/// Route path patterns
abstract class RoutePaths {
  // Splash
  static const String splash ='/';

  // Onboarding
  static const String onboarding = '/onboarding';

  // Auth
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
  static const String verifyEmail = '/verify-email';

  // Main tabs
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String products = '/products';
  static const String cart = '/cart';
  static const String profile = '/profile';

  // Product details
  static const String productDetails = '/product-details/:id';

  // Checkout
  static const String checkout = '/checkout';

  // Orders
  static const String orders = '/orders';
  static const String orderDetails = '/orders/:id';

  // Search
  static const String search = '/search';

  // Notifications
  static const String notifications = '/notifications';

  // Settings
  static const String settings = '/settings';
  static const String accountSettings = '/account-settings';
  static const String notificationSettings = '/notification-settings';
  static const String privacySettings = '/privacy-settings';
  static const String securitySettings = '/security-settings';
  static const String languageSettings = '/language-settings';
  static const String themeSettings = '/theme-settings';

  // Error
  static const String notFound = '/not-found';
  static const String forbidden = '/forbidden';
  static const String serverError = '/server-error';
  static const String maintenance = '/maintenance';

  // Parameter placholders
  static const String idParam = ':id';
  static const String slugParam = ':slug';
  static const String userIdParam = ':userId';
}

/// Route parameter keys
abstract class RouteParams {
  static const String id = 'id';
  static const String slug = 'slug';
  static const String userId = 'userId';
  static const String productId = 'productId';
  static const String orderId = 'orderId';
  static const String categoryId = 'categoryId';
  static const String returnPath = 'returnPath';
  static const String from = 'from';
}

