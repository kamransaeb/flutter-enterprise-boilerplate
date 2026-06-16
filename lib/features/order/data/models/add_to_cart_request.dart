import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_to_cart_request.freezed.dart';
part 'add_to_cart_request.g.dart';

@freezed
abstract class AddToCartRequestModel with _$AddToCartRequestModel {
  const factory AddToCartRequestModel({
    @JsonKey(name: 'product_id') required String productId,
    @JsonKey(name: 'variant_id') String? variantId,
    required int quantity,
  }) = _AddToCartRequestModel;

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddToCartRequestModelFromJson(json);
}
