import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/api_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/product_model.dart';
import '../models/product_category_model.dart';
import '../models/product_review_model.dart';

/// Remote product API contract (auth-style).
/// Implementation: [ProductRemoteDataSourceImpl] using [ApiClient].
abstract class ProductRemoteDataSource {
  // Get products
  Future<ApiResponse<List<ProductModel>>> getProducts({
    required int page,
    required int limit,
    String? category,
    String? searchQuery,
    double? minPrice,
    double? maxPrice,
    bool? inStockOnly,
    double? minRating,
    String? sortBy,
    String? sortOrder,
  });

  // Get product by id
  Future<ApiResponse<ProductModel>> getProductById({required String productId});

  // Get featured products
  Future<ApiResponse<List<ProductModel>>> getFeaturedProducts({required int limit});

  // Get related products
  Future<ApiResponse<List<ProductCategoryModel>>> getCategories(
    {String? parentId}
  );

  // Get product reviews
  Future<ApiResponse<List<ProductReviewModel>>> getProductReviews({
    required String productId,
    int page = 1,
    int limit = 20,
  });

  // Get categories
  Future<ApiResponse<ProductReviewModel>> addProductReview({
    required String productId,
    required ProductReviewModel productReviewModel,
  });


  // Toggle wishlist
  Future<ApiResponse<void>> toggleWishlist({required String productId});
  Future<ApiResponse<List<ProductModel>>> getWishlist({
    int page = 1,
    int limit = 20,
  });
  Future<ApiResponse<void>> removeFromWishlist({required String productId});
  Future<ApiResponse<void>> addToWishlist({required String productId});

  // Search products
  Future<ApiResponse<List<ProductModel>>> searchProducts({
    required String query,
    int page = 1,
    int limit = 20,
  });

  // Get related products
   Future<ApiResponse<List<ProductModel>>> getRelatedProducts({
    required String productId,
  });

  // Get recently viewed products
  Future<ApiResponse<List<ProductModel>>> getRecentlyViewed({
    int limit = 10,
  });
  Future<ApiResponse<void>> addToRecentlyViewed({required String productId});
  Future<ApiResponse<void>> removeFromRecentlyViewed({required String productId});

  // // Get trending products
  // Future<ApiResponse<List<ProductModel>>> getTrendingProducts();

  // // Get recommendations
  // Future<ApiResponse<List<ProductModel>>> getRecommendations();

  // // Track product view
  //   Future<ApiResponse<void>> trackProductView({
  //   required String productId,
  // });
  
}
