part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const AuthState._();

  // Initial state
  const factory AuthState.initial() = _StateInitial;

  const factory AuthState.checkingAuth() = _StateCheckingAuth;

  // Loading states
  const factory AuthState.loading() = _StateLoading;

  // Authenticated state
  const factory AuthState.authenticated({required User user}) = _StateAuthenticated;
      
  // Unauthenticated states
  const factory AuthState.unauthenticated({
    @Default(false) bool isFirstLaunch,
    @Default(false) bool requiresOnboarding,
  }) = _StateUnauthenticated;

  const factory AuthState.failure({
    required Failure failure,
  }) = _StateFailure;

  // Helper getters
  User? get user => maybeWhen(
    authenticated: (user) => user,
    orElse: () => null,
  );

  bool get isInitial => maybeWhen(
    initial: () => true,
    orElse: () => false,
  );

  bool get isCheckingAuth => maybeWhen(
    checkingAuth: () => true, orElse: () => false
  );

  bool get isLoading => maybeWhen(
    loading: () => true,
    checkingAuth: () => true,
    orElse: () => false,
  );

  bool get isAuthenticated => maybeWhen(
    authenticated: (_) => true,
    orElse: () => false,
  );

  bool get isUnauthenticated => maybeWhen(
    unauthenticated: (_, __) => true,
    orElse: () => false,
  );

  Failure? get failure => maybeWhen(
    failure: (f) => f,
    orElse: () => null,
  );

  String? get errorMessage => maybeWhen(
    failure: (f) => f.message,
    orElse: () => null,
  );

  bool get isFirstLaunch => maybeWhen(
    unauthenticated: (isFirstLaunch, _) => isFirstLaunch,
    orElse: () => false,
  );

  bool get requiresOnboarding => maybeWhen(
    unauthenticated: (_, requiresOnboarding) => requiresOnboarding,
    orElse: () => false,
  );

  bool get shouldShowOnboarding => requiresOnboarding && isUnauthenticated;

  
  
}