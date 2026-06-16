import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@singleton
class RemoteConfigService {
  late FirebaseRemoteConfig _remoteConfig;
  final AppConfig _appConfig;
  final Map<String, dynamic> _localCache = {};
  bool _isInitialized = false;
  final _configSubject = BehaviorSubject<Map<String, dynamic>>();

  RemoteConfigService(this._appConfig);

  Map<String, dynamic> _defaultValues = {
    // Feature flags
    'enable_new_onboarding': false,
    'enable_biometric_auth': true,
    'enable_social_login': true,
    'enable_product_reviews': true,
    'enable_wishlist': true,
    'enable_push_notifications': true,
    'enable_analytics': true,
    'enable_crashlytics': true,
    
    // Maintenance flags
    'maintenance_mode': false,
    'maintenance_message': 'We are currently performing scheduled maintenance.',
    'maintenance_end_time': '',
    
    // App versions
    'minimum_app_version': '1.0.0',
    'latest_app_version': '1.0.0',
    'force_update': false,
    'update_message': 'A new version is available. Please update to continue.',
    
    // API configuration
    'api_timeout': 30000,
    'api_retry_count': 3,
    'api_cache_duration': 300, // seconds
    
    // UI configuration
    'enable_dark_mode': true,
    'default_theme': 'light',
    'primary_color': '#6200EE',
    'accent_color': '#03DAC6',
    
    // Payment configuration
    'enable_cod': true,
    'enable_online_payment': true,
    'minimum_order_amount': 100,
    'maximum_order_amount': 100000,
    'free_shipping_threshold': 500,
    
    // Promotions
    'enable_promo_codes': true,
    'default_discount_percentage': 0,
    'festive_offer_active': false,
    'festive_offer_message': '',
    
    // Rate limiting
    'max_login_attempts': 5,
    'login_lockout_duration': 900, // seconds
    'otp_resend_cooldown': 60, // seconds
    
    // Cache configuration
    'cache_products_duration': 3600, // seconds
    'cache_user_profile_duration': 1800, // seconds
    
    // Third-party services
    'enable_google_maps': true,
    'enable_facebook_login': true,
    'enable_google_login': true,
    'enable_apple_login': true,
    
    // Experiment flags (A/B testing)
    'experiment_checkout_flow': 'control',
    'experiment_home_layout': 'default',
    'experiment_product_card': 'standard',
  };

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  Future<void> setDefaults(Map<String, dynamic> defaults) async {
    await _remoteConfig.setDefaults(defaults);
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  Map<String, dynamic> getAll() {
    return _remoteConfig.getAll();
  }

  bool isInitialized() {
    return _isInitialized;
  }

  bool isFeatureEnabled(String key) {
    return _remoteConfig.getBool(key);
  }
}