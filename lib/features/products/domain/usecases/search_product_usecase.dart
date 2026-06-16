import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

@injectable
class SearchProductsUseCase {
  final ProductRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> execute(SearchProductsParams params) async {
    return await _repository.searchProducts(
      params.query,
      page: params.page,
      limit: params.limit,
    );
  }
}

class SearchProductsParams {
  final String query;
  final int page;
  final int limit;

  SearchProductsParams({
    required this.query,
    this.page = 1,
    this.limit = 20,
  });
}