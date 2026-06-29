// import 'package:dio/dio.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/change_password_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/forget_password_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/login_response_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/register_response_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_response_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/resend_verification_email_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/reset_password_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/social_login_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/token_refresh_response_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/update_profile_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/models/verify_email_request_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/payments/data/models/initiate_payment_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/payments/data/models/refund_payment_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/payments/data/models/verify_payment_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/add_to_cart_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/apply_coupon_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/calculate_shipping_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/create_order_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/remove_coupon_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/return_order_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/models/update_cart_item_request.dart';
// import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_model.dart';
// import 'package:flutter_enterprise_boilerplate/features/products/data/models/product_review_model.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/address_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/features/auth/data/api/auth_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/config_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/deeplink_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/features/order/data/api/order_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/features/payments/data/api/payments_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/features/products/data/api/product_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/endpoints/upload_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/features/user/data/api/user_endpoints.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/response/deep_link_validation_response.dart';
// import 'package:injectable/injectable.dart';
// import 'package:retrofit/dio.dart';
// import 'package:retrofit/http.dart';

/// *** API CLIENT *** removed!!!
/// Split into separate api clients for each feature


// part 'api_client.g.dart';

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



// @singleton
// @RestApi()
// abstract class ApiClient {
//   // @factoryMethod
//   // factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

//   @factoryMethod
//   factory ApiClient(DioClient dioClient) {
//     // Get the underlying Dio instance from DioClient
//     return _ApiClient(dioClient.dio);
//   }

//   // ============================================================================
//   // Address Validation
//   // ============================================================================

//   @POST(AddressEndpoints.validate)
//   Future<HttpResponse<Map<String, dynamic>>> validateAddress(
//     @Body() Map<String, dynamic> body,
//   );

//   @GET(AddressEndpoints.autocomplete)
//   Future<HttpResponse<List<Map<String, dynamic>>>> addressAutocomplete(
//     @Query('query') String query,
//   );

//   // ============================================================================
//   // Deep Link Validation
//   // ============================================================================

//   @POST(DeeplinkEndpoints.validate)
//   Future<HttpResponse<DeepLinkValidationResponse>> validateDeepLink(
//     @Body() Map<String, dynamic> body,
//   );

//   // ============================================================================
//   // App Configuration
//   // ============================================================================

//   @GET(ConfigEndpoints.app)
//   Future<HttpResponse<Map<String, dynamic>>> getAppConfig();

//   @GET(ConfigEndpoints.features)
//   Future<HttpResponse<Map<String, dynamic>>> getFeatureFlags();

//   // ============================================================================
//   // Upload Methods (for files/images)
//   // ============================================================================

//   @POST(UploadEndpoints.image)
//   Future<HttpResponse<Map<String, dynamic>>> uploadImage(
//     @Body() FormData formData,
//   );

//   @POST(UploadEndpoints.file)
//   Future<HttpResponse<Map<String, dynamic>>> uploadFile(
//     @Body() FormData formData,
//   );

//   @DELETE(UploadEndpoints.deleteById)
//   Future<HttpResponse<void>> deleteFile(@Path('id') String fileId);
// }
