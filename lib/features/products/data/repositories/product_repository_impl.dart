import 'package:dartz/dartz.dart';
import 'package:flutter_enterprise_boilerplate/core/errors/error_handler.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/product_category.dart';
import '../../domain/entities/product_filter.dart';
import '../../domain/entities/product_review.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  ProductRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, List<Product>>> getProducts({
    int page = 1,
    int limit = 20,
    ProductFilter? filter,
  }) async {
    try {
      // Try to get from local cache first
      if (page == 1 && filter == null) {
        final cachedProducts = await _localDataSource.getCachedProducts(
          page: page,
          limit: limit,
          filter: filter,
        );
        if (cachedProducts != null && cachedProducts.items.isNotEmpty) {
          return Right(
            cachedProducts.items.map((model) => model.toEntity()).toList(),
          );
        }
      }

      // Get from remote
      final apiResponse = await _remoteDataSource.getProducts(
        page: page,
        limit: limit,
        category: filter?.categories?.firstOrNull,
        searchQuery: filter?.searchQuery,
        minPrice: filter?.minPrice,
        maxPrice: filter?.maxPrice,
        inStockOnly: filter?.inStockOnly,
        minRating: filter?.minRating,
        sortBy: filter?.sortBy,
        sortOrder: filter?.sortOrder,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheProducts(
          products: apiResponse.data!,
          page: page,
          limit: limit,
          filter: filter,
        );
        final products = apiResponse.data!
            .map((model) => model.toEntity())
            .toList();
        return Right(products);
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById({
    required String productId,
  }) async {
    try {
      // Try to get from local cache first
      final cachedProduct = await _localDataSource.getCachedProduct(productId);
      if (cachedProduct != null) {
        return Right(cachedProduct.toEntity());
      }

      // Get from remote
      final apiResponse = await _remoteDataSource.getProductById(
        productId: productId,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheProduct(apiResponse.data!);
        await _localDataSource.addToRecentlyViewed(apiResponse.data!);
        return Right(apiResponse.data!.toEntity());
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFeaturedProducts({
    int limit = 10,
  }) async {
    try {
      final apiResponse = await _remoteDataSource.getFeaturedProducts(
        limit: limit,
      );

      if (apiResponse.isSuccess && apiResponse.hasData) {
        return Right(
          apiResponse.data!.map((model) => model.toEntity()).toList(),
        );
      }

      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<ProductCategory>>> getCategories({
    String? parentId,
  }) async {
    try {
      final apiResponse = await _remoteDataSource.getCategories(
        parentId: parentId,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        return Right(
          apiResponse.data!.map((model) => model.toEntity()).toList(),
        );
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<ProductReview>>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final apiResponse = await _remoteDataSource.getProductReviews(
        productId: productId,
        page: page,
        limit: limit,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        return Right(
          apiResponse.data!.map((model) => model.toEntity()).toList(),
        );
      }

      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, ProductReview>> addProductReview({
    required String productId,
    required double rating,
    required String comment,
  }) async {
    try {
      final apiResponse = await _remoteDataSource.addProductReview(
        productId: productId,
        productReviewModel: ProductReviewModel(
          rating: rating,
          comment: comment,
          id: '',
          productId: '',
          userId: '',
          userName: '',
          createdAt: DateTime.now(),
        ),
      );

      if (apiResponse.isSuccess && apiResponse.hasData) {
        return Right(apiResponse.data!.toEntity());
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'An unknown error occurred',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String productId) async {
    try {
      // Update locally first for immediate feedback
      await _localDataSource.toggleFavorite(productId);

      // Sync with remote
      await _remoteDataSource.toggleFavorite(productId);

      return const Right(null);
    } catch (e) {
      // If remote fails, revert local change
      await _localDataSource.toggleFavorite(productId);
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getFavorites({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Get from local cache first
      final localFavorites = await _localDataSource.getFavorites();
      if (localFavorites.isRight()) {
        return localFavorites;
      }

      // Get from remote
      final remoteFavorites = await _remoteDataSource.getFavorites(
        page: page,
        limit: limit,
      );
      final favorites = remoteFavorites
          .map((model) => model.toEntity())
          .toList();
      return Right(favorites);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Try local search first for quick results
      final localResults = await _localDataSource.searchProducts(query);
      if (localResults.isRight() && localResults.asRight().isNotEmpty) {
        return localResults;
      }

      // Get from remote
      final remoteResults = await _remoteDataSource.searchProducts(
        query,
        page: page,
        limit: limit,
      );
      final results = remoteResults.map((model) => model.toEntity()).toList();
      return Right(results);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRecentlyViewed({
    int limit = 10,
  }) async {
    try {
      final localResults = await _localDataSource.getRecentlyViewed();
      if (localResults.isRight()) {
        final products = localResults.asRight().take(limit).toList();
        return Right(products);
      }
      return const Right([]);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Stream<List<Product>> watchProducts() {
    return _localDataSource.watchProducts();
  }

  @override
  Stream<List<Product>> watchFavorites() {
    return _localDataSource.watchFavorites();
  }

  // Additional methods
  @override
  Future<Either<Failure, List<Product>>> getRelatedProducts(
    String productId, {
    int limit = 5,
  }) async {
    try {
      final remoteProducts = await _remoteDataSource.getRelatedProducts(
        productId,
        limit: limit,
      );
      final products = remoteProducts.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getTrendingProducts({
    int limit = 10,
  }) async {
    try {
      final remoteProducts = await _remoteDataSource.getTrendingProducts(
        limit: limit,
      );
      final products = remoteProducts.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRecommendations({
    int limit = 10,
  }) async {
    try {
      final remoteProducts = await _remoteDataSource.getRecommendations(
        limit: limit,
      );
      final products = remoteProducts.map((model) => model.toEntity()).toList();
      return Right(products);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> trackProductView(String productId) async {
    try {
      await _remoteDataSource.trackProductView(productId);
      return const Right(null);
    } catch (e) {
      return Left(_handleError(e));
    }
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await _localDataSource.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache: $e'));
    }
  }
}
