import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/core/errors/failures.dart';
import '../../../../lib/features/auth/data/datasources/auth_local_data_source.dart';
import '../../../../lib/features/auth/data/datasources/auth_remote_data_source.dart';
import '../../../../lib/features/auth/data/models/user_model.dart';
import '../../../../lib/features/auth/data/repositories/auth_repository_impl.dart';
import '../../../../lib/features/auth/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}
class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockAuthLocalDataSource();
    repository = AuthRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group('login', () {
    const tEmail = 'test@example.com';
    const tPassword = 'password123';
    final tUserModel = UserModel(
      id: '1',
      email: tEmail,
      name: 'Test User',
    );
    final tUser = tUserModel.toEntity();

    test('should return User when login is successful', () async {
      // Arrange
      when(() => mockRemoteDataSource.login(any()))
          .thenAnswer((_) async => tUserModel);
      when(() => mockLocalDataSource.saveUser(any()))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, equals(Right(tUser)));
      verify(() => mockRemoteDataSource.login({
        'email': tEmail,
        'password': tPassword,
      })).called(1);
      verify(() => mockLocalDataSource.saveUser(tUser)).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return ServerFailure when login fails', () async {
      // Arrange
      when(() => mockRemoteDataSource.login(any()))
          .thenThrow(Exception());

      // Act
      final result = await repository.login(
        email: tEmail,
        password: tPassword,
      );

      // Assert
      expect(result, isA<Left<Failure, User>>());
      verify(() => mockRemoteDataSource.login({
        'email': tEmail,
        'password': tPassword,
      })).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
    });
  });
}