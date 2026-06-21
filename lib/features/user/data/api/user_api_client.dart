import 'dart:io';

import 'package:flutter_enterprise_boilerplate/features/auth/data/models/update_profile_request_model.dart';
import 'package:flutter_enterprise_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_enterprise_boilerplate/features/user/data/api/user_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api_client.g.dart';

@singleton
@RestApi()
abstract class UserApiClient {

  @factoryMethod
  factory UserApiClient(DioClient dioClient) {
    return _UserApiClient(dioClient.dio);
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

}