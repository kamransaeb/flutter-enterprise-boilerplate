import 'dart:async';
import 'package:bloc/bloc.dart';
import 'dart:ui' as flutter;

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_enterprise_boilerplate/core/services/logger_service.dart';
import 'package:injectable/injectable.dart';

part 'app_lifecycle_event.dart';
part 'app_lifecycle_state.dart';
part 'app_lifecycle_bloc.freezed.dart';

@singleton
class AppLifecycleBloc extends Bloc<AppLifecycleEvent, AppLifecycleState> {
  final LoggerService _logger;

  Timer? _foregroundTimer;
  Timer? _backgroundTimer;
  DateTime? _currentSessionStart;
  bool _isInBackground = false;

  AppLifecycleBloc(this._logger) : super(AppLifecycleState.initial()) {
    on<_EventChanged>(_onEventChanged);
    on<_EventResumed>(_onEventResumed);
    on<_EventPaused>(_onEventPaused);
    on<_EventInactive>(_onEventInactive);
    on<_EventDetached>(_onEventDetached);
    on<_EventBackgroundEntered>(_onEventBackgroundEntered);
    on<_EventForegroundEntered>(_onEventForegroundEntered);
    on<_EventSessionStarted>(_onEventSessionStarted);
    on<_EventSessionEnded>(_onEventSessionEnded);
  }

  void handleAppLifecycleState(flutter.AppLifecycleState? state) {
    add(AppLifecycleEvent.changed(state));
  }

  Future<void> _onEventChanged(
    _EventChanged event,
    Emitter<AppLifecycleState> emit,
  ) async {
    final newState = event.state;
    
    if (newState == null) return;

    _logger.d('AppLifecycle changed to: ${newState.toString()}');

    switch (newState) {
      case flutter.AppLifecycleState.resumed:
        add(AppLifecycleEvent.resumed());
        break;
      case flutter.AppLifecycleState.inactive:
        add(AppLifecycleEvent.inactive());
        break;
      case flutter.AppLifecycleState.paused:
        add(AppLifecycleEvent.paused());
        break;
      case flutter.AppLifecycleState.detached:
        add(AppLifecycleEvent.detached());
        break;
      default:
        break;
    }
  }

  Future<void> _onEventResumed(
    _EventResumed event,
    Emitter<AppLifecycleState> emit,
  ) async {
    final now = DateTime.now();
    
    if (_isInBackground) {
      add(AppLifecycleEvent.foregroundEntered());
    }
    
    if (_currentSessionStart == null) {
      add(AppLifecycleEvent.sessionStarted());
    }

    emit(AppLifecycleState.resumed(lastResumedAt: now),);
    _startForegroundTracking();
    _logger.i('App resumed at $now');
  }

  Future<void> _onEventPaused(
    _EventPaused event,
    Emitter<AppLifecycleState> emit,
  ) async {
    final now = DateTime.now();
    emit(AppLifecycleState.paused(lastPausedAt: now),);
    _stopForegroundTracking();
    _logger.i('App paused at $now');
  }

  Future<void> _onEventInactive(
    _EventInactive event,
    Emitter<AppLifecycleState> emit,
  ) async {
    emit(AppLifecycleState.inactive(),);
    _logger.d('App became inactive');
  }

  Future<void> _onEventDetached(
    _EventDetached event,
    Emitter<AppLifecycleState> emit,
  ) async {
    emit(const AppLifecycleState.detached(),);
    _logger.d('App detached');
    
    if (_currentSessionStart != null) {
      final sessionDuration = DateTime.now().difference(_currentSessionStart!);
      add(AppLifecycleEvent.sessionEnded(sessionDuration));
    }
  }

  Future<void> _onEventBackgroundEntered(
    _EventBackgroundEntered event,
    Emitter<AppLifecycleState> emit,
  ) async {
    if (!_isInBackground) {
      _isInBackground = true;
      emit(AppLifecycleState.background(),);
      _startBackgroundTracking();
      _logger.i('App entered background');
    }
  }

  Future<void> _onEventForegroundEntered(
    _EventForegroundEntered event,
    Emitter<AppLifecycleState> emit,
  ) async {
    if (_isInBackground) {
      _isInBackground = false;
      _stopBackgroundTracking();
      _logger.i('App entered foreground');
    }
  }

  Future<void> _onEventSessionStarted(
    _EventSessionStarted event,
    Emitter<AppLifecycleState> emit,
  ) async {
    _currentSessionStart = DateTime.now();
    final newSessionCount = state.sessionCount + 1;
    
    emit(state.copyWith(
      sessionCount: newSessionCount,
    ));
    
    _logger.i('Session started - Session #$newSessionCount');
  }

  Future<void> _onEventSessionEnded(
    _EventSessionEnded event,
    Emitter<AppLifecycleState> emit,
  ) async {
    if (_currentSessionStart != null) {
      _logger.i('Session ended - Duration: ${event.sessionDuration}');
      _currentSessionStart = null;
    }
  }

  void _startForegroundTracking() {
    _foregroundTimer?.cancel();
    _foregroundTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateForegroundTime(),
    );
  }

  void _stopForegroundTracking() {
    _foregroundTimer?.cancel();
    _foregroundTimer = null;
  }

  void _updateForegroundTime() {
    // Update total foreground time every second when app is in foreground
    final newTotalForeground = state.totalForegroundTime + const Duration(seconds: 1);
    emit(state.copyWith(totalForegroundTime: newTotalForeground));
  }

  void _startBackgroundTracking() {
    _backgroundTimer?.cancel();
    _backgroundTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _updateBackgroundTime(),
    );
  }

  void _stopBackgroundTracking() {
    _backgroundTimer?.cancel();
    _backgroundTimer = null;
  }

  void _updateBackgroundTime() {
    final newTotalBackground = state.totalBackgroundTime + const Duration(seconds: 1);
    emit(state.copyWith(totalBackgroundTime: newTotalBackground));
  }

  @override
  Future<void> close() {
    _foregroundTimer?.cancel();
    _backgroundTimer?.cancel();
    return super.close();
  }
}