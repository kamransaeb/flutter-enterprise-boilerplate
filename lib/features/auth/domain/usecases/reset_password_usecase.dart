import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/reset_password_params.dart';

@injectable
class ResetPasswordUseCase extends BaseUseCase<void, ResetPasswordParams> {
  final AuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  FutureOr<Either<Failure, void>> call(ResetPasswordParams params) async {
    if (params.token.trim().isEmpty || params.newPassword.trim().isEmpty) {
      return Left(
        ValidationFailure(message: 'Token and new password are required'),
      );
    }

    return _repository.resetPassword(
      token: params.token.trim(),
      newPassword: params.newPassword,
    );
  }
}