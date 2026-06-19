import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_category_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/domain/entities/product_filter.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/paginated_cache_response.dart';

abstract class ProductLocalDataSource {
  // Product caching
  Future<void> cacheProducts({
    required List<ProductModel> products,
    required int page,
    required int limit,
    ProductFilter? filter,
  });

  Future<PaginatedCacheResponse<ProductModel>?> getCachedProducts({
    required int page,
    required int limit,
    ProductFilter? filter,
  });

  Future<void> cacheProduct(ProductModel product);
  Future<ProductModel?> getCachedProduct(String productId);
  Future<void> cacheMultipleProducts(List<ProductModel> products);
  Future<List<ProductModel>> getCachedProductsByIds(List<String> productIds);

  // Category caching
  Future<void> cacheCategories(List<ProductCategoryModel> categories);
  Future<List<ProductCategoryModel>> getCachedCategories();
  Future<ProductCategoryModel?> getCachedCategory(String categoryId);

  // ProductReview caching
  Future<void> cacheProductReviews({
    required String productId,
    required List<ProductReviewModel> reviews,
    required int page,
    required int limit,
  });
  Future<List<ProductReviewModel>> getCachedProductReviews({
    required String productId,
    required int page,
    required int limit,
  });
  Future<void> addToCachedProductReviews({
    required String productId,
    required ProductReviewModel review,
    required int page,
    required int limit,
  });

  // Search and filter
  Future<List<ProductModel>> searchCachedProducts(String query);
  Future<List<ProductModel>> filterCachedProducts(ProductFilter filter);

  // Recently viewed
  Future<void> cacheRecentlyViewed(List<ProductModel> products);
  Future<List<ProductModel>> getCachedRecentlyViewed();
  Future<void> addToCachedRecentlyViewed(ProductModel product);
  Future<void> clearCachedRecentlyViewed();

  // Wishlist
  Future<void> cacheWishlist(List<ProductModel> products);
  Future<List<ProductModel>> getCachedWishlist();
  Future<void> addToCachedWishlist(String productId);
  Future<void> removeFromCachedWishlist(String productId);
  Future<bool> isInCachedWishlist(String productId);
  Future<void> clearCachedWishlist();
  // *** IMPORTANT: toggleCachedWishlist is not implemented because
  // it can revert the local change if the remote fails
  //Future<void> toggleCachedWishlist(String productId);


  // Cache management
  Future<void> clearCache();
  Future<void> clearExpiredCache();
  Future<int> getCacheSize();

  // Featured products
  Future<void> cacheFeaturedProducts({
    required List<ProductModel> products,
    int limit = 10,
  });

  Future<List<ProductModel>> getCachedFeaturedProducts({int limit = 10});

    // Related products
  Future<void> cacheRelatedProducts({
    required String productId,
    required List<ProductModel> products,
  });
  Future<List<ProductModel>> getCachedRelatedProducts(String productId);


}
