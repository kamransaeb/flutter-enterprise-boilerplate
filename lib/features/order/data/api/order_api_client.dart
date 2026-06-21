import 'package:flutter_enterprise_boilerplate/features/order/data/api/order_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/add_to_cart_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/apply_coupon_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/calculate_shipping_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/create_order_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/remove_coupon_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/return_order_request.dart';
import 'package:flutter_enterprise_boilerplate/features/order/data/models/update_cart_item_request.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'order_api_client.g.dart';

@singleton
@RestApi()  
abstract class OrderApiClient {

  @factoryMethod
  factory OrderApiClient(DioClient dioClient) {
    return _OrderApiClient(dioClient.dio);
  }

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

}