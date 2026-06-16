import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/forgot_password_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class ForgotPasswordUseCase extends BaseUseCase<void, ForgotPasswordParams> {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  FutureOr<Either<Failure, void>> call(ForgotPasswordParams params) async {
    if (params.email.trim().isEmpty) {
      return Left(ValidationFailure(message: 'Email is required'));
    }

    return _repository.forgotPassword(params.email.trim());
  }
}

