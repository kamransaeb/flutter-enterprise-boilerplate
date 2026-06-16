import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repository.dart';

@injectable
class RefreshTokenUseCase extends BaseUseCase<String, NoParams> {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  @override
  FutureOr<Either<Failure, String>> call(NoParams params) async {
    return _repository.refreshToken();
  }
}