import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:injectable/injectable.dart';

import 'app_config.dart';

@singleton
class AppBlocObserver extends BlocObserver {
  final AppConfig appConfig;

  AppBlocObserver({required this.appConfig});

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (appConfig.enableLogging) {
      logger.d('Bloc created: ${bloc.runtimeType}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (appConfig.enableLogging) {
      logger.d('Event: ${event.runtimeType} in ${bloc.runtimeType}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (appConfig.enableLogging) {
      logger.d('Change: $change in ${bloc.runtimeType}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (appConfig.enableLogging) {
      logger.d('Transition: $transition in ${bloc.runtimeType}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('Error in ${bloc.runtimeType}', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (appConfig.enableLogging) {
      logger.d('Bloc closed: ${bloc.runtimeType}');
    }
  }
}