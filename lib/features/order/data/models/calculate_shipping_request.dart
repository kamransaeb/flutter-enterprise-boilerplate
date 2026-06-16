import 'package:freezed_annotation/freezed_annotation.dart';

part 'calculate_shipping_request.freezed.dart';
part 'calculate_shipping_request.g.dart';

@freezed
abstract class CalculateShippingRequestModel with _$CalculateShippingRequestModel {
  const factory CalculateShippingRequestModel({
    @JsonKey(name: 'address_id') String? addressId,
    @JsonKey(name: 'shipping_address') Map<String, dynamic>? shippingAddress,
    @JsonKey(name: 'line_items') List<Map<String, dynamic>>? lineItems,
  }) = _CalculateShippingRequestModel;

  factory CalculateShippingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CalculateShippingRequestModelFromJson(json);
}
