part of 'connectivity_bloc.dart';

@freezed
abstract class ConnectivityEvent with _$ConnectivityEvent {
  
  const ConnectivityEvent._();

  const factory ConnectivityEvent.loaded() = _EventLoaded;

  const factory ConnectivityEvent.changed({
    required bool isConnected,
    String? connectionType,
    @Default(false) bool isCellular,
    @Default(false) bool isWifi,
    @Default(false) bool isVpn,
    @Default(false) bool isRoaming,
  }) = _EventChanged;

  const factory ConnectivityEvent.lost() = _EventLost;

  const factory ConnectivityEvent.restored({
    required Duration offlineDuration
  }) = _EventRestored;

  // const factory ConnectivityEvent.checkRequested() = ConnectivityCheckRequested;

  // const factory ConnectivityEvent.slowDetected({
  //   required Duration responseTime,
  // }) = ConnectivitySlowDetected;
  
}