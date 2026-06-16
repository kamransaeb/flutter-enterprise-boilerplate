import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/change_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/forget_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/resend_verification_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/reset_password_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_response_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/update_profile_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/verify_email_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/initiate_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/refund_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/verify_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/apply_coupon_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/calculate_shipping_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/create_order_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/remove_coupon_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/return_order_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/update_cart_item_request.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/address_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/auth_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/config_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/deeplink_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/order_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/payments_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/product_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/upload_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/user_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/deep_link_validation_response.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

// Case	Approach	Example
// - Normal authenticated API calls
// AuthInterceptor

// - Public endpoints (login, register)
// @Extra({'requireAuth': false}) on the Retrofit method
// The current Interceptor is set to requireAuth = true unless told otherwise.

// - One-off token (e.g. email verification link, password reset link, 
// invitations, etc.)
// Use @Header('Authorization') when the request must include an auth token,
// for example:
// email verification token
// magic-link/JWT that is meant only for that endpoint
// tokens issued for special flow 

// - Calling a different auth scheme
// Use @Header('Authorization') when the scheme diffes from what your
// interceptor implements (currently Authorization: Bearer Token)
// ApiKey <key>
// Basic <base64 user:pass>
// OAuth2 token types that are not Bearer
// Tenant-specific headers
// @GET(UserEndpoints.getProfile)
// Future<HttpResponse<UserModel>> getProfile({
//   @Header('Authorization') required String token,
// });

@singleton
@RestApi()
abstract class ApiClient {
  // @factoryMethod
  // factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @factoryMethod
  factory ApiClient(DioClient dioClient) {
    // Get the underlying Dio instance from DioClient
    return _ApiClient(dioClient.dio);
  }

  // // ============================================================================
  // // Auth Endpoints
  // // ============================================================================
  // TYPE 1: Simple, predictable responses - Use strong types
  @POST(AuthEndpoints.login)
  @Extra({'requireAuth': false})
  Future<HttpResponse<LoginResponseModel>> login({
    @Body() required LoginRequestModel loginRequestModel,
  });

  @POST(AuthEndpoints.register)
  @Extra({'requireAuth': false})
  Future<HttpResponse<RegisterResponseModel>> register({
    @Body() required RegisterRequestModel registerRequestModel,
  });

  @POST(AuthEndpoints.logout)
  Future<HttpResponse<void>> logout(
    // @Header('Authorization') required String authorization,
  );

  @POST(AuthEndpoints.refreshToken)
  Future<HttpResponse<TokenRefreshResponseModel>> refreshToken({
    @Body() required TokenRefreshRequestModel refreshTokenRequestModel,
  });

  @POST(AuthEndpoints.forgotPassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> forgotPassword({
    @Body() required ForgotPasswordRequestModel forgotPasswordRequestModel,
  });

  @POST(AuthEndpoints.resetPassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> resetPassword({
    @Body() required ResetPasswordRequestModel resetPasswordRequestModel,
  });

  @POST(AuthEndpoints.verifyEmail)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> verifyEmail({
    @Body() required VerifyEmailRequestModel verifyEmailRequestModel,
  });

  @POST(AuthEndpoints.resendVerificationEmail)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> resendVerificationEmail({
    @Body()
    required ResendVerificationEmailRequestModel resendVerificationEmailRequestModel,
  });

  @POST(AuthEndpoints.changePassword)
  @Extra({'requireAuth': false})
  Future<HttpResponse<void>> changePassword({
    @Body() required ChangePasswordRequestModel changePasswordRequestModel,
  });

  @POST(AuthEndpoints.socialLogin)
  @Extra({'requireAuth': false})
  Future<HttpResponse<SocialLoginResponseModel>> socialLogin({
    @Body() required SocialLoginRequestModel socialLoginRequestModel,
  });

 
  // ============================================================================
  // User Endpoints
  // ============================================================================

  @GET(UserEndpoints.getProfile)
  Future<HttpResponse<UserModel>> getProfile();

  @PUT(UserEndpoints.updateProfile)
  Future<HttpResponse<UserModel>> updateProfile({
    @Body() required UpdateProfileRequestModel updateProfileRequestModel,
  });

  // @PATCH(UserEndpoints.updateProfilePicture)
  // Future<HttpResponse<Map<String, dynamic>>> updateProfilePicture(
  //   @Body() Map<String, dynamic> body,
  // );

  @DELETE(UserEndpoints.deleteAccount)
  Future<HttpResponse<void>> deleteAccount();

  @GET(UserEndpoints.getAddresses)
  Future<HttpResponse<List<Map<String, dynamic>>>> getAddresses();

  @POST(UserEndpoints.addAddress)
  Future<HttpResponse<Map<String, dynamic>>> addAddress(
    @Body() Map<String, dynamic> body,
  );

  @PUT(UserEndpoints.updateAddress)
  Future<HttpResponse<Map<String, dynamic>>> updateAddress(
    @Path('id') String addressId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE(UserEndpoints.deleteAddress)
  Future<HttpResponse<void>> deleteAddress(@Path('id') String addressId);

  @GET(UserEndpoints.getPaymentMethods)
  Future<HttpResponse<List<Map<String, dynamic>>>> getPaymentMethods();

  @POST(UserEndpoints.addPaymentMethod)
  Future<HttpResponse<Map<String, dynamic>>> addPaymentMethod(
    @Body() Map<String, dynamic> body,
  );

  @DELETE(UserEndpoints.deletePaymentMethod)
  Future<HttpResponse<void>> deletePaymentMethod(@Path('id') String methodId);

  @GET(UserEndpoints.getNotifications)
  Future<HttpResponse<Map<String, dynamic>>> getNotifications(
    @Query('page') int page,
    @Query('limit') int limit,
  );

  @PATCH(UserEndpoints.readNotification)
  Future<HttpResponse<void>> readNotification(
    @Path('id') String notificationId,
  );

  @PATCH(UserEndpoints.unreadNotification)
  Future<HttpResponse<void>> unreadNotification();

  @DELETE(UserEndpoints.deleteNotification)
  Future<HttpResponse<void>> deleteNotification(
    @Path('id') String notificationId,
  );

  @DELETE(UserEndpoints.deleteAllNotifications)
  Future<HttpResponse<void>> deleteAllNotifications();

  @PATCH(UserEndpoints.readAllNotifications)
  Future<HttpResponse<void>> readAllNotifications();

  @PATCH(UserEndpoints.unreadAllNotifications)
  Future<HttpResponse<void>> unreadAllNotifications();

  @GET(UserEndpoints.getWishlist)
  Future<HttpResponse<List<Map<String, dynamic>>>> getWishlist();

  @POST(UserEndpoints.addToWishlist)
  Future<HttpResponse<void>> addToWishlist(@Body() Map<String, dynamic> body);

  @DELETE(UserEndpoints.removeFromWishlist)
  Future<HttpResponse<void>> removeFromWishlist(@Path('id') String productId);

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
  Future<HttpResponse<List<Map<String, dynamic>>>> getCategories(
    @Query('parent_id') String? parentId,
  );

  @GET(ProductEndpoints.getCategoryById)
  Future<HttpResponse<Map<String, dynamic>>> getCategoryById(
    @Path('id') String categoryId,
  );

  @GET(ProductEndpoints.getCategoryBySlug)
  Future<HttpResponse<Map<String, dynamic>>> getCategoryBySlug({
    @Path('slug') String slug,
  });

  @GET(ProductEndpoints.getFeaturedProducts)
  Future<HttpResponse<List<Map<String, dynamic>>>> getFeaturedProducts(
    @Query('limit') int limit,
  );

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

  // ============================================================================
  // Order Endpoints
  // ============================================================================

  @POST(OrderEndpoints.createOrder)
  Future<HttpResponse<Map<String, dynamic>>> createOrder({
    @Body() required CreateOrderRequestModel createOrderRequestModel,
  });

  @GET(OrderEndpoints.getOrders)
  Future<HttpResponse<Map<String, dynamic>>> getOrders({
    @Query('page') required int page,
    @Query('limit') required int limit,
    @Query('status') String? status,
  });

  @GET(OrderEndpoints.getOrderById)
  Future<HttpResponse<Map<String, dynamic>>> getOrderById({
    @Path('id') required String orderId,
  });

  @GET(OrderEndpoints.getOrderByNumber)
  Future<HttpResponse<Map<String, dynamic>>> getOrderByNumber({
    @Path('number') required String orderNumber,
  });

  @PATCH(OrderEndpoints.cancelOrder)
  Future<HttpResponse<void>> cancelOrder({
    @Path('id') required String orderId,
  });

  @POST(OrderEndpoints.returnOrder)
  Future<HttpResponse<void>> returnOrder({
    @Path('id') required String orderId,
    @Body() required ReturnOrderRequestModel returnOrderRequestModel,
  });

  @GET(OrderEndpoints.trackOrder)
  Future<HttpResponse<Map<String, dynamic>>> trackOrder({
    @Path('id') required String orderId,
  });

  @GET(OrderEndpoints.getOrderInvoice)
  Future<HttpResponse<String>> getOrderInvoice({    
    @Path('id') required String orderId,
  });

  @POST(OrderEndpoints.reorder)
  Future<HttpResponse<Map<String, dynamic>>> reorder({
    @Path('id') required String orderId,
  });

  @GET(OrderEndpoints.getCart)
  Future<HttpResponse<Map<String, dynamic>>> getCart({
  });

  @POST(OrderEndpoints.addToCart)
  Future<HttpResponse<Map<String, dynamic>>> addToCart({
    @Body() required AddToCartRequestModel addToCartRequestModel,
  });

  @PUT(OrderEndpoints.updateCartItem)
  Future<HttpResponse<Map<String, dynamic>>> updateCartItem({
    @Body() required UpdateCartItemRequestModel updateCartItemRequestModel,
  });

  @DELETE(OrderEndpoints.removeFromCart)
  Future<HttpResponse<void>> removeFromCart({
    @Path('id') required String itemId,
  });

  @POST(OrderEndpoints.clearCart)
  Future<HttpResponse<void>> clearCart(
  );

  @POST(OrderEndpoints.applyCoupon)
  Future<HttpResponse<Map<String, dynamic>>> applyCoupon({
    @Body() required ApplyCouponRequestModel applyCouponRequestModel,
  });


  @DELETE(OrderEndpoints.removeCoupon)
  Future<HttpResponse<Map<String, dynamic>>> removeCoupon({
    @Body() required RemoveCouponRequestModel removeCouponRequestModel,
  });

  @GET(OrderEndpoints.getShippingMethods)
  Future<HttpResponse<List<Map<String, dynamic>>>> getShippingMethods();

  @POST(OrderEndpoints.calculateShipping)
  Future<HttpResponse<Map<String, dynamic>>> calculateShipping({
    @Body() required CalculateShippingRequestModel calculateShippingRequestModel,
  });

  // ============================================================================
  // Payment Endpoints
  // ============================================================================

  @POST(PaymentEndpoints.initiatePayment)
  Future<HttpResponse<Map<String, dynamic>>> initiatePayment({
    @Body() required InitiatePaymentRequestModel initiatePaymentRequestModel,
  });

  @POST(PaymentEndpoints.verifyPayment)
  Future<HttpResponse<Map<String, dynamic>>> verifyPayment({
    @Body() required VerifyPaymentRequestModel verifyPaymentRequestModel,
  });

  @GET(PaymentEndpoints.getPaymentStatus)
  Future<HttpResponse<Map<String, dynamic>>> getPaymentStatus({
    @Path('id') required String paymentId,
  });

  @POST(PaymentEndpoints.refundPayment)
  Future<HttpResponse<Map<String, dynamic>>> refundPayment({
    @Path('id') required String paymentId,
    @Body() required RefundPaymentRequestModel refundPaymentRequestModel,
  });

  /// Payment gateway methods (distinct from [getPaymentMethods] on user profile).
  @GET(PaymentEndpoints.getPaymentMethods)
  Future<HttpResponse<List<Map<String, dynamic>>>>
      getPaymentsGatewayMethods({
  });

  // ============================================================================
  // Address Validation
  // ============================================================================

  @POST(AddressEndpoints.validate)
  Future<HttpResponse<Map<String, dynamic>>> validateAddress(
    @Body() Map<String, dynamic> body,
  );

  @GET(AddressEndpoints.autocomplete)
  Future<HttpResponse<List<Map<String, dynamic>>>> addressAutocomplete(
    @Query('query') String query,
  );

  // ============================================================================
  // Deep Link Validation
  // ============================================================================

  @POST(DeeplinkEndpoints.validate)
  Future<HttpResponse<DeepLinkValidationResponse>> validateDeepLink(
    @Body() Map<String, dynamic> body,
  );

  // ============================================================================
  // App Configuration
  // ============================================================================

  @GET(ConfigEndpoints.app)
  Future<HttpResponse<Map<String, dynamic>>> getAppConfig();

  @GET(ConfigEndpoints.features)
  Future<HttpResponse<Map<String, dynamic>>> getFeatureFlags();

  // ============================================================================
  // Upload Methods (for files/images)
  // ============================================================================

  @POST(UploadEndpoints.image)
  Future<HttpResponse<Map<String, dynamic>>> uploadImage(
    @Body() FormData formData,
  );

  @POST(UploadEndpoints.file)
  Future<HttpResponse<Map<String, dynamic>>> uploadFile(
    @Body() FormData formData,
  );

  @DELETE(UploadEndpoints.deleteById)
  Future<HttpResponse<void>> deleteFile(@Path('id') String fileId);
}
