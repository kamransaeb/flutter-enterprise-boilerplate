import 'dart:ui' as flutter;

import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/app_lifecycle/app_lifecycle_bloc.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  final AppLifecycleBloc appLifecycleBloc;

  AppLifecycleObserver(this.appLifecycleBloc);

  @override
  void didChangeAppLifecycleState(flutter.AppLifecycleState state) {
    appLifecycleBloc.handleAppLifecycleState(state);
  }

}