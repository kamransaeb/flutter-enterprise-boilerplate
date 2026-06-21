import 'package:flutter_enterprise_boilerplate/features/payments/data/api/payments_endpoints.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/initiate_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/refund_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/features/payments/data/models/verify_payment_request.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'payments_api_client.g.dart';

@singleton
@RestApi()
abstract class PaymentsApiClient {

  @factoryMethod
  factory PaymentsApiClient(DioClient dioClient) {
    return _PaymentsApiClient(dioClient.dio);
  }

  // ============================================================================
  // Payment Endpoints
  // ============================================================================

  @POST(PaymentEndpoints.initiatePayment)
  Future<HttpResponse<Map<String, dynamic>>> initiatePayment({
    @Body() required InitiatePaymentRequestModel initiatePaymentRequestModel,
  });

  @POST(PaymentEndpoints.verifyPayment)
  Future<HttpResponse<Map<String, dynamic>>> verifyPayment({
    @Body() required VerifyPaymentRequestModel verifyPaymentRequestModel,
  });

  @GET(PaymentEndpoints.getPaymentStatus)
  Future<HttpResponse<Map<String, dynamic>>> getPaymentStatus({
    @Path('id') required String paymentId,
  });

  @POST(PaymentEndpoints.refundPayment)
  Future<HttpResponse<Map<String, dynamic>>> refundPayment({
    @Path('id') required String paymentId,
    @Body() required RefundPaymentRequestModel refundPaymentRequestModel,
  });

  /// Payment gateway methods (distinct from [getPaymentMethods] on user profile).
  @GET(PaymentEndpoints.getPaymentMethods)
  Future<HttpResponse<List<Map<String, dynamic>>>>
      getPaymentsGatewayMethods();

}