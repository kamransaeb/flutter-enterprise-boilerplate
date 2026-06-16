part of 'app_lifecycle_bloc.dart';

@freezed
abstract class AppLifecycleEvent with _$AppLifecycleEvent {
  const AppLifecycleEvent._();

  const factory AppLifecycleEvent.changed(
    flutter.AppLifecycleState? state,
  ) = _EventChanged;

  const factory AppLifecycleEvent.resumed() = _EventResumed;

  const factory AppLifecycleEvent.paused() = _EventPaused;

  const factory AppLifecycleEvent.inactive() = _EventInactive;

  const factory AppLifecycleEvent.detached() = _EventDetached;

  const factory AppLifecycleEvent.backgroundEntered() = _EventBackgroundEntered;

  const factory AppLifecycleEvent.foregroundEntered() = _EventForegroundEntered;

  const factory AppLifecycleEvent.sessionStarted() = _EventSessionStarted;

  const factory AppLifecycleEvent.sessionEnded(Duration sessionDuration) = _EventSessionEnded;
}
