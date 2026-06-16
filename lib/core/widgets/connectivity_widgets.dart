// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:rxdart/rxdart.dart';

// import 'package:flutter_enterprise_boilerplate/infrastructure/services/connectivity_service.dart';

// /// Builds different content based on current connectivity (online vs offline).
// class NetworkAwareWidget extends StatelessWidget {
//   final WidgetBuilder onlineBuilder;
//   final WidgetBuilder offlineBuilder;
//   final Duration debounceDuration;

//   const NetworkAwareWidget({
//     super.key,
//     required this.onlineBuilder,
//     required this.offlineBuilder,
//     this.debounceDuration = const Duration(milliseconds: 500),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<ConnectivityResult>(
//       stream: GetIt.instance<ConnectivityService>().onConnectivityChanged
//           .debounceTime(debounceDuration),
//       builder: (context, snapshot) {
//         final isOnline = snapshot.data != ConnectivityResult.none;

//         if (isOnline) {
//           return onlineBuilder(context);
//         } else {
//           return offlineBuilder(context);
//         }
//       },
//     );
//   }
// }

// /// Wraps [child] and invokes [onConnected]/[onDisconnected] when connectivity changes.
// /// Optionally shows snackbars when going offline or back online.
// class ConnectivityListener extends StatefulWidget {
//   final Widget child;
//   final VoidCallback? onConnected;
//   final VoidCallback? onDisconnected;
//   final bool showSnackbar;

//   const ConnectivityListener({
//     super.key,
//     required this.child,
//     this.onConnected,
//     this.onDisconnected,
//     this.showSnackbar = true,
//   });

//   @override
//   State<ConnectivityListener> createState() => _ConnectivityListenerState();
// }

// class _ConnectivityListenerState extends State<ConnectivityListener> {
//   bool _wasOffline = false;

//   @override
//   void initState() {
//     super.initState();
//     GetIt.instance<ConnectivityService>().onConnectivityChanged.listen(_handleConnectivityChange);
//   }

//   void _handleConnectivityChange(ConnectivityResult result) {
//     final isOnline = result != ConnectivityResult.none;

//     if (!isOnline) {
//       _wasOffline = true;
//       widget.onDisconnected?.call();

//       if (widget.showSnackbar && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('No internet connection'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } else if (_wasOffline) {
//       _wasOffline = false;
//       widget.onConnected?.call();

//       if (widget.showSnackbar && mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Back online'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
