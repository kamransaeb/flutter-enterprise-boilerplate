import 'package:flutter/foundation.dart';
import 'package:flutter_enterprise_boilerplate/app/app_config.dart';
import 'package:flutter_enterprise_boilerplate/core/utils/functions/app_logger.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/services/environment_service.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/hive_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/local_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/secure_storage.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/storage/shared_prefs_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// StorageModule is an Injectable module that cenralizes how all storage-related
/// dependencies are created and registered in GetIt.
/// DI wiring
@module
abstract class StorageModule {
  //============================================================================
  // Shared Preferences
  //============================================================================
  
  // @preResolve is an injectable annotation that changes how a Future<T> dependency
  // is registered in GetIt.
  // 1. During DI setup when initGetIt(getIt) or our configureInjection runs, 
  // injectable's generated code awaits that Future.
  // 2. It then registers the resolved value in GetIt, not the future.
  // 3. So when code later does getIt<SharedPreferences>(), it gets the 
  // already-loaded instance immediately, not a Future.
  @preResolve
  Future<SharedPreferences> get sharedPreferences => SharedPreferences.getInstance();

  @singleton
  @Named('shared_prefs')
  LocalStorage sharedPrefsStorage(
    //*** This is the already-loaded instance, not a Future. ***
    SharedPreferences prefs,
    AppConfig appConfig,
  ) => SharedPrefsStorage(
    prefs: prefs,
    enableLogging: appConfig.enableLogging,
  );

  //============================================================================
  // Secure Storage
  //============================================================================

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  @singleton
  @Named('secure_storage')
  LocalStorage secureStorage(
    FlutterSecureStorage storage,
    AppConfig appConfig,
  ) => SecureStorage(
    storage: storage,
    enableLogging: appConfig.enableLogging,
  );

  //============================================================================
  // HiveStorage instance (our wrapper)
  //============================================================================

 // *** What injectable is warning about is that it cannot find a registration
 // for the Future<Box> parameters.
 // The boxes themselves are provided as @preResolve async getters.
 // Injectable does generate registrations for them, but the static checker
 // still reports Future<Box> as "unregistered" when resolving LocalStorage.
 // Especially because the reported type is the abstract LocalStorage,
 // not HiveStorage.
 // Generated code still wires it.
 

 // to get rid of the warning, we need to align the types with the actual types.
 // *** Future<Box> - align with @preResolve
 // @preResolve registers the resolved Box, not the Future<Box>.
 
  @singleton
  @Named('hive_storage')
  LocalStorage hiveStorage(
    EnvironmentService env,
    @Named('settings_box') Box settingsBox,
    @Named('user_box') Box userBox,
    @Named('cache_box') Box cacheBox,
    @Named('products_box') Box productsBox,
    @Named('orders_box') Box ordersBox,
    @Named('notifications_box') Box notificationsBox,
    @Named('api_cache_box') Box apiCacheBox,
  ) => HiveStorage(
    env: env,
    settingsBox: settingsBox,
    userBox: userBox,
    cacheBox: cacheBox,
    productsBox: productsBox,
    ordersBox: ordersBox,
    notificationsBox: notificationsBox,
    apiCacheBox: apiCacheBox,
  );

 //============================================================================
  // Hive Boxes - These depend on Hive being initialized
  //============================================================================

  @Named('settings_box')
  @singleton
  @preResolve
  Future<Box> get settingsBox async {
    // Hive is already initialized by initializeHive
    return await Hive.openBox(
      'settings',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 50;
      },
    );
  }

  @Named('user_box')
  @singleton
  @preResolve
  Future<Box> get userBox async {
    return await Hive.openBox(
      'user',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 20;
      },
    );
  }

  @Named('cache_box')
  @singleton
  @preResolve
  Future<Box> get cacheBox async {
    return await Hive.openBox(
      'cache',
      compactionStrategy: (entries, deletedEntries) {
        // Auto-compact after 100 deleted entries
        return deletedEntries > 100;
      },
    );
  }

  @Named('products_box')
  @singleton
  @preResolve
  Future<Box> get productsBox async {
    return await Hive.openBox(
      'products',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 200;
      },
    );
  }

  @Named('orders_box')
  @singleton
  @preResolve
  Future<Box> get ordersBox async {
    return await Hive.openBox(
      'orders',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 150;
      },
    );
  }

  @Named('notifications_box')
  @singleton
  @preResolve
  Future<Box> get notificationsBox async {
    return await Hive.openBox(
      'notifications',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 100;
      },
    );
  }

  @Named('api_cache_box')
  @singleton
  @preResolve
  Future<Box> get apiCacheBox async {
    return await Hive.openBox(
      'api_cache',
      compactionStrategy: (entries, deletedEntries) {
        return deletedEntries > 100;
      },
    );
  }

  //============================================================================
  // Storage Keys & Constants
  //============================================================================
  @Named('auth_token_key')
  @singleton
  String get authTokenKey => 'auth_token';

  @Named('refresh_token_key')
  @singleton
  String get refreshTokenKey => 'refresh_token';

  @Named('user_id_key')
  @singleton
  String get userIdKey => 'user_id';

  @Named('theme_mode_key')
  @singleton
  String get themeModeKey => 'theme_mode';

  @Named('locale_key')
  @singleton
  String get localeKey => 'locale';

  @Named('onboarding_completed_key')
  @singleton
  String get onboardingCompletedKey => 'onboarding_completed';
}