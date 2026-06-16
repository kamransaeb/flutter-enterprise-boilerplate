import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/verify_email_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class VerifyEmailUseCase extends BaseUseCase<void, VerifyEmailParams> {
  final AuthRepository _repository;

  VerifyEmailUseCase(this._repository);

  @override
  FutureOr<Either<Failure, void>> call(VerifyEmailParams params) async {
    if (params.email.trim().isEmpty || params.token.trim().isEmpty) {
      return Left(ValidationFailure(message: 'Email and token are required'));
    }

    return _repository.verifyEmail(
      params.email.trim(),
      params.token.trim(),
    );
  }
}
