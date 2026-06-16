import 'package:freezed_annotation/freezed_annotation.dart';

part 'remove_coupon_request.freezed.dart';
part 'remove_coupon_request.g.dart';

@freezed
abstract class RemoveCouponRequestModel with _$RemoveCouponRequestModel {
  const factory RemoveCouponRequestModel({
    @JsonKey(name: 'coupon_code') String? couponCode,
  }) = _RemoveCouponRequestModel;

  factory RemoveCouponRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RemoveCouponRequestModelFromJson(json);
}
