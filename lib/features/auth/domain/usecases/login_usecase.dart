import 'package:dartz/dartz.dart';
import 'dart:async';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/entities/user.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/login_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class LoginUseCase extends BaseUseCase<User, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  FutureOr<Either<Failure, User>> call(LoginParams params) async {
    // Validate inputs
    if (params.email.isEmpty || params.password.isEmpty) {
      return Left(ValidationFailure(message: 'Email and password are required'));
    }

    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

