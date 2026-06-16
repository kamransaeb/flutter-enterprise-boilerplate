import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/route_observers.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'route_guards.dart';
import 'route_transitions.dart';

part 'app_router.gr.dart';

// Why AutoRoute over GoRouter?
// 1. Compile-Time Type Safety (The "Oops" Prevention)
// auto_route: Generates a specific class for every route.
// go_router: If you make a typo in the path or forget a parameter,
// your app might crash at runtime.

// 2. Effortless Nested Navigation (The "Bottom Navigation Bar" Example)
// Handling a Bottom Navigation Bar where each tab has its own independent
// "stack" is notoriously boilerplate-heavy in go_router.
// go_router: Requires setting up a StatefulShellRoute,
// multiple Branches, and manual index management.
// auto_route: Provides AutoTabsRouter. It handles the stack persistence
// automatically. You just list the routes, and it "just works."

// 3. Native-Feeling Guards (The "Login Redirect")
// If you need to protect a route (e.g., /profile),
// auto_route uses Route Guards which feel like middleware.
// go_router: uses a redirect function that runs every time the location
// changes. It can get messy with complex logic.

// @AutoRouterConfig is an AutoRoute annotiation that tells the code generator 
// how to generate routing code for this router.
// RootStackRouter
// Root: the top level router, passed to MaterialApp.router
// Stack: It manages stack of routes
// Router: It implements RouterDelegate and works with declarative routing
// (RouterConfig, GoRouter))
@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();  

  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: RouteTransitions.slideFromRight,
    duration: Duration(milliseconds: 300),
  );

  @override
  List<AutoRoute> get routes => [
    // Splash route - initial
    AutoRoute(page: SplashRoute.page, initial: true, path: '/'),

    // Onboarding routes
    AutoRoute(
      page: OnboardingRoute.page,
      path: '/onboarding',
      guards: [AuthGuard(requiresAuth: false)],
    ),

    // Auth routes (unauthenticated only)
    AutoRoute(
      page: LoginRoute.page,
      path: '/login',
      guards: [AuthGuard(requiresAuth: false)],
    ),
    AutoRoute(
      page: RegisterRoute.page,
      path: '/register',
      guards: [AuthGuard(requiresAuth: false)],
    ),
    AutoRoute(
      page: ForgotPasswordRoute.page,
      path: '/forgot-password',
      guards: [AuthGuard(requiresAuth: false)],
    ),
    AutoRoute(
      page: ResetPasswordRoute.page,
      path: '/reset-password',
      guards: [AuthGuard(requiresAuth: false)],
    ),
    AutoRoute(
      page: VerifyEmailRoute.page,
      path: '/verify-email',
      guards: [AuthGuard(requiresAuth: false)],
    ),

    // Main app shell with bottom navigation (authenticated only)
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [AuthGuard(requiresAuth: true)],
      children: [
        AutoRoute(page: DashboardRoute.page, path: 'dashboard', initial: true),
        AutoRoute(page: ProductsRoute.page, path: 'products'),
        AutoRoute(page: CartRoute.page, path: 'cart'),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
      ],
    ),

    // Product routes
    AutoRoute(
      page: ProductDetailsRoute.page,
      path: '/product/:id',
      guards: [AuthGuard(requiresAuth: true)],
    ),

    // Checkout routes
    AutoRoute(
      page: CheckoutRoute.page,
      path: '/checkout',
      guards: [AuthGuard(requiresAuth: true)],
    ),

    // Orders routes
    AutoRoute(
      page: OrdersRoute.page,
      path: '/orders',
      guards: [AuthGuard(requiresAuth: true)],
    ),
    AutoRoute(
      page: OrderDetailsRoute.page,
      path: '/orders/:id',
      guards: [AuthGuard(requiresAuth: true)],
    ),

    // Search routes
    AutoRoute(
      page: SearchRoute.page,
      path: '/search',
      guards: [AuthGuard(requiresAuth: true)],
    ),

    // Notifications routes
    AutoRoute(
      page: NotificationsRoute.page,
      path: '/notifications',
      guards: [AuthGuard(requiresAuth: true)],
    ),

    // Settings routes
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
      guards: [AuthGuard(requiresAuth: true)],
      children: [
        AutoRoute(
          page: AccountSettingsRoute.page,
          path: 'account',
          initial: true,
        ),
        AutoRoute(page: NotificationSettingsRoute.page, path: 'notifications'),
        AutoRoute(page: PrivacySettingsRoute.page, path: 'privacy'),
      ],
    ),

    // Error routes
    AutoRoute(page: NotFoundRoute.page, path: '/404'),
    AutoRoute(page: ForbiddenRoute.page, path: '/403'),
    AutoRoute(page: MaintenanceRoute.page, path: '/maintenance'),

    // Wildcard redirect to 404
    RedirectRoute(path: '*', redirectTo: '/404'),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // Global guards
    AnalyticsGuard(),
    DeepLinkGuard(),
    AuthGuard(requiresAuth: true),
    MaintenanceGuard(),
  ];

  @override
  List<AutoRouterObserver> get observers =>
      RouteObserverExtentsion.allObservers;

  // @override
  // List<NavigatorObserver> get navigatorObservers => [
  //   AppRouteObserver(),
  // ];

}
// void main() {
//   final appRouter = AppRouter();
  
//   runApp(
//     MaterialApp.router(
//       routerConfig: appRouter.config(
//         // Observers are automatically included from the router's observers list
//         // No need to add them manually here
//       ),
//     ),
//   );
// }