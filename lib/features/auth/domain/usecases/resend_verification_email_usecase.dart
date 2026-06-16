import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/domain/value_objects/resend_verification_email_params.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class ResendVerificationEmailUseCase
    extends BaseUseCase<void, ResendVerificationEmailParams> {
  final AuthRepository _repository;

  ResendVerificationEmailUseCase(this._repository);

  @override
  FutureOr<Either<Failure, void>> call(
    ResendVerificationEmailParams params,
  ) async {
    if (params.email.trim().isEmpty) {
      return Left(ValidationFailure(message: 'Email is required'));
    }

    return _repository.resendVerificationEmail(params.email.trim());
  }
}

