import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/product_repository.dart';

@injectable
class ToggleFavoriteUseCase {
  final ProductRepository _repository;

  ToggleFavoriteUseCase(this._repository);

  Future<Either<Failure, void>> execute(ToggleFavoriteParams params) async {
    return await _repository.toggleFavorite(params.productId);
  }
}

class ToggleFavoriteParams {
  final String productId;

  ToggleFavoriteParams({required this.productId});
}