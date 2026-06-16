// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_enterprise_boilerplate/core/navigation/app_router.dart';
// import 'package:flutter_enterprise_boilerplate/infrastructure/di/injection.dart';
// import 'package:injectable/injectable.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../routes/app_router.dart';

// @singleton
// class DeepLinkService {
//   late final AppRouter _appRouter;

//   DeepLinkService(
//     this._appRouter
//     );

//   // Initialize deep link handling
//   Future<void> initialize() async {
//     await _initializeDynamicLinks();
//     await _initializeUniLinks();
//   }

//   // Firebase Dynamic Links
//   Future<void> _initializeDynamicLinks() async {
//     FirebaseDynamicLinks.instance.onLink.listen(
//       (dynamicLinkData) {
//         _handleDeepLink(dynamicLinkData.link);
//       },
//     ).onError((error) {
//       print('Dynamic Link error: $error');
//     });

//     // Check if app was opened from a dynamic link
//     final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
//     if (initialLink != null) {
//       await _handleDeepLink(initialLink.link);
//     }
//   }

//   // Universal/App Links
//   Future<void> _initializeUniLinks() async {
//     // App was opened with a link
//     getInitialLink().then((uri) {
//       if (uri != null) {
//         _handleDeepLink(uri);
//       }
//     });

//     // Listen for links while app is running
//     linkStream.listen((uri) {
//       if (uri != null) {
//         _handleDeepLink(uri);
//       }
//     });
//   }

//   // Handle deep links
//   Future<void> _handleDeepLink(Uri uri) async {
//     print('Handling deep link: $uri');
    
//     final path = uri.path;
//     final queryParameters = uri.queryParameters;
    
//     // Route based on path
//     switch (path) {
//       case '/product':
//         final productId = queryParameters['id'];
//         if (productId != null) {
//           await _appRouter.pushNamed('/products/$productId');
//         }
//         break;
        
//       case '/order':
//         final orderId = queryParameters['id'];
//         if (orderId != null) {
//           await _appRouter.pushNamed('/orders/$orderId');
//         }
//         break;
        
//       case '/promo':
//         final promoCode = queryParameters['code'];
//         if (promoCode != null) {
//           await _appRouter.pushNamed('/promo/$promoCode');
//         }
//         break;
        
//       case '/reset-password':
//         final token = queryParameters['token'];
//         if (token != null) {
//           await _appRouter.pushNamed('/reset-password/$token');
//         }
//         break;
        
//       case '/verify-email':
//         final token = queryParameters['token'];
//         if (token != null) {
//           await _appRouter.pushNamed('/verify-email/$token');
//         }
//         break;
        
//       default:
//         // Handle unknown paths
//         print('Unknown deep link path: $path');
//     }
//   }

//   // Create dynamic links
//   Future<String> createProductLink(String productId) async {
//     final parameters = DynamicLinkParameters(
//       uriPrefix: 'https://yourapp.page.link',
//       link: Uri.parse('https://yourapp.com/product?id=$productId'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.yourapp.android',
//         minimumVersion: 1,
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.yourapp.ios',
//         minimumVersion: '1.0',
//         appStoreId: '123456789',
//       ),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: 'Check out this product!',
//         description: 'Amazing product available now',
//         imageUrl: Uri.parse('https://yourapp.com/product.jpg'),
//       ),
//     );
    
//     final dynamicLink = await FirebaseDynamicLinks.instance.buildLink(parameters);
//     return dynamicLink.toString();
//   }

//   Future<String> createOrderLink(String orderId) async {
//     final parameters = DynamicLinkParameters(
//       uriPrefix: 'https://yourapp.page.link',
//       link: Uri.parse('https://yourapp.com/order?id=$orderId'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.yourapp.android',
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.yourapp.ios',
//       ),
//     );
    
//     final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//     return dynamicLink.shortUrl.toString();
//   }

//   Future<String> createPromoLink(String promoCode) async {
//     final parameters = DynamicLinkParameters(
//       uriPrefix: 'https://yourapp.page.link',
//       link: Uri.parse('https://yourapp.com/promo?code=$promoCode'),
//       androidParameters: const AndroidParameters(
//         packageName: 'com.yourapp.android',
//       ),
//       iosParameters: const IOSParameters(
//         bundleId: 'com.yourapp.ios',
//       ),
//     );
    
//     final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//     return dynamicLink.shortUrl.toString();
//   }

//   // Launch URLs in browser
//   Future<bool> launchUrl(String url, {LaunchMode mode = LaunchMode.platformDefault}) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       return await launchUrl(uri, mode: mode);
//     }
//     return false;
//   }

//   Future<bool> launchEmail(String email, {String? subject, String? body}) async {
//     final uri = Uri(
//       scheme: 'mailto',
//       path: email,
//       queryParameters: {
//         if (subject != null) 'subject': subject,
//         if (body != null) 'body': body,
//       },
//     );
    
//     if (await canLaunchUrl(uri)) {
//       return await launchUrl(uri);
//     }
//     return false;
//   }

//   Future<bool> launchPhone(String phoneNumber) async {
//     final uri = Uri(scheme: 'tel', path: phoneNumber);
//     if (await canLaunchUrl(uri)) {
//       return await launchUrl(uri);
//     }
//     return false;
//   }

//   Future<bool> launchSms(String phoneNumber, {String? body}) async {
//     final uri = Uri(
//       scheme: 'sms',
//       path: phoneNumber,
//       queryParameters: {
//         if (body != null) 'body': body,
//       },
//     );
    
//     if (await canLaunchUrl(uri)) {
//       return await launchUrl(uri);
//     }
//     return false;
//   }

//   Future<bool> launchWhatsApp(String phoneNumber, {String? text}) async {
//     final url = 'https://wa.me/$phoneNumber${text != null ? '?text=${Uri.encodeComponent(text)}' : ''}';
//     return await launchUrl(url);
//   }

//   // Share content
//   Future<void> shareProduct(String productId, String productName) async {
//     final link = await createProductLink(productId);
//     final text = 'Check out $productName: $link';
    
//     // Use share_plus or similar package for sharing
//     // await Share.share(text);
//   }

//   // Handle app scheme URLs
//   Future<bool> handleCustomScheme(String scheme, String host, Map<String, String>? params) async {
//     switch (host) {
//       case 'product':
//         final productId = params?['id'];
//         if (productId != null) {
//           await _appRouter.pushNamed('/products/$productId');
//           return true;
//         }
//         break;
        
//       case 'open':
//         final screen = params?['screen'];
//         if (screen != null) {
//           await _openScreen(screen, params);
//           return true;
//         }
//         break;
//     }
    
//     return false;
//   }

//   Future<void> _openScreen(String screen, Map<String, String>? params) async {
//     switch (screen) {
//       case 'home':
//         await _appRouter.pushNamed('/dashboard');
//         break;
        
//       case 'profile':
//         await _appRouter.pushNamed('/profile');
//         break;
        
//       case 'settings':
//         await _appRouter.pushNamed('/settings');
//         break;
        
//       case 'cart':
//         await _appRouter.pushNamed('/cart');
//         break;
//     }
//   }

//   // Analytics for deep links
//   void logDeepLinkEvent(Uri uri, {String? source}) {
//     // Log to analytics
//     print('Deep link opened: $uri from $source');
    
//     // You can integrate with Firebase Analytics or your analytics service
//     // FirebaseAnalytics.instance.logEvent(
//     //   name: 'deep_link_opened',
//     //   parameters: {
//     //     'url': uri.toString(),
//     //     'source': source,
//     //   },
//     // );
//   }

//   // Check if URL can be handled by app
//   bool canHandleUrl(String url) {
//     final uri = Uri.parse(url);
//     return uri.host == 'yourapp.com' || uri.scheme == 'yourapp';
//   }

//   // Get app store URL
//   String getAppStoreUrl() {
//     return 'https://apps.apple.com/app/id123456789';
//   }

//   // Get play store URL
//   String getPlayStoreUrl() {
//     return 'https://play.google.com/store/apps/details?id=com.yourapp.android';
//   }

//   // Get web app URL
//   String getWebAppUrl() {
//     return 'https://yourapp.com';
//   }
// }