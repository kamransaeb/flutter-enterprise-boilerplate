import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/app/app_widget.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/app_lifecycle/app_lifecycle_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/connectivity/connectivity_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/locale/locale_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/theme/theme_bloc.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:get_it/get_it.dart';

/// Main App widget that sets up all the necessary blocs and providers
/// following VGV enterprise pattern with proper dependency injection
class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppLifecycleBloc _lifecycleBloc;
  late final AuthBloc _authBloc;
  late final ThemeBloc _themeBloc;
  late final LocaleBloc _localeBloc;
  late final ConnectivityBloc _connectivityBloc;
  
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeBlocs();
  }

  @override
  void dispose() {
    _disposeBlocs();
    super.dispose();
  }

  /// Initialize all blocs with proper error handling
  Future<void> _initializeBlocs() async {
    try {
      // Get or create blocs from dependency injection
      _lifecycleBloc = GetIt.instance.get<AppLifecycleBloc>();              
      _authBloc = GetIt.instance.get<AuthBloc>();                  
      _themeBloc = GetIt.instance.get<ThemeBloc>();  
      _localeBloc = GetIt.instance.get<LocaleBloc>();
      _connectivityBloc = GetIt.instance.get<ConnectivityBloc>();
  
      // Add initial events
      _authBloc.add(const AuthEvent.appStarted());
      
      setState(() {
        _isInitialized = true;
      });
      
      logger.i('App: All blocs initialized successfully');
    } catch (error, stackTrace) {
      logger.e('App: Failed to initialize blocs', 
          error: error, 
          stackTrace: stackTrace);
      // Even if initialization fails, we should still show the app
      setState(() {
        _isInitialized = true;
      });
    }
  }


  /// Properly dispose all blocs to prevent memory leaks
  void _disposeBlocs() {
    try {
      _lifecycleBloc.close();
      _authBloc.close();
      _themeBloc.close();
      logger.d('App: All blocs disposed successfully');
    } catch (error) {
      logger.e('App: Error disposing blocs', error: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show loading screen while initializing
    if (!_isInitialized) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    // Provide all blocs to the widget tree
    return MultiBlocProvider(
      providers: [
        // Global blocs that live for the entire app lifecycle
        BlocProvider<AppLifecycleBloc>.value(
          value: _lifecycleBloc,
        ),
        BlocProvider<AuthBloc>.value(
          value: _authBloc,
        ),
        BlocProvider<ThemeBloc>.value(
          value: _themeBloc,
        ),
        BlocProvider<LocaleBloc>.value(
          value: _localeBloc,
        ),
        BlocProvider<ConnectivityBloc>.value(
          value: _connectivityBloc,
        ),
      ],
      // RepositoryProviderActs as a data source for Blocs.
      // A common pattern is to wrap a BlocProvider inside a RepositoryProvider
      // so the Bloc can access the repository via the context.
      // 1. Does not call close()
      // 2. Data Provision/DI
      // 3. Object type: Any class (intended for Repositories)
      // 4. RepositoryProvider.of<T>(context)
      // example: 
      // RepositoryProvider(
      //   create: (context) => UserRepository(),
      //   child: BlocProvider(
      //     create: (context) => AuthBloc(
      //       userRepository: RepositoryProvider.of<UserRepository>(context),
      //     ),
      //     child: MyAppView(),
      //   ),
      // )
      child: const AppWidget(),
    );
  }
}
