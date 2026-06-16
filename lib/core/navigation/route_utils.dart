import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Utility class for building routes
abstract class RouteUtils {
  /// Build route path with patameters
  static String buildPath(String pattern, Map<String, String> params) {
    var path = pattern;
    params.forEach((key, value) {
      path = path.replaceAll(':$key', value);
    });
    return path;
  }

  /// Extract parameters from current path
  static Map<String, String> extractParams(String pattern, String path) {
    final patternParts = pattern.split('/');
    final pathParts = path.split('/');
    final params = <String, String>{};
    for (var i = 0; i < patternParts.length; i++) {
      final patternPart = patternParts[i];
      final pathPart = pathParts[i];
      if (patternPart.startsWith(':')) {
        params[patternPart.substring(1)] = pathPart;
      }
    }
    return params;
  }

  /// Check if route is active
  static bool isRouteActive(BuildContext context, String routeName) {
    final router = AutoRouter.of(context);
    return router.current.name == routeName;
  }

  /// Check if any of the routse are acive
  static bool isAnyRouteActive(BuildContext context, List<String> routeNames) {
    final router = AutoRouter.of(context);
    return routeNames.contains(router.current.name);
  }

  /// Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    final router = AutoRouter.of(context);
    return router.current.path;
  }

  /// Get current route stack
  static List<AutoRoutePage<dynamic>> getCurrentStack(BuildContext context) {
    final router = AutoRouter.of(context);
    return router.stack;
  }

  /// Check if route is in stack
  static bool isRouteInStack(BuildContext context, String routeName) {
    final router = AutoRouter.of(context);
    return router.stack.any((route) => route.name == routeName);
  }

  /// Get previous route name
  static String? getPreviousRouteName(BuildContext context) {
    final router = AutoRouter.of(context);
    final stack = router.stack;
    if (stack.length >= 2) {
      return stack[stack.length - 2].name;
    }
  }

  /// Build query string from parameters
  static String buildQueryString(Map<String, String> params) {
    if (params.isEmpty) return '';
    return '?' +
        params.entries
            .map((e) => '${e.key}=${Uri.encodeComponent(e.value)}')
            .join('&');
  }

  /// Parse query parameters from URI
  static Map<String, String> parseQueryString(String uri) {
    final uriObj = Uri.parse(uri);
    return uriObj.queryParameters;
  }

  /// Get route name from route
  static String getRouteName(Route route) {
    if (route is PageRoute) {
      return route.settings.name ?? route.runtimeType.toString();
    }
    return route.runtimeType.toString();
  }

  /// Get route arguments from route
  static Map<String, Object> getRouteArguments(Route route) {
    if (route is PageRoute) {
      final args = route.settings.arguments;
      if (args != null) {
        return {
          'hasArguments': true,
          'argumentType': args.runtimeType.toString(),
        };
      }
    }
    return {'hasArguments': false, 'argumentType': 'null'};
  }
}
