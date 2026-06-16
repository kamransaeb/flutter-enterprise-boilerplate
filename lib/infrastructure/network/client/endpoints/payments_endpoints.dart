abstract class PaymentEndpoints {
  static const String initiatePayment = '/payments/initiate';
  static const String verifyPayment = '/payments/verify';
  static const String getPaymentStatus = '/payments/{id}/status';
  static const String refundPayment = '/payments/refund';
  static const String getPaymentMethods = '/payments/methods';
}