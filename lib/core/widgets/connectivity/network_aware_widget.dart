import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/connectivity_service.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

class NetworkAwareWidget extends StatelessWidget {
  final WidgetBuilder onlineBuilder;
  final WidgetBuilder offlineBuilder;
  final Duration debounceDuration;

  const NetworkAwareWidget({
    super.key,
    required this.onlineBuilder,
    required this.offlineBuilder,
    this.debounceDuration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ConnectivityResult>(
      stream: GetIt.instance<ConnectivityService>().onConnectivityChanged
          .debounceTime(debounceDuration),
      builder: (context, snapshot) {
        final isOnline = snapshot.data != ConnectivityResult.none;

        if (isOnline) {
          return onlineBuilder(context);
        } else {
          return offlineBuilder(context);
        }
      },
    );
  }
}