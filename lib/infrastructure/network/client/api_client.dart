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
import 'package:flutter_enterprise_boilerplate/features/auth/data/api/auth_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/config_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/deeplink_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/order_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/payments_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/features/products/data/api/product_endpoints.dart';
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
    @Query('limit') int limit,
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
      getPaymentsGatewayMethods();

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
