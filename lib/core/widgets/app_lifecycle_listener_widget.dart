import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/app_lifecycle/app_lifecycle_bloc.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/presentation/bloc/auth_bloc.dart';

class AppLifecycleListener extends StatelessWidget {
  const AppLifecycleListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppLifecycleBloc, AppLifecycleState>(
      listenWhen: (previous, current) => 
          previous.status != current.status,
      listener: (context, state) {
        if (state.isBackground) {
          // App went to background - pause timers, etc.
        } else if (state.isResumed) {
          // App resumed - refresh data, etc.
          context.read<AuthBloc>().add(const AuthEvent.checkStatusRequested());
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}