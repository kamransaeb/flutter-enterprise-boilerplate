import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../entities/product_filter.dart';
import '../repositories/product_repository.dart';

@injectable
class GetProductsUseCase {
  final ProductRepository _repository;

  GetProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> execute(GetProductsParams params) async {
    return await _repository.getProducts(
      page: params.page,
      limit: params.limit,
      filter: params.filter,
    );
  }
}

class GetProductsParams {
  final int page;
  final int limit;
  final ProductFilter? filter;

  GetProductsParams({
    this.page = 1,
    this.limit = 20,
    this.filter,
  });
}