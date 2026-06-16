import 'package:freezed_annotation/freezed_annotation.dart';

part 'refund_payment_request.freezed.dart';
part 'refund_payment_request.g.dart';

@freezed
abstract class RefundPaymentRequestModel with _$RefundPaymentRequestModel {
  const factory RefundPaymentRequestModel({
    double? amount,
    String? reason,
  }) = _RefundPaymentRequestModel;

  factory RefundPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefundPaymentRequestModelFromJson(json);
}
