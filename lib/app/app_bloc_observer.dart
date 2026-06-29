import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'app_config.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

@singleton
class AppBlocObserver extends BlocObserver {
  final LoggerService _logger;
  final AppConfig appConfig;

  AppBlocObserver({required this.appConfig, required LoggerService logger})
      : _logger = logger;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (appConfig.enableLogging) {
      _logger.d('Bloc created: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (appConfig.enableLogging) {
      _logger.d('Event: ${event.runtimeType} in ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (appConfig.enableLogging) {
      _logger.d('Change: $change in ${bloc.runtimeType}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (appConfig.enableLogging) {
      _logger.d('Transition: $transition in ${bloc.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.e('Error in ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (appConfig.enableLogging) {
      _logger.d('Bloc closed: ${bloc.runtimeType}');
    }
  }
}