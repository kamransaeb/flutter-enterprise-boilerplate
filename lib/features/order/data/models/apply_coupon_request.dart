import 'package:freezed_annotation/freezed_annotation.dart';

part 'apply_coupon_request.freezed.dart';
part 'apply_coupon_request.g.dart';

@freezed
abstract class ApplyCouponRequestModel with _$ApplyCouponRequestModel {
  const factory ApplyCouponRequestModel({
    @JsonKey(name: 'coupon_code') required String couponCode,
  }) = _ApplyCouponRequestModel;

  factory ApplyCouponRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ApplyCouponRequestModelFromJson(json);
}
