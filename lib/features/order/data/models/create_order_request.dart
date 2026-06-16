import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_order_request.freezed.dart';
part 'create_order_request.g.dart';

@freezed
abstract class CreateOrderRequestModel with _$CreateOrderRequestModel {
  const factory CreateOrderRequestModel({
    @JsonKey(name: 'shipping_address_id') String? shippingAddressId,
    @JsonKey(name: 'billing_address_id') String? billingAddressId,
    @JsonKey(name: 'payment_method_id') String? paymentMethodId,
    String? notes,
    @JsonKey(name: 'coupon_code') String? couponCode,
    @JsonKey(name: 'line_items') required List<Map<String, dynamic>> lineItems,
  }) = _CreateOrderRequestModel;

  factory CreateOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderRequestModelFromJson(json);
}