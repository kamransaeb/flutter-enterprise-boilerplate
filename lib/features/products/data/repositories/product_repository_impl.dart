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
        category: filter?.categories.firstOrNull,
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
        await _localDataSource.addToCachedRecentlyViewed(apiResponse.data!);
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
  Future<Either<Failure, List<ProductReview>>> getProductReviews(
    String productId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final cachedReviews = await _localDataSource.getCachedProductReviews(
        productId: productId,
        page: page,
        limit: limit,
      );
      if (cachedReviews.isNotEmpty) {
        return Right(cachedReviews.map((model) => model.toEntity()).toList());
      }

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
    int page = 1,
    int limit = 20,
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
        await _localDataSource.addToCachedProductReviews(
          productId: productId,
          review: apiResponse.data!,
          page: page,
          limit: limit,
        );
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
  Future<Either<Failure, void>> toggleWishlist(String productId) async {
    try {
      final wasInWishlist = await _localDataSource.isInCachedWishlist(
        productId,
      );

      // Update locally first for immediate feedback
      if (wasInWishlist) {
        await _localDataSource.removeFromCachedWishlist(productId);
      } else {
        await _localDataSource.addToCachedWishlist(productId);
      }
      //await _localDataSource.toggleCachedWishlist(productId);

      // Sync with remote
      final apiResponse = await _remoteDataSource.toggleWishlist(
        productId: productId,
      );
      if (apiResponse.isSuccess) {
        return const Right(null);
      }
      //*** IMPORTANT: Revert local change if remote fails
      if (wasInWishlist) {
        await _localDataSource.addToCachedWishlist(productId);
      } else {
        await _localDataSource.removeFromCachedWishlist(productId);
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'Failed to toggle favorite',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getWishlist({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Get from local cache first
      final cachedWishlist = await _localDataSource.getCachedWishlist();
      if (cachedWishlist.isNotEmpty) {
        return Right(cachedWishlist.map((model) => model.toEntity()).toList());
      }
      // Get from remote
      final apiResponse = await _remoteDataSource.getWishlist(
        page: page,
        limit: limit,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheWishlist(apiResponse.data!);
        return Right(
          apiResponse.data!.map((model) => model.toEntity()).toList(),
        );
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message: apiResponse.error?.message ?? 'Failed to get wishlist',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      // Try local search first for quick results
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> addToWishlist(String productId) async {
    try {
      await _localDataSource.addToCachedWishlist(productId);
      await _remoteDataSource.addToWishlist(productId: productId);
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromWishlist(String productId) async {
    try {
      await _localDataSource.removeFromCachedWishlist(productId);
      await _remoteDataSource.removeFromWishlist(productId: productId);
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRecentlyViewed({
    int limit = 10,
  }) async {
    try {
      final cachedRecentlyViewed = await _localDataSource
          .getCachedRecentlyViewed();
      if (cachedRecentlyViewed.isNotEmpty) {
        return Right(
          cachedRecentlyViewed.map((model) => model.toEntity()).toList(),
        );
      }
      final apiResponse = await _remoteDataSource.getRecentlyViewed(
        limit: limit,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheRecentlyViewed(apiResponse.data!);
        return Right(
          apiResponse.data!.map((model) => model.toEntity()).toList(),
        );
      }
      return Left(
        ServerFailure(
          code: apiResponse.error?.code,
          message:
              apiResponse.error?.message ??
              'Failed to get recently viewed products',
          statusCode: apiResponse.statusCode,
        ),
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
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
