abstract class UserEndpoints {
  static const String getProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  static const String updateProfilePicture = '/user/profile-picture';
  static const String changePassword = '/user/change-password';
  static const String deleteAccount = '/user/delete';

  static const String getNotifications = '/user/notifications';
  static const String getNotification = '/user/notifications/{id}';
  static const String readNotification = '/user/notifications/{id}/read';
  static const String unreadNotification = '/user/notifications/{id}/unread';
  static const String deleteNotification = '/user/notifications/{id}/delete';
  static const String deleteAllNotifications = '/user/notifications/delete-all';
  static const String readAllNotifications = '/user/notifications/read-all';
  static const String unreadAllNotifications = '/user/notifications/unread-all';

  static const String getAddresses = '/user/addresses';
  static const String addAddress = '/user/addresses';
  static const String updateAddress = '/user/addresses/{id}';
  static const String deleteAddress = '/user/addresses/{id}';
  
  static const String getPaymentMethods = '/user/payment-methods';
  static const String addPaymentMethod = '/user/payment-methods';
  static const String deletePaymentMethod = '/user/payment-methods/{id}';
  
  static const String getWishlist = '/user/wishlist';
  static const String addToWishlist = '/user/wishlist';
  static const String removeFromWishlist = '/user/wishlist/{id}';
}