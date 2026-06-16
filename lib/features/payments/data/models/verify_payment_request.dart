import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_payment_request.freezed.dart';
part 'verify_payment_request.g.dart';

@freezed
abstract class VerifyPaymentRequestModel with _$VerifyPaymentRequestModel {
  const factory VerifyPaymentRequestModel({
    @JsonKey(name: 'payment_id') String? paymentId,
    @JsonKey(name: 'transaction_id') String? transactionId,
    @JsonKey(name: 'client_secret') String? clientSecret,
  }) = _VerifyPaymentRequestModel;

  factory VerifyPaymentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyPaymentRequestModelFromJson(json);
}
