part of 'app_lifecycle_bloc.dart';


@freezed
abstract class AppLifecycleState with _$AppLifecycleState {

  const AppLifecycleState._();

  const factory AppLifecycleState.initial({
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StateInitial;

  factory AppLifecycleState.resumed({
    required DateTime lastResumedAt,
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StateResumed;

  factory AppLifecycleState.inactive({
    DateTime? lastResumedAt,
    DateTime? lastPausedAt,
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StateInactive;

  factory AppLifecycleState.paused({
    required DateTime lastPausedAt,
    DateTime? lastResumedAt,
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StatePaused;
  
  const factory AppLifecycleState.detached({
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StateDetached;

  factory AppLifecycleState.background({
    DateTime? lastPausedAt,
    @Default(Duration.zero) Duration totalForegroundTime,
    @Default(Duration.zero) Duration totalBackgroundTime,
    @Default(0) int sessionCount,
  }) = _StateBackground;

  Duration get totalForegroundTime => when(
    initial: (fg, _, __) => fg,
    resumed: (_, fg, __, ___) => fg,
    inactive: (_, __, fg, ___, ____) => fg,
    paused: (_, __, fg, ___, ____) => fg,
    detached: (fg, _, __) => fg,
    background: (_, fg, __, ___) => fg,
  );

  Duration get totalBackgroundTime => when(
    initial: (_, bg, __) => bg,
    resumed: (_, _, bg, ___) => bg,
    inactive: (_, __, ___, bg, ____) => bg,
    paused: (_, __, ___, bg, ____) => bg,
    detached: (_, bg, __) => bg,
    background: (_, __, bg, ___) => bg,
  );

  int get sessionCount => when(
    initial: (_, __, sc) => sc,
    resumed: (_, __, ___, sc) => sc,
    inactive: (_, __, ___, ____, sc) => sc,
    paused: (_, __, ___, ____, sc) => sc,
    detached: (_, __, sc) => sc,
    background: (_, __, ___, sc) => sc,
  );

  DateTime? get lastResumedAt => maybeWhen(
    resumed: (at, _, __,___) => at,
    inactive: (at, _, __,___,____) => at,
    paused: (_, at, __, ___, ____) => at,
    orElse: () => null,
  );

  DateTime? get lastPausedAt => maybeWhen(
    paused: (at, _, __, ___, ____) => at,
    inactive: (_, at, __, ___, ____) => at,
    background: (at, _, __, ___) => at,
    orElse: () => null,
  );

  bool get isResumed => 
      maybeWhen(resumed: (_, __, ___, ____) => true, orElse: () => false);
  bool get isInactive => 
      maybeWhen(inactive: (_, __, ___, ____, _____) => true, orElse: () => false);
  bool get isPaused =>
      maybeWhen(paused: (_, __, ___, ____, _____) => true, orElse: () => false);
  bool get isDetached => 
      maybeWhen(detached: (_, __, ___) => true, orElse: () => false);    
  bool get isBackground =>
      maybeWhen(background: (_, __, ___, ____) => true, orElse: () => false);
  bool get isForeground => isResumed;
      
}