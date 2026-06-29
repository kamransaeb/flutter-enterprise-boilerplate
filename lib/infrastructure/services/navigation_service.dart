import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/route_names.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:injectable/injectable.dart';

import '../../core/navigation/app_router.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

/// Navigation service is used to use where context is not available, like in 
/// a bloc or service.
@singleton
class NavigationService {
  final LoggerService _logger;
  final AppRouter _appRouter;

  NavigationService(this._appRouter, this._logger);

  // Router access
  StackRouter get appRouter => _appRouter;

  // Context and route info
  BuildContext? get context => _appRouter.navigatorKey?.currentContext;
  String? get currentRoute => _appRouter.current.name;
  String? get currentPath => _appRouter.current.path;

  // Navigation state
  bool canPop() {
    return _appRouter.canPop();
  }

  // Basic navigation methods
  Future<T?> push<T extends Object?>(PageRouteInfo route) {
    return _appRouter.push<T>(route);
  }

  Future<T?> replace<T extends Object?>(PageRouteInfo route) {
    return _appRouter.replace<T>(route);
  }

  void pop<T extends Object?>([T? result]) {
    if (_appRouter.canPop()) {
      return _appRouter.pop<T>(result);
    }
  }

  Future<T?> popAndPush<T extends Object?, TO extends Object?>(
    PageRouteInfo route, {
    TO? result,
  }) {
    return _appRouter.popAndPush<T, TO>(route, result: result);
  }

  void popUntilRoot() {
    return _appRouter.popUntilRoot();
  }

  void popUntil(bool Function(Route) predicate) {
    return _appRouter.popUntil(predicate);
  }

  // a peridacte is a RoutePredicate: a function that decides when to stop popping
  // predicate: (route) => route.routeName == 'home';
  // the upper bound of the T must be a subtype of Object?
  // In Dart, if you don’t specify a bound, a type parameter gets an implicit bound of Object?.
  Future<T?> pushAndPopUntil<T extends Object?>(
    PageRouteInfo route, {
    required bool Function(Route) predicate,
  }) {
    return _appRouter.pushAndPopUntil(route, predicate: predicate);
  }

  Future<void> pushAndPopUntilRoot(PageRouteInfo route) {
    return _appRouter.pushAndPopUntil(route, predicate: (r) => r.isFirst);
  }

  Future<void> replaceAll(List<PageRouteInfo> routes) {
    return _appRouter.replaceAll(routes);
  }

  // Named navigation methods
  // TODO: Add the missing routes
  // Named navigation methods
  void navigateToLogin({bool replaceAll = false}) {
    if (replaceAll) {
      _appRouter.replaceAll([LoginRoute()]);
    } else {
      _appRouter.push(LoginRoute());
    }
  }

  void navigateToHome({bool replaceAll = false}) {
    if (replaceAll) {
      _appRouter.replaceAll([const HomeRoute()]);
    } else {
      _appRouter.push(const HomeRoute());
    }
  }

  void navigateToSplash() {
    _appRouter.replaceAll([const SplashRoute()]);
  }

  void navigateToOnboarding() {
    _appRouter.replaceAll([const OnboardingRoute()]);
  }

  void navigateToProductDetails(String productId) {
    _appRouter.push(ProductDetailsRoute(id: productId));
  }

  void navigateToOrderDetails(String orderId) {
    _appRouter.push(OrderDetailsRoute(id: orderId));
  }

  void navigateToSettings() {
    _appRouter.push(const SettingsRoute());
  }

  void navigateToSearch() {
    _appRouter.push(const SearchRoute());
  }

  void navigateToCart() {
    _appRouter.push(const CartRoute());
  }

  void navigateToCheckout() {
    _appRouter.push(const CheckoutRoute());
  }

  void navigateToProfile() {
    _appRouter.push(const ProfileRoute());
  }

  void navigateToNotifications() {
    _appRouter.push(const NotificationsRoute());
  }

  // Deep link handling
  Future<void> handleDeepLink(Uri deepLink) async {
    try {
      final route = _parseDeepLink(deepLink);
      if (route != null) {
        await _appRouter.pushAndPopUntil(route, predicate: (r) => r.isFirst);
      }
    } catch (e) {
      _logger.e('Error handling deep link: $e');
    }
  }

  PageRouteInfo? _parseDeepLink(Uri deepLink) {
    final path = deepLink.path;
    final queryParameters = deepLink.queryParameters;

    switch (path) {
      case RoutePaths.productDetails:
        final id = queryParameters[RouteParams.id];
        if (id != null) {
          return ProductDetailsRoute(id: id);
        }
        break;
      case RoutePaths.notifications:
        return const NotificationsRoute();
      case RoutePaths.settings:
        return const SettingsRoute();
      case RoutePaths.profile:
        return const ProfileRoute();
      case RoutePaths.home:
        return const HomeRoute();
      case RoutePaths.dashboard:
        return const DashboardRoute();
    }
    return null;
  }

  // Navigate with arguments
  void navigateWithArguments(String routeName, {Map<String, dynamic>? args}) {
    switch (routeName) {
      case RouteNames.productDetails:
        if (args != null && args.containsKey(RouteParams.id)) {
          navigateToProductDetails(args[RouteParams.id] as String);
        } else {
          _logger.e('[Navigation] Product ID is required for product details');
        }
        break;
      case RouteNames.orderDetails:
        if (args != null && args.containsKey(RouteParams.id)) {
          navigateToOrderDetails(args[RouteParams.id] as String);
        } else {
          _logger.e('Order ID is required for order details');
        }
        break;
    }
  }

  // Future<void> showDialog({
  //   required WidgetBuilder builder,
  //   bool barrierDismissible = true,
  //   Color? barrierColor,
  //   String? barrierLabel,
  //   bool useSafeArea = true,
  //   RouteSettings? routeSettings,
  // }) async {
  //   await showDialog<void>(
  //     context: _router.navigatorKey.currentContext!,
  //     builder: builder,
  //     barrierDismissible: barrierDismissible,
  //     barrierColor: barrierColor,
  //     barrierLabel: barrierLabel,
  //     useSafeArea: useSafeArea,
  //     routeSettings: routeSettings,
  //   );
  // }

  // Future<T?> showBottomSheet<T>({
  //   required WidgetBuilder builder,
  //   Color? backgroundColor,
  //   double? elevation,
  //   ShapeBorder? shape,
  //   Clip? clipBehavior,
  //   BoxConstraints? constraints,
  //   Color? barrierColor,
  //   bool isScrollControlled = false,
  //   bool useRootNavigator = false,
  //   bool isDismissible = true,
  //   bool enableDrag = true,
  //   bool showDragHandle = false,
  //   AnimationController? transitionAnimationController,
  //   Offset? anchorPoint,
  // }) async {
  //   return await showModalBottomSheet<T>(
  //     context: _router.navigatorKey.currentContext!,
  //     builder: builder,
  //     backgroundColor: backgroundColor,
  //     elevation: elevation,
  //     shape: shape,
  //     clipBehavior: clipBehavior,
  //     constraints: constraints,
  //     barrierColor: barrierColor,
  //     isScrollControlled: isScrollControlled,
  //     useRootNavigator: useRootNavigator,
  //     isDismissible: isDismissible,
  //     enableDrag: enableDrag,
  //     showDragHandle: showDragHandle,
  //     transitionAnimationController: transitionAnimationController,
  //     anchorPoint: anchorPoint,
  //   );
  // }

  // ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  //   SnackBar snackBar,
  // ) {
  //   return ScaffoldMessenger.of(
  //     _router.navigatorKey.currentContext!,
  //   ).showSnackBar(snackBar);
  // }

  // void removeCurrentSnackBar({
  //   SnackBarClosedReason reason = SnackBarClosedReason.remove,
  // }) {
  //   ScaffoldMessenger.of(
  //     _router.navigatorKey.currentContext!,
  //   ).removeCurrentSnackBar(reason: reason);
  // }

  // void hideCurrentSnackBar() {
  //   ScaffoldMessenger.of(
  //     _router.navigatorKey.currentContext!,
  //   ).hideCurrentSnackBar();
  // }

  // void showErrorSnackBar(String message) {
  //   final context = _router.navigatorKey.currentContext!;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Theme.of(context).colorScheme.error,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // void showSuccessSnackBar(String message) {
  //   final context = _router.navigatorKey.currentContext!;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Theme.of(context).colorScheme.primary,
  //       behavior: SnackBarBehavior.floating,
  //     ),
  //   );
  // }

  // Future<bool> showConfirmDialog({
  //   required String title,
  //   required String message,
  //   String confirmText = 'Confirm',
  //   String cancelText = 'Cancel',
  //   bool barrierDismissible = true,
  // }) async {
  //   final result = await showDialog<bool>(
  //     context: _appRouter.navigatorKey.currentContext!,
  //     barrierDismissible: barrierDismissible,
  //     builder: (context) => AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: Text(cancelText),
  //         ),
  //         ElevatedButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: Text(confirmText),
  //         ),
  //       ],
  //     ),
  //   );

  //   return result ?? false;
  // }
}

// /// Extension on BuildContext for easy navigation
// extension NavigsationExtensions on BuildContext {
//   NavigationService get navigation => getIt<NavigationService>();
//   StackRouter get router => AppRouter.of(this);

//   // Push methods
//   Future<T?> pushRoute<T extends Object?>(PageRouteInfo route) {
//     return router.push<T>(route);
//   }

//   Future<T?> replaceRoute<T extends Object?>(PageRouteInfo route) {
//     return router.replace<T>(route);
//   }

//   // Pop methods
//   void popRoute<T extends Object?>([T? result]) {
//     if (router.canPop()) router.pop<T>(result);
//   }

//   void popUntilRoot() {
//     return router.popUntilRoot();
//   }

//   // Named navigation
//   void navigateToLogin({bool replaceAll = false}) {
//     navigation.navigateToLogin(replaceAll: replaceAll);
//   }

//   void navigateToHome({bool replaceAll = false}) {
//     navigation.navigateToHome(replaceAll: replaceAll);
//   }

//   void navigateToProductDetails(String productId) {
//     navigation.navigateToProductDetails(productId);
//   }

//   void navigateToOrderDetails(String orderId) {
//     navigation.navigateToOrderDetails(orderId);
//   }

//   void navigateToCart() {
//     navigation.navigateToCart();
//   }  

//   void navigateToCheckout() {
//     navigation.navigateToCheckout();
//   }

//   void navigateToProfile() {
//     navigation.navigateToProfile();
//   }

//   void navigateToSettings() {
//     navigation.navigateToSettings();
//   }

//   void navigateToSearch() {
//     navigation.navigateToSearch();
//   }

//   void navigateToNotifications() {
//     navigation.navigateToNotifications();
//   }

//   void navigateToOnboarding() {
//     navigation.navigateToOnboarding();
//   }

//   // Utility methods
//   bool get canPop => router.canPop();
//   String? get currentRoute => navigation.currentRoute;
//   String? get currentPath => navigation.currentPath;
// }
