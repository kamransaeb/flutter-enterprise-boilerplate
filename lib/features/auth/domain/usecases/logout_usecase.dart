import 'package:dartz/dartz.dart';
import 'dart:async';
import 'package:flutter_enterprise_boilerplate/core/usecase/base_usecase.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class LogoutUseCase extends BaseUseCase<void, NoParams> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  FutureOr<Either<Failure, void>> call(NoParams params) async {
    return await _repository.logout();
  }
}