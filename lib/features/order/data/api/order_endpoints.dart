abstract class OrderEndpoints {
  static const String createOrder = '/orders';
  static const String getOrders = '/orders';
  static const String getOrderById = '/orders/{id}';
  static const String getOrderByNumber = '/orders/number/{number}';
  static const String cancelOrder = '/orders/{id}/cancel';
  static const String returnOrder = '/orders/{id}/return';
  static const String trackOrder = '/orders/{id}/track';
  static const String getOrderInvoice = '/orders/{id}/invoice';
  static const String reorder = '/orders/{id}/reorder';
  
  static const String getCart = '/cart';
  static const String addToCart = '/cart/items';
  static const String updateCartItem = '/cart/items/{id}';
  static const String removeFromCart = '/cart/items/{id}';
  static const String clearCart = '/cart/clear';
  static const String applyCoupon = '/cart/coupon';
  static const String removeCoupon = '/cart/coupon';
  
  static const String getShippingMethods = '/shipping/methods';
  static const String calculateShipping = '/shipping/calculate';
}