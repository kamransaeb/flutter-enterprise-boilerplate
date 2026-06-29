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
import '../models/product_category_model.dart';

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
  Future<Either<Failure, List<Product>>> getFeaturedProducts({
    int limit = 10,
  }) async {
    try {
      final cachedProducts = await _localDataSource.getCachedFeaturedProducts(
        limit: limit,
      );
      if (cachedProducts.isNotEmpty) {
        return Right(
          cachedProducts.map((model) => model.toEntity()).toList(),
        );
      }

      final apiResponse = await _remoteDataSource.getFeaturedProducts(
        limit: limit,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheFeaturedProducts(
          products: apiResponse.data!,
          limit: limit,
        );
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
      final cachedCategories = await _localDataSource.getCachedCategories();
      if (cachedCategories.isNotEmpty) {
        final categories = cachedCategories
            .where((category) => category.parentId == parentId)
            .map((model) => model.toEntity())
            .toList();
        return Right(categories);
      }

      final apiResponse = await _remoteDataSource.getCategories(
        parentId: parentId,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheCategories(apiResponse.data!);
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
  Future<Either<Failure, ProductCategory>> getCategoryById({
    required String categoryId,
  }) async {
    try {
      final cachedCategory = await _localDataSource.getCachedCategory(
        categoryId,
      );
      if (cachedCategory != null) {
        return Right(cachedCategory.toEntity());
      }

      final categoriesResult = await getCategories();
      return categoriesResult.fold(
        Left.new,
        (categories) {
          for (final category in categories) {
            if (category.id == categoryId) {
              return Right(category);
            }
            for (final child in category.children) {
              if (child.id == categoryId) {
                return Right(child);
              }
            }
          }
          return Left(CacheFailure(message: 'Category not found'));
        },
      );
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByIds({
    required List<String> productIds,
  }) async {
    try {
      if (productIds.isEmpty) {
        return const Right([]);
      }

      final cachedProducts = await _localDataSource.getCachedProductsByIds(
        productIds,
      );
      final cachedIds = cachedProducts.map((product) => product.id).toSet();
      final missingIds = productIds
          .where((id) => !cachedIds.contains(id))
          .toList();

      final products = cachedProducts.map((model) => model.toEntity()).toList();

      for (final productId in missingIds) {
        final productResult = await getProductById(productId: productId);
        productResult.fold(
          (_) {},
          (product) => products.add(product),
        );
      }

      return Right(products);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> searchProducts(
    String query, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      if (query.trim().isEmpty) {
        return const Right([]);
      }

      final cachedProducts = await _localDataSource.searchCachedProducts(query);
      if (cachedProducts.isNotEmpty) {
        return Right(cachedProducts.map((model) => model.toEntity()).toList());
      }

      final apiResponse = await _remoteDataSource.searchProducts(
        query: query,
        page: page,
        limit: limit,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheMultipleProducts(apiResponse.data!);
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
  Future<Either<Failure, List<Product>>> filterProducts(
    ProductFilter filter,
  ) async {
    try {
      final cachedProducts = await _localDataSource.filterCachedProducts(filter);
      if (cachedProducts.isNotEmpty) {
        return Right(cachedProducts.map((model) => model.toEntity()).toList());
      }

      return getProducts(page: 1, limit: 20, filter: filter);
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
        await _localDataSource.cacheProductReviews(
          productId: productId,
          reviews: apiResponse.data!,
          page: page,
          limit: limit,
        );
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
    const page = 1;
    const limit = 20;

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
  Future<Either<Failure, bool>> isInWishlist(String productId) async {
    try {
      final isInWishlist = await _localDataSource.isInCachedWishlist(productId);
      return Right(isInWishlist);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> clearWishlist() async {
    try {
      await _localDataSource.clearCachedWishlist();
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
  Future<Either<Failure, void>> addToRecentlyViewed(String productId) async {
    try {
      final cachedProduct = await _localDataSource.getCachedProduct(productId);
      if (cachedProduct != null) {
        await _localDataSource.addToCachedRecentlyViewed(cachedProduct);
      } else {
        final apiResponse = await _remoteDataSource.getProductById(
          productId: productId,
        );
        if (apiResponse.isSuccess && apiResponse.hasData) {
          await _localDataSource.cacheProduct(apiResponse.data!);
          await _localDataSource.addToCachedRecentlyViewed(apiResponse.data!);
        }
      }

      await _remoteDataSource.addToRecentlyViewed(productId: productId);
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> clearRecentlyViewed() async {
    try {
      await _localDataSource.clearCachedRecentlyViewed();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getRelatedProducts(
    String productId, {
    int limit = 5,
  }) async {
    try {
      final cachedProducts = await _localDataSource.getCachedRelatedProducts(
        productId,
      );
      if (cachedProducts.isNotEmpty) {
        return Right(
          cachedProducts
              .take(limit)
              .map((model) => model.toEntity())
              .toList(),
        );
      }

      final apiResponse = await _remoteDataSource.getRelatedProducts(
        productId: productId,
      );
      if (apiResponse.isSuccess && apiResponse.hasData) {
        await _localDataSource.cacheRelatedProducts(
          productId: productId,
          products: apiResponse.data!,
        );
        return Right(
          apiResponse.data!
              .take(limit)
              .map((model) => model.toEntity())
              .toList(),
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
  Future<Either<Failure, List<Product>>> getTrendingProducts({
    int limit = 10,
  }) async {
    return Left(
      CacheFailure(message: 'Trending products are not available'),
    );
  }

  @override
  Future<Either<Failure, List<Product>>> getRecommendations({
    int limit = 10,
  }) async {
    return Left(
      CacheFailure(message: 'Recommendations are not available'),
    );
  }

  @override
  Future<Either<Failure, void>> clearCache() async {
    try {
      await _localDataSource.clearCache();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, void>> clearExpiredCache() async {
    try {
      await _localDataSource.clearExpiredCache();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<Failure, int>> getCacheSize() async {
    try {
      final cacheSize = await _localDataSource.getCacheSize();
      return Right(cacheSize);
    } catch (e, stackTrace) {
      return Left(ErrorHandler.handleError(e, stackTrace: stackTrace));
    }
  }
}
