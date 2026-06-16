import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/firebase/firebase_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/remote_config_service.dart';

abstract class BaseAutoRouteGuard extends AutoRouteGuard {
  const BaseAutoRouteGuard();

  /// Get current context from the router
  BuildContext? getContext(StackRouter router) {
    return router.navigatorKey.currentContext;
  }

  /// Log navigation attempt.
  void logNavigation(String guardName, String path, bool allowed) {
    logger.d(
      'AutoRouteGuard[$guardName]: $path - ${allowed ? 'ALLOWED' : 'DENIED'}',
    );
  }
}

/// Auth guard that checks if the user is authenticated
class AuthGuard extends BaseAutoRouteGuard {
  final bool requiresAuth;

  const AuthGuard({this.requiresAuth = true});

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final context = getContext(router);
    if (context == null) {
      // Allow navigation to continue
      resolver.resolveNext(true);
      return;
    }
    final authBloc = context.read<AuthBloc>();
    final isAuthenticated = authBloc.state.isAuthenticated;
    // authBloc.state == AuthState.authenticated(User.empty());

    // resolver.route.path: where is the route we are trying to navigate to?
    logNavigation(
      'AuthGuard',
      resolver.route.path,
      isAuthenticated == requiresAuth,
    );

    if (isAuthenticated == requiresAuth) {
      resolver.resolveNext(true);
    } else {
      await _handleInequality(resolver, router);
    }
  }

  Future<void> _handleInequality(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    if (requiresAuth) {
      // The user is not authenticated and the route requires authentication
      await router.push(
        LoginRoute(
          onResult: (success) {
            if (success == true) {
              router.replace(resolver.route as PageRouteInfo<Object?>);
            }
          },
        ),
      );
      resolver.resolveNext(false);
    } else {
      // Authenticated user trying to access a guest-only route (e.g. /login).
      await router.replace(const HomeRoute());
      resolver.resolveNext(false);
    }
  }
}

/// Role-based route guard
class RoleGuard extends BaseAutoRouteGuard {
  final List<String> allowedRoles;
  const RoleGuard({required this.allowedRoles});

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final context = getContext(router);

    if (context == null) {
      resolver.resolveNext(true);
      return;
    }
    final authState = context.read<AuthBloc>().state;
    final user = authState.maybeWhen(
      authenticated: (user) => user,
      orElse: () => null,
    );
    if (user != null) {
      final userRole = user.role;
      final allowed = allowedRoles.contains(userRole);
      if (allowed) {
        logNavigation('RoleGuard', resolver.route.path, true);
        resolver.resolveNext(true);
      } else {
        logNavigation('RoleGuard', resolver.route.path, false);
        await router.replace(const ForbiddenRoute());
        resolver.resolveNext(false);
      }
    } else {
      await router.replace(const LoginRoute());
      resolver.resolveNext(false);
    }
  }
}

/// Feature flage route guard
class FeatureFlagGuard extends BaseAutoRouteGuard {
  final String featureFlag;
  const FeatureFlagGuard({required this.featureFlag});

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final context = getContext(router);
    if (context == null) {
      resolver.resolveNext(true);
      return;
    }

    final remoteConfig = getIt<RemoteConfigeService>();
    final isEnabled = remoteConfig.getBool(featureFlag);
    logNavigation('FeatureFlagGuard', resolver.route.path, isEnabled);
    if (isEnabled) {
      resolver.resolveNext(true);
    } else {
      await router.replace(const NotFoundRoute());
      resolver.resolveNext(false);
    }
  }
}

/// Global analytics guard – can be extended to track navigation events.
class AnalyticsGuard extends BaseAutoRouteGuard {
  const AnalyticsGuard();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final context = getContext(router);
    if (context != null) {
      final firebaseService = getIt<FirebaseService>();
      firebaseService.logScreenView(
        screenName: resolver.route.name,
        screenClass: resolver.route.path,
      );
    }
    resolver.resolveNext(true);
  }
}

/// Global deep-link guard – can be extended to normalize/validate deep links.
class DeepLinkGuard extends BaseAutoRouteGuard {
  const DeepLinkGuard();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final path = resolver.route.path;
    final isValid = _validateDeepLink(path);
    logNavigation('DeepLinkGuard', path, isValid);
    if (isValid) {
      resolver.resolveNext(true);
    } else {
      await router.replace(const NotFoundRoute());
      resolver.resolveNext(false);
    }
  }

  bool _validateDeepLink(String path) {
    if (path.contains('..') || path.contains('//')) {
      return false;
    }
    return true;
  }
}

/// Maintenance mode route guard
/// Blocks navigation to all routes except maintenance page
/// when app is under maintenance
class MaintenanceGuard extends BaseAutoRouteGuard {
  final RemoteConfigService _remoteConfigService = getIt<RemoteConfigService>();
  final List<String> _allowedRoutesDuringMaintenance = [
    '/maintenance',
    '/login',
    '/splash',
    '/forgot-password',
    '/reset-password',
  ];

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final currentPath = resolver.route.path;

    // Check if maintenance mode is enabled
    final isMaintenanceMode = _remoteConfigService.getBool('maintenance_mode');
    logger.d('MaintenanceGuard: $currentPath - $isMaintenanceMode');
    // If not under maintenance, allow navigation
    if (!isMaintenanceMode) {
      resolver.resolveNext(true);
      return;
    }

    // If under maintenance, check if the route is allowed
    final isAllowedRoute = _allowedRoutesDuringMaintenance.contains(
      currentPath,
    );
    if (isAllowedRoute) {
      resolver.resolveNext(true);
    } else {
      logger.d(
        'MaintenanceGuard: $currentPath - Not allowed during maintenance',
      );
      resolver.resolveNext(false);
      await router.replace(const MaintenanceRoute());
    }
  }
}
