import 'package:flutter_enterprise_boilerplate/features/products/data/api/product_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_api_client.g.dart';

@singleton
@RestApi()
abstract class ProductApiClient {
  @factoryMethod
  factory ProductApiClient(DioClient dioClient) {
    return _ProductApiClient(dioClient.dio);
  }

  // ============================================================================
  // Product Endpoints
  // ============================================================================

  @GET(ProductEndpoints.getProducts)
  Future<HttpResponse<Map<String, dynamic>>> getProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('category') String? category,
    @Query('min_price') double? minPrice,
    @Query('max_price') double? maxPrice,
    @Query('sort_by') String? sortBy,
    @Query('in_stock_only') bool? inStockOnly,
    @Query('min_rating') double? minRating,
    @Query('sort_order') String? sortOrder,
    @Query('search') String? searchQuery,
  });

  @GET(ProductEndpoints.getProductById)
  Future<HttpResponse<Map<String, dynamic>>> getProductById({
    @Path('id') String productId,
  });

  @GET(ProductEndpoints.getProductBySlug)
  Future<HttpResponse<Map<String, dynamic>>> getProductBySlug({
    @Path('slug') String slug,
  });

  @GET(ProductEndpoints.getCategories)
  Future<HttpResponse<List<Map<String, dynamic>>>> getCategories({
    @Query('parent_id') String? parentId,
  });

  @GET(ProductEndpoints.getCategoryById)
  Future<HttpResponse<Map<String, dynamic>>> getCategoryById(
    @Path('id') String categoryId,
  );

  @GET(ProductEndpoints.getCategoryBySlug)
  Future<HttpResponse<Map<String, dynamic>>> getCategoryBySlug({
    @Path('slug') String slug,
  });

  @GET(ProductEndpoints.getFeaturedProducts)
  Future<HttpResponse<List<Map<String, dynamic>>>> getFeaturedProducts({
    @Query('limit') int limit,
  });

  @GET(ProductEndpoints.getPopularProducts)
  Future<HttpResponse<List<Map<String, dynamic>>>> getPopularProducts();

  @GET(ProductEndpoints.getNewArrivals)
  Future<HttpResponse<List<Map<String, dynamic>>>> getNewArrivals();

  @GET(ProductEndpoints.getDiscountedProducts)
  Future<HttpResponse<List<Map<String, dynamic>>>> getDiscountedProducts();

  @GET(ProductEndpoints.getRelatedProducts)
  Future<HttpResponse<List<Map<String, dynamic>>>> getRelatedProducts({
    @Path('id') String productId,
  });

  @GET(ProductEndpoints.searchProducts)
  Future<HttpResponse<Map<String, dynamic>>> searchProducts({
    @Query('q') required String query,
    @Query('page') int page,
    @Query('limit') int limit,
  });

  @GET(ProductEndpoints.getProductReviews)
  Future<HttpResponse<Map<String, dynamic>>> getProductReviews({
    @Path('id') String productId,
    @Query('page') int page,
    @Query('limit') int limit,
  });

  @POST(ProductEndpoints.addProductReview)
  Future<HttpResponse<Map<String, dynamic>>> addProductReview({
    @Path('id') String productId,
    @Body() ProductReviewModel productReviewModel,
  });

  @PUT(ProductEndpoints.updateProductReview)
  Future<HttpResponse<Map<String, dynamic>>> updateProductReview({
    @Path('reviewId') String reviewId,
    @Body() ProductReviewModel productReviewModel,
  });

  @DELETE(ProductEndpoints.deleteProductReview)
  Future<HttpResponse<void>> deleteProductReview({
    @Path('reviewId') String reviewId,
  });

  @GET(ProductEndpoints.getProductAttributes)
  Future<HttpResponse<List<Map<String, dynamic>>>> getProductAttributes();

  @GET(ProductEndpoints.getProductBrands)
  Future<HttpResponse<List<Map<String, dynamic>>>> getProductBrands();

  @GET(ProductEndpoints.getWishlist)
  Future<HttpResponse<List<Map<String, dynamic>>>> getWishlist();

  @POST(ProductEndpoints.addToWishlist)
  Future<HttpResponse<void>> addToWishlist({
    @Path('productId') required String productId,
  });

  @DELETE(ProductEndpoints.removeFromWishlist)
  Future<HttpResponse<void>> removeFromWishlist({
    @Path('productId') required String productId,
  });

  @GET(ProductEndpoints.getRecentlyViewed)
  Future<HttpResponse<List<Map<String, dynamic>>>> getRecentlyViewed({
    @Query('limit') int limit,
  });

  @POST(ProductEndpoints.addToRecentlyViewed)
  Future<HttpResponse<void>> addToRecentlyViewed({
    @Path('productId') required String productId,
  });

  @DELETE(ProductEndpoints.removeFromRecentlyViewed)
  Future<HttpResponse<void>> removeFromRecentlyViewed({
    @Path('productId') required String productId,
  });

}
