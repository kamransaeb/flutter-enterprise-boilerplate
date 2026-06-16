import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/core/errors/failures.dart';
import '../../../../lib/features/auth/domain/entities/user.dart';
import '../../../../lib/features/auth/domain/usecases/login_usecase.dart';
import '../../../../lib/features/auth/domain/usecases/logout_usecase.dart';
import '../../../../lib/features/auth/domain/usecases/register_usecase.dart';
import '../../../../lib/features/auth/presentation/bloc/auth_bloc.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}
class MockRegisterUseCase extends Mock implements RegisterUseCase {}
class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tName = 'Test User';
  final tUser = User.empty().copyWith(
    id: '1',
    email: tEmail,
    name: tName,
  );

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockRegisterUseCase = MockRegisterUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    authBloc = AuthBloc(
      mockLoginUseCase,
      mockRegisterUseCase,
      mockLogoutUseCase,
    );
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthState.initial()', () {
      expect(authBloc.state, equals(const AuthState.initial()));
    });

    blocTest<AuthBloc, AuthState>(
      'emits [loading, authenticated] when login is successful',
      build: () {
        when(() => mockLoginUseCase.execute(any()))
            .thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: tEmail,
        password: tPassword,
      )),
      expect: () => [
        const AuthState.loading(),
        AuthState.authenticated(tUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase.execute(
          LoginParams(email: tEmail, password: tPassword),
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when login fails',
      build: () {
        when(() => mockLoginUseCase.execute(any()))
            .thenAnswer((_) async => Left(ServerFailure('Login failed')));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: tEmail,
        password: tPassword,
      )),
      expect: () => [
        const AuthState.loading(),
        AuthState.failure(ServerFailure('Login failed')),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase.execute(
          LoginParams(email: tEmail, password: tPassword),
        )).called(1);
      },
    );
  });
}