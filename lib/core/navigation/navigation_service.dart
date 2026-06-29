import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/app_router.dart';
import 'package:get_it/get_it.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  AppRouter get router => GetIt.instance.get<AppRouter>();

  /// Navigates by URL path (e.g. `/login`). [arguments] is not applied here;
  /// use typed [push]/[replace] with a [PageRouteInfo] when you need params.
  Future<void> navigateTo(String routeName, {Object? arguments}) async {
    final path = routeName.startsWith('/') ? routeName : '/$routeName';
    await router.navigatePath(path);
  }

  Future<void> push(PageRouteInfo route) async {
    await router.push(route);
  }

  Future<void> replace(PageRouteInfo route) async {
    await router.replace(route);
  }

  void pop<T extends Object?>([T? result]) async {
     router.pop<T>(result);
  }

  void popUntilRoot() async {
     router.popUntilRoot();
  }

  void popUntilRouteWithName(String routeName) async {
   router.popUntilRouteWithName(routeName);
  }

  void navigateToLogin() {
    router.replaceAll([LoginRoute()]);
  }

  void navigateToDashboard() {
    router.replaceAll([const DashboardRoute()]);
  }

  void navigateToOnboarding() {
    router.replaceAll([const OnboardingRoute()]);
  }

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  bool canPop() {
    return router.canPop();
  }

  String getCurrentRouteName() {
    return router.current.name ?? 'Unknown';
  }

  List<RouteData> getCurrentStack() {
    return router.stackData;
  }
}
