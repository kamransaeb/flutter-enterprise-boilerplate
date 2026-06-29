import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/app_lifecycle/app_lifecycle_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/locale/locale_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/theme/theme_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/app_router.dart';
import 'package:flutter_enterprise_boilerplate/core/navigation/route_observers.dart';
import 'package:flutter_enterprise_boilerplate/core/widgets/common/app_lifecycle_observer.dart';
import 'package:flutter_enterprise_boilerplate/core/widgets/connectivity/connectivity_listener.dart';
import 'package:flutter_enterprise_boilerplate/core/widgets/locale_listener.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../app/app_config.dart';
import '../core/themes/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_bloc_observer.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final LoggerService _logger = getIt<LoggerService>();
  late final AppConfig _appConfig;
  late final AppRouter _appRouter;
  late final AppLifecycleObserver _appLifecycleObserver;

  @override
  void initState() {
    super.initState();
    _logger.i(
      'AppWidget: AppRouter registered: ${getIt.isRegistered<AppRouter>()}',
    );
    _appRouter = getIt.isRegistered<AppRouter>()
        ? getIt<AppRouter>()
        : AppRouter();
    _appConfig = getIt.get<AppConfig>();
    final _appLifecycleBloc = context.read<AppLifecycleBloc>();
    _appLifecycleObserver = AppLifecycleObserver(_appLifecycleBloc);
    WidgetsBinding.instance.addObserver(_appLifecycleObserver);
    _logger.i('AppWidget: Initialized');
  }

  @override
  void dispose() {
    _logger.i('AppWidget: Disposed');
    WidgetsBinding.instance.removeObserver(_appLifecycleObserver);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) {
        return EasyLocalization(
          supportedLocales: localeState.supportedLocales,
          path: 'assets/translations',
          fallbackLocale: localeState.fallbackLocale,
          startLocale: localeState.locale,
          saveLocale: true,
          useFallbackTranslations: true,
          child: Builder(
            builder: (context) {
              return BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, themeState) {
                  return MaterialApp.router(
                    title: _appConfig.appName,
                    debugShowCheckedModeBanner: _appConfig.isDev,
                    // Restoration is used to restore the state of the app after a restart.
                    // restorationScopeId: 'app' creates a restoration scope.
                    // Widgets inside that scope can register restorable properties
                    // like RestorationMixin, RestorableInt, RestorableTextEditingController
                    restorationScopeId: 'app',
                    //theme: _getLightTheme(themeState), //AppTheme.lightTheme,
                    //darkTheme: _getDarkTheme(themeState), //AppTheme.darkTheme,
                    theme: AppTheme.getLightTheme(
                      useDynamicColor: themeState.useDynamicColor,
                      fontSizeScale: themeState.fontSizeScale,
                      highContrast: themeState.highContrast,
                    ),
                    darkTheme: AppTheme.getDarkTheme(
                      useDynamicColor: themeState.useDynamicColor,
                      fontSizeScale: themeState.fontSizeScale,
                      highContrast: themeState.highContrast,
                    ),
                    themeMode: themeState.currentThemeStatus.themeMode,
                    //            Router Configuration - Using AutoRoute
                    routerDelegate: AutoRouterDelegate(
                      _appRouter,
                      navigatorObservers: () => [AppRouteObserver()],
                    ),
                    routeInformationParser: _appRouter.defaultRouteParser(),
                    locale: context.locale,
                    localizationsDelegates: [
                      ...context.localizationDelegates,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      // Add custom localization delegates here
                    ],
                    scaffoldMessengerKey: _appRouter.scaffoldMessengerKey,
                    onGenerateTitle: (context) => _appConfig.appName,
                    supportedLocales: context.supportedLocales,
                    routerConfig: _appRouter.config(
                      navigatorObservers: () => [
                        SentryNavigatorObserver(),
                        RouteObserver(),
                      ],
                    ),
                    // Builder for global navigation
                    builder: (context, child) {
                      return _buildWithGlobalListener(context, child);                     
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildWithGlobalListener(BuildContext context, Widget? child) {
    if (child == null) return const SizedBox.shrink();

    return Stack(children: [
      // Main app content
      child,
      const ConnectivityListener(),
      const LocaleListener(),
      // Performance overlay in development mode
      if (_appConfig.isDev) const PerformanceOverlay(),
    ]);
  }
}


class PerformanceOverlay extends StatelessWidget {
  const PerformanceOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'DEV MODE',
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          BlocBuilder<ConnectivityBloc, ConnectivityState>(
            builder: (context, state) {
              return Text(
                state.displayStatus,
                style: TextStyle(
                  color: state.isConnected ? Colors.green : Colors.red,
                  fontSize: 8,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
