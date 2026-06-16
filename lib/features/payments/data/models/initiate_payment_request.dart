import 'package:freezed_annotation/freezed_annotation.dart';

part 'initiate_payment_request.freezed.dart';
part 'initiate_payment_request.g.dart';

@freezed
abstract class InitiatePaymentRequestModel with _$InitiatePaymentRequestModel {
  const factory InitiatePaymentRequestModel({
    @JsonKey(name: 'order_id') required String orderId,
    @JsonKey(name: 'payment_method_id') required String paymentMethodId,
    @JsonKey(name: 'return_url') String? returnUrl,
    @JsonKey(name: 'cancel_url') String? cancelUrl,
  }) = _InitiatePaymentRequestModel;

  factory InitiatePaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InitiatePaymentRequestModelFromJson(json);
}
