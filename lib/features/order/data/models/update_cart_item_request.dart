import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_cart_item_request.freezed.dart';
part 'update_cart_item_request.g.dart';

@freezed
abstract class UpdateCartItemRequestModel with _$UpdateCartItemRequestModel {
  const factory UpdateCartItemRequestModel({
    required String id,
    required int quantity,
  }) = _UpdateCartItemRequestModel;

  factory UpdateCartItemRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateCartItemRequestModelFromJson(json);
}
