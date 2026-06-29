import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/connectivity_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';

// 1. Point to your child files
part 'connectivity_event.dart';
part 'connectivity_state.dart';

// 2. Point to the SINGLE generated file
part 'connectivity_bloc.freezed.dart';

@singleton
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final LoggerService _logger;

  ConnectivityBloc({
    required ConnectivityService connectivityService,
    required LoggerService logger,
  })  : _connectivityService = connectivityService,
        _logger = logger,
      super(const ConnectivityState.initial()) {
    on<_EventLoaded>(_onEventLoaded);
    on<_EventLost>(_onEventLost);
    on<_EventChanged>(_onEventChanged);
    add(const ConnectivityEvent.loaded());
  }

  final ConnectivityService _connectivityService;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  Timer? _reconnectTimer;
  DateTime? _disconnectedAt;
  static const int _reconnectCheckInterval = 5; // seconds

  Future<void> _onEventLoaded(
    _EventLoaded event,
    Emitter<ConnectivityState> emit,
  ) async {
    _logger.i('ConnectivityBloc: Loading connectivity...');
    try {
      InternetQuality internetQuality =
          await _connectivityService.checkInternetQuality;

      switch (internetQuality) {
        case InternetQuality.connected:
          emit(ConnectivityState.connected(lastConnectedAt: DateTime.now()));
        case InternetQuality.disconnected:
          emit(
            ConnectivityState.disconnected(lastDisconnectedAt: DateTime.now()),
          );
        case InternetQuality.slowConnection:
          emit(ConnectivityState.slowConnection());
      }

      _connectivitySubscription = _connectivityService.onConnectivityChanged
          .listen((result) {
            _logger.d('[onConnectivityChanged] Connectivity changed: $result');
            //_handleConnectivityChange(result, emit);
            add(
              ConnectivityEvent.changed(
                isConnected: result != ConnectivityResult.none,
                connectionType: result.name,
                isCellular: result == ConnectivityResult.mobile,
                isWifi: result == ConnectivityResult.wifi,
                isVpn: result == ConnectivityResult.vpn,
              ),
            );
          });
    } catch (e) {
      emit(ConnectivityState.failure(e.toString()));
    }
  }

  Future<void> _onEventChanged(
    _EventChanged event,
    Emitter<ConnectivityState> emit,
  ) async {
    _logger.d('[_onConnectivityChanged] Connectivity changed: ${event.connectionType ?? 'Unknown'}');
    if (!event.isConnected) {
      add(const ConnectivityEvent.lost());
      return;
    }

    final quality = await _connectivityService.checkInternetQuality;
      switch (quality) {
        case InternetQuality.connected:
        final offlineDuration = _disconnectedAt != null ? DateTime.now().difference(_disconnectedAt!) : null;
        _disconnectedAt = null;
          emit(ConnectivityState.connected(        
            isWifi: event.isWifi,
            isCellular: event.isCellular,
            isVpn: event.isVpn,
            connectionType: event.connectionType,
            lastConnectedAt: DateTime.now(),
            offlineDuration: offlineDuration,
          ));
        case InternetQuality.disconnected:
          emit(ConnectivityState.disconnected(lastDisconnectedAt: DateTime.now()));
        case InternetQuality.slowConnection:
          emit(ConnectivityState.slowConnection(
            isWifi: event.isWifi,
            isCellular: event.isCellular,
            isVpn: event.isVpn,
            connectionType: event.connectionType,
          ));
      }
   
  }

  // Future<void> _handleConnectivityChange(
  //   ConnectivityResult result,
  //   Emitter<ConnectivityState> emit,
  // ) async {
  //   final isConnected = result != ConnectivityResult.none;
  //   if (isConnected) {
  //     final isWifi = result == ConnectivityResult.wifi;
  //     final isMobile = result == ConnectivityResult.mobile;
  //     final isEthernet = result == ConnectivityResult.ethernet;
  //     final isBluetooth = result == ConnectivityResult.bluetooth;
  //     final isVpn = result == ConnectivityResult.vpn;
  //     final isOther = result == ConnectivityResult.other;
  //     final isSatellite = result == ConnectivityResult.satellite;
  //     final isNone = result == ConnectivityResult.none;
  //     final internetQuality = await _connectivityService.checkInternetQuality;

  //     ConnectivityStatus status;
  //     switch (internetQuality) {
  //       case InternetQuality.connected:
  //         status = ConnectivityStatus.connected;
  //       case InternetQuality.disconnected:
  //         status = ConnectivityStatus.disconnected;
  //       case InternetQuality.slowConnection:
  //         status = ConnectivityStatus.slowConnection;
  //     }

  //     emit(
  //       state.copyWith(
  //         isConnected: isConnected,
  //         isWifi: isWifi,
  //         isMobile: isMobile,
  //         isEthernet: isEthernet,
  //         isBluetooth: isBluetooth,
  //         isVpn: isVpn,
  //         isOther: isOther,
  //         status: status,
  //         lastConnectedAt: DateTime.now(),
  //       ),
  //     );
  //   } else {
  //     if (state.isConnected) {
  //       add(const ConnectivityEvent.lost());
  //     }
  //   }
  // }

  Future<void> _onEventLost(
    _EventLost event,
    Emitter<ConnectivityState> emit,
  ) async {
    if (state.isConnected) {
      _logger.i('ConnectivityBloc: Connection lost');
      _disconnectedAt = DateTime.now();
      emit(
        ConnectivityState.disconnected(lastDisconnectedAt: _disconnectedAt),
      );
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}
