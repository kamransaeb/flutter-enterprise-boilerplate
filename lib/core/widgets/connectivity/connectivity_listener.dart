import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/core/bloc/connectivity/connectivity_bloc.dart';

class ConnectivityListener extends StatelessWidget {
  const ConnectivityListener({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocListener<ConnectivityBloc, ConnectivityState>(
  //     listenWhen: (previous, current) {
  //       return previous.isConnected != current.isConnected ||
  //           previous.isSlowConnection != current.isSlowConnection;
  //     },
  //     listener: (context, state) {
  //       if (state.isDisconnected) {
  //         _showNoConnectionSnackBar(context);
  //       } else if (state.isSlowConnection) {
  //         _showSlowConnectionSnackBar(context);
  //       } else if (state.isConnected && !state.isSlowConnection) {
  //         if (state.offlineDuration != null && state.offlineDuration! > Duration.zero) {
  //           _showConnectionRestoredSnackBar(context, state.offlineDuration!);
  //         }
  //       }
  //     },
  //     child: const SizedBox.shrink(),
  //   );
  // }

  @override 
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(

      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const CircularProgressIndicator(),

          connected: (isWifi, isCellular, isVpn, connectionType, lastConnectedAt, offlineDuration) {
           return Text(state.displayStatus, style: const TextStyle(color: Colors.green));
            //return const SizedBox.shrink();
          },

          disconnected: (_, __) {
            return const Text('Offline', style: TextStyle(color: Colors.red));
            //return const SizedBox.shrink();
          },
          connecting: () => const Text('Connecting...', style: TextStyle(color: Colors.blue)),
          slowConnection: (_, __, ___, ____) => const Text('Slow connection...', style: TextStyle(color: Colors.orange)),
          failure: (errorMessage) => Text('Error: $errorMessage', style: const TextStyle(color: Colors.red)),

        );
      }
    );
  }

  void _showNoConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.wifi_off, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('No internet connection')),
          ],
        ),
        backgroundColor: Colors.red,
        duration: const Duration(days: 1),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showSlowConnectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.speed, color: Colors.white),
            SizedBox(width: 12),
            Expanded(child: Text('Slow connection detected')),
          ],
        ),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showConnectionRestoredSnackBar(BuildContext context, Duration offlineDuration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.wifi, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text('Connection restored (was offline for ${offlineDuration.inSeconds}s)'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}