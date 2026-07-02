import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/product_repository.dart';

@injectable
class ToggleWishlistUseCase {
  final ProductRepository _repository;

  ToggleWishlistUseCase(this._repository);

  Future<Either<Failure, void>> execute(ToggleWishlistParams params) async {
    return await _repository.toggleWishlist(params.productId);
  }
}

class ToggleWishlistParams {
  final String productId;

  ToggleWishlistParams({required this.productId});
}