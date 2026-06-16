import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/register_params.dart';
import 'dart:async';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

@injectable
class RegisterUseCase extends BaseUseCase<User, RegisterParams> {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  @override
  FutureOr<Either<Failure, User>> call(RegisterParams params) async {
    return await _repository.register(
      email: params.email,
      password: params.password,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

