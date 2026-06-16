import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/failures.dart';
import 'package:flutter_enterprise_boilerplate/core/usecase/base_usecase.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/usecases/logout_usecase.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/login_params.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/register_params.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/logger_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final RegisterUseCase _registerUseCase;
  final AuthRepository _authRepository;
  //final AnalyticsService? _analyticsService;
  //final AppLogger _logger;

  Timer? _tokenRefreshTimer;
  static const _tokenRefreshInterval = Duration(minutes: 45);

  AuthBloc({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required RegisterUseCase registerUseCase,
    required AuthRepository authRepository,
    //  AnalyticsService? analyticsService,
  }) : _loginUseCase = loginUseCase,
       _logoutUseCase = logoutUseCase,
       _registerUseCase = registerUseCase,
       _authRepository = authRepository,
       //   _analyticsService = analyticsService,
       //   _logger = GetIt.instance<AppLogger>(),
       super(AuthState.initial()) {
    on<_EventAppStarted>(_onEventAppStarted);
    on<_EventLoginRequested>(_onEventLoginRequested);
    on<_EventRegisterRequested>(_onEventRegisterRequested);
    on<_EventLogoutRequested>(_onEventLogoutRequested);
    on<_EventCheckStatusRequested>(_onEventCheckStatusRequested);
    on<_EventRefreshTokenRequested>(_onEventRefreshTokenRequested);
    on<_EventUpdateUserRequested>(_onEventUpdateUserRequested);
    // on<AuthGoogleLoginRequested>(_onGoogleLoginRequested);
    // on<AuthAppleLoginRequested>(_onAppleLoginRequested);
    // on<AuthFacebookLoginRequested>(_onFacebookLoginRequested);
    on<_EventForgotPasswordRequested>(_onEventForgotPasswordRequested);
    on<_EventResetPasswordRequested>(_onEventResetPasswordRequested);
    on<_EventVerifyEmailRequested>(_onEventVerifyEmailRequested);
    on<_EventResendVerificationEmailRequested>(_onEventResendVerificationEmailRequested);
    // on<AuthOnboardingCompleted>(_onOnboardingCompleted);
    // on<AuthFirstLaunchDetected>(_onFirstLaunchDetected);

    add(const AuthEvent.checkStatusRequested());
  }

  // MARK: - Event Handlers

  Future<void> _onEventAppStarted(
    _EventAppStarted event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: App started - checking authentication status');
    emit(AuthState.checkingAuth());

    try {
      // final hasSeenOnboarding = await _checkOnboardingStatus();
      // final isFirstLaunch = await _checkFirstLaunch();

      // if (!hasSeenOnboarding) {
      //   emit(AuthState.firstLaunch());
      //   return;
      // }

      final isAuthenticated = await _authRepository.isAuthenticated();

      if (isAuthenticated) {
        final result = await _authRepository.getCurrentUser();
        result.fold(
          (failure) async {
            logger.e(
              'AuthBloc: Error getting current user - ${failure.message}',
            );
            emit(AuthState.failure(failure: failure));
          },
          (user) async {
            if (user != null) {
              emit(AuthState.authenticated(user: user));
              _startTokenRefreshTimer();
              logger.i('AuthBloc: User authenticated - ${user.email}');
            } else {
              emit(AuthState.unauthenticated());
              logger.w('AuthBloc: User not found but authenticated flag true');
            }
          },
        );
      } else {
        emit(AuthState.unauthenticated());
        logger.i('AuthBloc: User not authenticated');
      }
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Error checking auth status',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

  Future<void> _onEventLoginRequested(
    _EventLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Login requested for ${event.email}');
    emit(AuthState.loading());

    try {
      final params = LoginParams(email: event.email, password: event.password);

      final result = await _loginUseCase(params);

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Login failed - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (user) async {
          emit(AuthState.authenticated(user: user));
          _startTokenRefreshTimer();
          logger.i('AuthBloc: Login successful - ${user.email}');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error during login',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

  Future<void> _onEventRegisterRequested(
    _EventRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Registration requested for ${event.email}');
    emit(AuthState.loading());

    try {
      final params = RegisterParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      final result = await _registerUseCase(params);

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Registration failed - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (user) async {
          emit(AuthState.authenticated(user: user));
          logger.i('AuthBloc: Registration successful - ${user.email}');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error during registration',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

  Future<void> _onEventLogoutRequested(
    _EventLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Logout requested');
    emit(AuthState.loading());

    try {
      final result = await _logoutUseCase(const NoParams());

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Logout failed - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (_) async {
          _cancelTokenRefreshTimer();
          emit(AuthState.unauthenticated());
          logger.i('AuthBloc: Logout successful');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error during logout',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

  Future<void> _onEventCheckStatusRequested(
    _EventCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.d('AuthBloc: Manual status check requested');

    final isAuthenticated = await _authRepository.isAuthenticated();

    if (isAuthenticated && state.user != null) {
      emit(AuthState.authenticated(user: state.user!));
      logger.d('AuthBloc: User is authenticated');
    } else if (isAuthenticated) {
      final result = await _authRepository.getCurrentUser();

      result.fold(
        (failure) async {
          logger.e('AuthBloc: Error getting current user - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (user) async {
          if (user != null) {
            emit(AuthState.authenticated(user: user));
            logger.d('AuthBloc: User loaded from repository');
          } else {
            emit(AuthState.unauthenticated());
            logger.w('AuthBloc: Auth flag true but no user found');
          }
        },
      );
    } else {
      emit(AuthState.unauthenticated());
      logger.d('AuthBloc: User is not authenticated');
    }
  }

  Future<void> _onEventRefreshTokenRequested(
    _EventRefreshTokenRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.d('AuthBloc: Token refresh requested');

    try {
      final refreshTokenResult = await _authRepository.refreshToken();

      
      refreshTokenResult.fold(
        (failure) async {
          logger.e('AuthBloc: Token refresh failed - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (refreshToken) async {
          if (state.user != null) {
            final refreshedUser = await _authRepository.getCurrentUser();
            refreshedUser.fold(
              (failure) async {
                logger.e(
                  'AuthBloc: Error getting current user - ${failure.message}',
                );
                emit(AuthState.failure(failure: failure));
              },
              (user) async {
                if (user != null) {
                  emit(AuthState.authenticated(user: user));
                  logger.d('AuthBloc: User loaded from repository');
                } else {
                  logger.e('AuthBloc: Refresh Token found but no user found');
                  add(AuthEvent.logoutRequested());
                }
              },
            );
          } else {
            logger.e('AuthBloc: Auth flag true but no user found');
            add(AuthEvent.logoutRequested());
          }
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Error refreshing token',
        error: error,
        stackTrace: stackTrace,
      );
      
    }
  }

  Future<void> _onEventUpdateUserRequested(
      _EventUpdateUserRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.d('AuthBloc: User update requested');

    if (state.isAuthenticated) {
      emit(AuthState.authenticated(user: event.user));
      logger.d('AuthBloc: User updated in state - ${event.user.email}');
    }
  }

  // Future<void> _onGoogleLoginRequested(
  //   AuthGoogleLoginRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   logger.i('AuthBloc: Google login requested');
  //   emit(AuthState.loading());

  //   try {
  //     final result = await _authRepository.signInWithGoogle();

  //     await result.fold(
  //       (failure) async {
  //         logger.e('AuthBloc: Google login failed - ${failure.message}');
  //         emit(AuthState.error(failure.message ?? 'Google login failed'));
  //       },
  //       (user) async {
  //         emit(AuthState.authenticated(user));
  //         logger.i('AuthBloc: Google login successful - ${user.email}');
  //       },
  //     );
  //   } catch (error, stackTrace) {
  //     logger.e(
  //       'AuthBloc: Unexpected error during Google login',
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //     emit(AuthState.error('An unexpected error occurred'));
  //   }
  // }

  // Future<void> _onAppleLoginRequested(
  //   AuthAppleLoginRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthState.loading());

  //   try {
  //     final result = await _authRepository.signInWithApple();

  //     await result.fold(
  //       (failure) async {
  //         logger.e('AuthBloc: Apple login failed - ${failure.message}');
  //         emit(AuthState.error(failure.message ?? 'Apple login failed'));
  //       },
  //       (user) async {
  //         emit(AuthState.authenticated(user));
  //         logger.i('AuthBloc: Apple login successful - ${user.email}');
  //       },
  //     );
  //   } catch (error, stackTrace) {
  //     logger.e(
  //       'AuthBloc: Unexpected error during Apple login',
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //     emit(AuthState.error('An unexpected error occurred'));
  //   }
  // }

  // Future<void> _onFacebookLoginRequested(
  //   AuthFacebookLoginRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   logger.i('AuthBloc: Facebook login requested');
  //   emit(AuthState.loading());

  //   try {
  //     final result = await _authRepository.signInWithFacebook();

  //     await result.fold(
  //       (failure) async {
  //         logger.e('AuthBloc: Facebook login failed - ${failure.message}');
  //         emit(AuthState.error(failure.message ?? 'Facebook login failed'));
  //       },
  //       (user) async {
  //         emit(AuthState.authenticated(user));
  //         logger.i('AuthBloc: Facebook login successful - ${user.email}');
  //       },
  //     );
  //   } catch (error, stackTrace) {
  //     logger.e(
  //       'AuthBloc: Unexpected error during Facebook login',
  //       error: error,
  //       stackTrace: stackTrace,
  //     );
  //     emit(AuthState.error('An unexpected error occurred'));
  //   }
  // }

  Future<void> _onEventForgotPasswordRequested(
    _EventForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Forgot password requested for ${event.email}');

    try {
      final result = await _authRepository.forgotPassword(event.email);

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Forgot password failed - ${failure.message}');
          // Don't emit error state to UI to avoid leaking email existence
        },
        (_) async {
          logger.i('AuthBloc: Password reset email sent');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error during password reset',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

  Future<void> _onEventResetPasswordRequested(
    _EventResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Reset password requested');

    try {
      final result = await _authRepository.resetPassword(
        token: event.token,
        newPassword: event.newPassword,
      );
      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Reset password failed - ${failure.message}');
          emit(AuthState.failure(failure: failure));
        },
        (_) async {
          logger.i('AuthBloc: Password reset successful');
          emit(AuthState.unauthenticated());
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error during password reset',
        error: error,
        stackTrace: stackTrace,
      );
      emit(AuthState.failure(failure: ErrorHandler.handleError(error, stackTrace: stackTrace)));
    }
  }

// This is the initial action. It is typically called immediately after a user 
// signs up for the first time.
// When to use: Use this during the "Create Account" flow.
// Mechanism: It generates a unique verification link and sends it to the
// email address associated with the currently signed-in user object.
  Future<void> _onEventVerifyEmailRequested(
    _EventVerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Verify email requested');

    try {
      final result = await _authRepository.verifyEmail(event.email, event.token);

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Send verification failed - ${failure.message}');
        },
        (_) async {
          logger.i('AuthBloc: Verification email sent');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error sending verification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

// This is the follow-up action. It is used when a user has already signed up
// but hasn't verified their account yet—perhaps because the first email
// expired, was deleted, or landed in a spam folder.
// When to use: Use this on a "Verify Your Email" screen or a "Login" screen 
// if a user tries to access the app but their emailVerified flag is still false.
// Mechanism: It invalidates the previous link (in most implementations) 
// and issues a fresh one.
  Future<void> _onEventResendVerificationEmailRequested(
    _EventResendVerificationEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    logger.i('AuthBloc: Resend verification requested for ${event.email}');

    try {
      final result = await _authRepository.resendVerificationEmail(event.email);

      await result.fold(
        (failure) async {
          logger.e('AuthBloc: Resend verification failed - ${failure.message}');
        },
        (_) async {
          logger.i('AuthBloc: Verification email resent');
        },
      );
    } catch (error, stackTrace) {
      logger.e(
        'AuthBloc: Unexpected error resending verification',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  // Future<void> _onOnboardingCompleted(
  //   AuthOnboardingCompleted event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   logger.i('AuthBloc: Onboarding completed');
  //   await _markOnboardingCompleted();
  //   emit(AuthState.unauthenticated());
  // }

  // Future<void> _onFirstLaunchDetected(
  //   AuthFirstLaunchDetected event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   logger.i('AuthBloc: First launch detected');
  //   emit(AuthState.firstLaunch());
  // }

  // MARK: - Private Helper Methods

  // Future<bool> _checkFirstLaunch() async {
  //   try {
  //     return await _authRepository.isFirstLaunch();
  //   } catch (error) {
  //     logger.e('Error checking first launch', error: error);
  //     return false;
  //   }
  // }

  // Future<bool> _checkOnboardingStatus() async {
  //   try {
  //     return await _authRepository.hasSeenOnboarding();
  //   } catch (error) {
  //     logger.e('Error checking onboarding status', error: error);
  //     return false;
  //   }
  // }

  // Future<void> _markOnboardingCompleted() async {
  //   try {
  //     await _authRepository.markOnboardingCompleted();
  //   } catch (error) {
  //     logger.e('Error marking onboarding completed', error: error);
  //   }
  // }

  void _startTokenRefreshTimer() {
    _cancelTokenRefreshTimer();
    _tokenRefreshTimer = Timer.periodic(
      _tokenRefreshInterval,
      (_) => add(AuthEvent.refreshTokenRequested()),
    );
  }

  void _cancelTokenRefreshTimer() {
    _tokenRefreshTimer?.cancel();
    _tokenRefreshTimer = null;
  }

  @override
  Future<void> close() {
    _cancelTokenRefreshTimer();
    return super.close();
  }
}
