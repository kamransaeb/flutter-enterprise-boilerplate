abstract class ProductEndpoints {
  static const String getProducts = '/products';
  static const String getProductById = '/products/{id}';
  static const String getProductBySlug = '/products/slug/{slug}';
  
  static const String getCategories = '/categories';
  static const String getCategoryById = '/categories/{id}';
  static const String getCategoryBySlug = '/categories/slug/{slug}';
  
  static const String getFeaturedProducts = '/products/featured';
  static const String getPopularProducts = '/products/popular';
  static const String getNewArrivals = '/products/new-arrivals';
  static const String getDiscountedProducts = '/products/discounted';
  static const String getRelatedProducts = '/products/{id}/related';
  static const String searchProducts = '/products/search';
  
  static const String getProductReviews = '/products/{id}/reviews';
  static const String addProductReview = '/products/{id}/reviews';
  static const String updateProductReview = '/reviews/{reviewId}';
  static const String deleteProductReview = '/reviews/{reviewId}';
  
  static const String getProductAttributes = '/attributes';
  static const String getProductBrands = '/brands';

  static const String getWishlist = '/wishlist';
  static const String addToWishlist = '/wishlist';
  static const String removeFromWishlist = '/wishlist/{productId}';
  static const String getRecentlyViewed = '/recently-viewed';
  static const String addToRecentlyViewed = '/recently-viewed';
  static const String removeFromRecentlyViewed = '/recently-viewed/{productId}';
  
  
}