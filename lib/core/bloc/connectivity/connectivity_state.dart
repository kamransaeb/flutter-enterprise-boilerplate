part of 'connectivity_bloc.dart';

@freezed
abstract class ConnectivityState with _$ConnectivityState {
  const ConnectivityState._();

  // redirect to a private implementation class _Initial
  const factory ConnectivityState.initial() = _StateInitial;
  
  const factory ConnectivityState.loading() = _StateLoading;

  // DateTime is not a compule-time constant that is why you can not use const factory here
  factory ConnectivityState.connected({
    @Default(false) bool isWifi,
    @Default(false) bool isCellular,
    @Default(false) bool isVpn,
    String? connectionType,
    DateTime? lastConnectedAt,
    /// Set when coming back online after offline (for snackbar).
    Duration? offlineDuration,
  }) = _StateConnected;

// DateTime is not a compule-time constant that is why you can not use const factory here
  factory ConnectivityState.disconnected({
    DateTime? lastDisconnectedAt,
    Duration? offlineDuration,
  }) = _StateDisconnected;

  const factory ConnectivityState.connecting() = _StateConnecting;

  const factory ConnectivityState.slowConnection({
    @Default(false) bool isWifi,
    @Default(false) bool isCellular,
    @Default(false) bool isVpn,
    String? connectionType,
  }) = _StateSlowConnection;

  const factory ConnectivityState.failure(String errorMessage) = _StateFailure;

  bool get isConnected => maybeWhen(connected: (_, __, ___, ____,_____,______) => true, orElse: () => false);

  bool get isDisconnected => maybeWhen(disconnected: (_, __) => true, orElse: () => false);
  
  bool get isSlowConnection => maybeWhen(slowConnection: (_, __, ___, ____) => true, orElse: () => false);

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get isFailure => maybeWhen(failure: (errorMessage) => true, orElse: () => false);

  Duration? get offlineDuration => maybeWhen(
    connected: (_, __, ___, ____,_____, offlineDuration) => offlineDuration,
    disconnected: (_, offlineDuration) => offlineDuration,
    orElse: () => null,
  );

  String get displayStatus => when(
    initial: () => 'Initializing connection...',
    loading: () => 'Checking connection...',
    connected: (
      isWifi, isCellular, _, __, ___, ____,
    ) {
      if (isWifi) return 'Connected via Wi-Fi';
      if (isCellular) return 'Connected via cellular data';
      return 'Connected';
    },
    disconnected: (_, __) => 'No internet connection',
    connecting: () => 'Connecting...',
    slowConnection: (_, __, ___, ____) => 'Slow connection',
    failure: (errorMessage) => 'Error: $errorMessage',
  );
}