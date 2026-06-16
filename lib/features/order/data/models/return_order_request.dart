import 'package:freezed_annotation/freezed_annotation.dart';

part 'return_order_request.freezed.dart';
part 'return_order_request.g.dart';

@freezed
abstract class ReturnOrderRequestModel with _$ReturnOrderRequestModel {
  const factory ReturnOrderRequestModel({
    String? reason,
    @JsonKey(name: 'item_ids') List<String>? itemIds,
  }) = _ReturnOrderRequestModel;

  factory ReturnOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReturnOrderRequestModelFromJson(json);
}
