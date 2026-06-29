import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/app_router.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/firebase/firebase_service.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/route_utils.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';



class AppRouteObserver extends AutoRouterObserver {
  final LoggerService _logger = getIt<LoggerService>();
  final FirebaseService _firebaseService = getIt<FirebaseService>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _trackRoute(route, 'push', previousRoute: previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _trackRoute(route, 'pop', previousRoute: previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _trackRoute(route, 'remove', previousRoute: previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _trackRoute(newRoute, 'replace', previousRoute: oldRoute);
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    _logger.d('Route gesture started: ${RouteUtils.getRouteName(route)}');
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _logger.d('Route gesture stopped');
  }


  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    super.didInitTabRoute(route, previousRoute);
    _trackTabRoute(route, 'init', previousRoute: previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    super.didChangeTabRoute(route, previousRoute);
    _trackTabRoute(route, 'change', previousRoute: previousRoute);
  }

  void _trackRoute(Route route, String action, {Route? previousRoute}) {
    final routeName = RouteUtils.getRouteName(route);
    final previousRouteName = previousRoute != null ? RouteUtils.getRouteName(previousRoute) : null;
    final arguments = RouteUtils.getRouteArguments(route);
    _logger.d('RouteObserver[$action]: $routeName from $previousRouteName with arguments: ${((arguments['hasArguments'] as bool?) ?? false) ? arguments['argumentType'] : 'none'}');
    // Track screen view for analytics on push or replace
    if (action == 'push' || action == 'replace') { 
      _firebaseService.logScreenView(
        screenName: routeName,
         screenClass: routeName,
          parameters: {
            'previous_screen': previousRouteName ?? 'none',
            ...arguments,
          });
    }
    // Track navigation event for analytics
    _firebaseService.logEvent(
      name: 'navigation_event',
      parameters: {
        'action': action,
        'route_name': routeName,
        'previous_route_name': previousRouteName ?? 'none',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  void _trackTabRoute(TabPageRoute route, String action, {TabPageRoute? previousRoute}) {
    final routeName = route.name;
    final previousRouteName = previousRoute?.name;
    final routePath = route.path;
    _logger.d('TabRouteObserver[$action]: $routeName from $previousRouteName');
    // Track tab change
    _firebaseService.logEvent(
      name: 'tab_changed',
      parameters: {
        'action': action,
        'tab_name': routeName,
        'tab_path': routePath,
        'previous_tab_name': previousRouteName ?? 'none',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
    
    // Track screen view for analytics
    if (action == 'init' || action == 'change') {
      _firebaseService.logScreenView(
         screenName: routeName,
         screenClass: routeName,
         parameters: {
          'tab_path': routePath,
          'previous_tab_name': previousRouteName ?? 'none',
         },
        );
    }
  }
}

/// Performance Route Observer
class PerformanceRouteObserver extends AutoRouterObserver {
  final LoggerService _logger = getIt<LoggerService>();
  final Map<String, DateTime> _routeStartTimes = {};

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    final routeName = RouteUtils.getRouteName(route);
    _routeStartTimes[routeName] = DateTime.now();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    final routeName = RouteUtils.getRouteName(route);
    final startTime = _routeStartTimes[routeName];

    if (startTime != null) {
      final duration = DateTime.now().difference(startTime);
      _logger.d('PerformanceRouteObserver[pop]: $routeName was active ${duration.inMilliseconds}ms');
      _routeStartTimes.remove(routeName);
    }
  }
}

/// Authentication Route Observer
class AuthRouteObserver extends AutoRouterObserver {
  final LoggerService _logger = getIt<LoggerService>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name?.contains('Login') == true || 
    route.settings.name?.contains('Register') == true) {
     _logger.d('Auth route accessed [push]: ${route.settings.name}');
    }
  }
}

/// Deep Link Route Observer
class DeepLinkRouteObserver extends AutoRouterObserver {
  final LoggerService _logger = getIt<LoggerService>();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name?.contains('DeepLink') == true) {
      _logger.d('DeepLink route accessed [push]: ${route.settings.name}');
    }
  }
}

/// Extension for route observer integration
extension RouteObserverExtentsion on StackRouter {
  static final AppRouteObserver _appRouteObserver = AppRouteObserver();
  static final PerformanceRouteObserver _performanceRouteObserver = PerformanceRouteObserver();
  static final AuthRouteObserver _authRouteObserver = AuthRouteObserver();
  static final DeepLinkRouteObserver _deepLinkRouteObserver = DeepLinkRouteObserver();

  /// Get the main route observer
  static AppRouteObserver get appRouteObserver => _appRouteObserver;

  /// Get the performance observer
  static PerformanceRouteObserver get performanceRouteObserver => _performanceRouteObserver;

  /// Get the auth observer
  static AuthRouteObserver get authRouteObserver => _authRouteObserver;

  /// Get the deep link observer
  static DeepLinkRouteObserver get deepLinkRouteObserver => _deepLinkRouteObserver;

  /// Get all observers as a list
  static List<AutoRouterObserver> get allObservers => [
        _appRouteObserver,
        _performanceRouteObserver,
        _authRouteObserver,
        _deepLinkRouteObserver,
      ];
}

/// Extension on AppRouter to get observers for configuration
extension AppRouterObserverExtension on AppRouter {
  // Get all observers as a list
  List<AutoRouterObserver> get allObservers => RouteObserverExtentsion.allObservers;        
}

/// Widget for monitoring route changes 
class RouteMonitor extends StatefulWidget {
  final Widget child;
  final Function(String routeName)? onRouteChanged;

  const RouteMonitor({super.key, required this.child, this.onRouteChanged,});

  @override
  State<RouteMonitor> createState() => _RouteMonitorState();
}

class _RouteMonitorState extends State<RouteMonitor> {
  final LoggerService _logger = getIt<LoggerService>();
  String? _currentRoute;

  @override
  void initState() {
    super.initState();
    _setupRouteListener();    
  }

  void _setupRouteListener() {
   WidgetsBinding.instance.addPostFrameCallback((_) {
    if (mounted) {
      try {
        final router = AutoRouter.of(context);
        _currentRoute = router.current.name;
      } catch (e) {
        _logger.e('Error setting up route listener: $e');
      }
    }
   }); 
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    try { 
      final router = AutoRouter.of(context);
      final newRoute = router.current.name;
      if (_currentRoute != newRoute) {
        _currentRoute = newRoute;
        widget.onRouteChanged?.call(newRoute);
        _logger.d('Route changed: $_currentRoute -> $newRoute');
        // Track analytics for route change
        getIt<FirebaseService>().logEvent(
          name: 'route_changed',
          parameters: {
            'previous_route': _currentRoute ?? 'none',
            'new_route': newRoute,
          },
        );
      }
    } catch (e) {
      _logger.e('Error updating route listener: $e');
    }
  }
}

/// Extension on BuildContext for route observation
extension RouteObservationExtensions on BuildContext {
  /// Get current route name
  String? get currentRouteName {
    try {
      return AutoRouter.of(this).current.name;
    } catch (e) {
      return null;
    }
  }

  /// Get previous route name
  String? get previousRouteName {
    try {
      final router = AutoRouter.of(this);
      final stack = router.stack;
      if (stack.length > 1) {
        return stack[stack.length - 2].name;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Check if current route is a specific route
  bool isCurrentRoute(String routeName) {  
    return currentRouteName == routeName;
  }

  /// Get route stack as list of names
  List<String?> get routeStack {
    try {
      return AutoRouter.of(this).stack.map((route) => route.name).toList();
    } catch (e) {
      return [];
    }
  }
}
