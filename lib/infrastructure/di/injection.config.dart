// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app/app_bloc_observer.dart' as _i492;
import '../../app/app_config.dart' as _i861;
import '../../app/app_initializer.dart' as _i750;
import '../../core/bloc/connectivity/connectivity_bloc.dart' as _i1027;
import '../../core/bloc/theme/theme_bloc.dart' as _i339;
import '../../core/navigation/app_router.dart' as _i400;
import '../../core/utils/helpers/network_helper.dart' as _i675;
import '../../features/auth/data/api/auth_api_client.dart' as _i541;
import '../../features/auth/data/datasources/auth_local_data_source.dart'
    as _i852;
import '../../features/auth/data/datasources/auth_local_data_source_impl.dart'
    as _i301;
import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart'
    as _i123;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/forgot_password_usecase.dart'
    as _i560;
import '../../features/auth/domain/usecases/get_current_user_usecase.dart'
    as _i17;
import '../../features/auth/domain/usecases/login_usecase.dart' as _i188;
import '../../features/auth/domain/usecases/logout_usecase.dart' as _i48;
import '../../features/auth/domain/usecases/refresh_token_usecase.dart'
    as _i157;
import '../../features/auth/domain/usecases/register_usecase.dart' as _i941;
import '../../features/auth/domain/usecases/resend_verification_email_usecase.dart'
    as _i698;
import '../../features/auth/domain/usecases/reset_password_usecase.dart'
    as _i474;
import '../../features/auth/domain/usecases/social_login_usecase.dart' as _i449;
import '../../features/auth/domain/usecases/verify_email_usecase.dart' as _i30;
import '../../features/auth/presentation/bloc/auth_bloc.dart' as _i797;
import '../../features/products/data/api/product_api_client.dart' as _i865;
import '../../features/products/data/datasources/product_local_data_source.dart'
    as _i823;
import '../../features/products/data/datasources/product_local_data_source_impl.dart'
    as _i27;
import '../../features/products/data/datasources/product_remote_data_source.dart'
    as _i166;
import '../../features/products/data/datasources/product_remote_data_source_impl.dart'
    as _i818;
import '../../features/products/data/repositories/product_repository_impl.dart'
    as _i764;
import '../../features/products/domain/repositories/product_repository.dart'
    as _i963;
import '../../features/products/domain/usecases/get_products_usecase.dart'
    as _i15;
import '../../features/products/domain/usecases/search_product_usecase.dart'
    as _i343;
import '../../features/products/domain/usecases/toggle_favorite_usecase.dart'
    as _i270;
import '../../features/products/presentation/bloc/products_bloc.dart' as _i975;
import '../cache/cache_manager.dart' as _i326;
import '../cache/cache_manager_impl.dart' as _i536;
import '../network/client/api_client.dart' as _i211;
import '../network/client/dio_client.dart' as _i870;
import '../network/client/interceptors/cache_interceptor.dart' as _i644;
import '../network/client/interceptors/error_interceptor.dart' as _i137;
import '../network/client/interceptors/header_interceptor.dart' as _i831;
import '../network/transformers/json_transformer.dart' as _i27;
import '../services/biometric_service.dart' as _i374;
import '../services/connectivity_service.dart' as _i47;
import '../services/environment_service.dart' as _i488;
import '../services/firebase/firebase_service.dart' as _i376;
import '../services/location_service.dart' as _i669;
import '../services/logger_service.dart' as _i141;
import '../services/navigation_service.dart' as _i31;
import '../services/notification_service.dart' as _i941;
import '../services/remote_config_service.dart' as _i858;
import '../services/sentry_service.dart' as _i343;
import '../storage/local_storage.dart' as _i329;
import 'modules/network_module.dart' as _i851;
import 'modules/storage_module.dart' as _i148;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final storageModule = _$StorageModule();
  final networkModule = _$NetworkModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => storageModule.sharedPreferences,
    preResolve: true,
  );
  gh.singleton<_i750.AppInitializer>(() => _i750.AppInitializer());
  gh.singleton<_i400.AppRouter>(() => _i400.AppRouter());
  gh.singleton<_i558.FlutterSecureStorage>(
    () => storageModule.flutterSecureStorage,
  );
  gh.singleton<_i27.JsonTransformer>(() => _i27.JsonTransformer());
  gh.singleton<_i374.BiometricService>(() => _i374.BiometricService());
  gh.singleton<_i47.ConnectivityService>(() => _i47.ConnectivityService());
  gh.singleton<_i669.LocationService>(() => _i669.LocationService());
  gh.singleton<_i141.LoggerService>(() => _i141.LoggerService());
  gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity);
  gh.lazySingleton<_i161.InternetConnection>(
    () => networkModule.internetConnection,
  );
  gh.lazySingleton<_i833.DeviceInfoPlugin>(
    () => networkModule.deviceInfoPlugin,
  );
  gh.lazySingleton<_i137.ErrorInterceptor>(() => _i137.ErrorInterceptor());
  gh.singleton<String>(
    () => storageModule.onboardingCompletedKey,
    instanceName: 'onboarding_completed_key',
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.cacheBox,
    instanceName: 'cache_box',
    preResolve: true,
  );
  gh.singleton<String>(
    () => storageModule.refreshTokenKey,
    instanceName: 'refresh_token_key',
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.ordersBox,
    instanceName: 'orders_box',
    preResolve: true,
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.userBox,
    instanceName: 'user_box',
    preResolve: true,
  );
  gh.singleton<String>(
    () => storageModule.localeKey,
    instanceName: 'locale_key',
  );
  gh.singleton<String>(
    () => storageModule.themeModeKey,
    instanceName: 'theme_mode_key',
  );
  gh.singleton<_i329.LocalStorage>(
    () => storageModule.sharedPrefsStorage(
      gh<_i460.SharedPreferences>(),
      gh<_i861.AppConfig>(),
    ),
    instanceName: 'shared_prefs',
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.notificationsBox,
    instanceName: 'notifications_box',
    preResolve: true,
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.settingsBox,
    instanceName: 'settings_box',
    preResolve: true,
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.apiCacheBox,
    instanceName: 'api_cache_box',
    preResolve: true,
  );
  gh.singleton<String>(
    () => storageModule.authTokenKey,
    instanceName: 'auth_token_key',
  );
  gh.singleton<_i1027.ConnectivityBloc>(
    () => _i1027.ConnectivityBloc(
      connectivityService: gh<_i47.ConnectivityService>(),
    ),
  );
  gh.singleton<_i488.EnvironmentService>(
    () => _i488.EnvironmentService(gh<_i861.AppConfig>()),
  );
  gh.singleton<_i858.RemoteConfigService>(
    () => _i858.RemoteConfigService(gh<_i861.AppConfig>()),
  );
  gh.lazySingleton<_i831.HeaderInterceptor>(
    () => _i831.HeaderInterceptor(
      gh<_i861.AppConfig>(),
      gh<_i833.DeviceInfoPlugin>(),
    ),
  );
  gh.singleton<_i870.DioClient>(
    () => _i870.DioClient(gh<_i861.AppConfig>(), gh<_i833.DeviceInfoPlugin>()),
  );
  gh.singleton<String>(
    () => storageModule.userIdKey,
    instanceName: 'user_id_key',
  );
  await gh.singletonAsync<_i979.Box<dynamic>>(
    () => storageModule.productsBox,
    instanceName: 'products_box',
    preResolve: true,
  );
  gh.lazySingleton<_i361.Dio>(() => networkModule.dio(gh<_i870.DioClient>()));
  gh.singleton<_i329.LocalStorage>(
    () => storageModule.secureStorage(
      gh<_i558.FlutterSecureStorage>(),
      gh<_i861.AppConfig>(),
    ),
    instanceName: 'secure_storage',
  );
  gh.singleton<_i329.LocalStorage>(
    () => storageModule.hiveStorage(
      gh<_i488.EnvironmentService>(),
      gh<_i979.Box<dynamic>>(instanceName: 'settings_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'user_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'cache_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'products_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'orders_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'notifications_box'),
      gh<_i979.Box<dynamic>>(instanceName: 'api_cache_box'),
    ),
    instanceName: 'hive_storage',
  );
  gh.singleton<_i343.SentryService>(
    () => _i343.SentryService(gh<_i488.EnvironmentService>()),
  );
  gh.singleton<_i675.NetworkHelper>(
    () => _i675.NetworkHelper(
      gh<_i895.Connectivity>(),
      gh<_i161.InternetConnection>(),
    ),
  );
  gh.singleton<_i31.NavigationService>(
    () => _i31.NavigationService(gh<_i400.AppRouter>()),
  );
  gh.singleton<_i541.AuthApiClient>(
    () => _i541.AuthApiClient(gh<_i870.DioClient>()),
  );
  gh.singleton<_i865.ProductApiClient>(
    () => _i865.ProductApiClient(gh<_i870.DioClient>()),
  );
  gh.singleton<_i211.ApiClient>(() => _i211.ApiClient(gh<_i870.DioClient>()));
  gh.singleton<_i492.AppBlocObserver>(
    () => _i492.AppBlocObserver(appConfig: gh<_i861.AppConfig>()),
  );
  gh.lazySingleton<_i823.ProductLocalDataSource>(
    () => _i27.ProductLocalDataSourceImpl(
      hiveStorage: gh<_i329.LocalStorage>(instanceName: 'hive_storage'),
    ),
  );
  gh.singleton<_i339.ThemeBloc>(
    () => _i339.ThemeBloc(
      localStorage: gh<_i329.LocalStorage>(instanceName: 'hive_storage'),
    ),
  );
  gh.singleton<_i376.FirebaseService>(
    () => _i376.FirebaseService(
      gh<_i861.AppConfig>(),
      gh<_i488.EnvironmentService>(),
    ),
  );
  gh.lazySingleton<_i852.AuthLocalDataSource>(
    () => _i301.AuthLocalDataSourceImpl(
      secureStorage: gh<_i329.LocalStorage>(instanceName: 'secure_storage'),
      sharedPrefsStorage: gh<_i329.LocalStorage>(instanceName: 'shared_prefs'),
      hiveStorage: gh<_i329.LocalStorage>(instanceName: 'hive_storage'),
    ),
  );
  gh.singleton<_i941.NotificationService>(
    () => _i941.NotificationService(
      gh<_i488.EnvironmentService>(),
      gh<_i329.LocalStorage>(instanceName: 'secure_storage'),
    ),
  );
  gh.lazySingleton<_i107.AuthRemoteDataSource>(
    () => _i123.AuthRemoteDataSourceImpl(gh<_i211.ApiClient>()),
  );
  gh.lazySingleton<_i326.CacheManager>(
    () => _i536.CacheManagerImpl(
      gh<_i329.LocalStorage>(instanceName: 'hive_storage'),
      gh<_i861.AppConfig>(),
    ),
  );
  gh.lazySingleton<_i166.ProductRemoteDataSource>(
    () => _i818.ProductRemoteDataSourceImpl(gh<_i211.ApiClient>()),
  );
  gh.lazySingleton<_i787.AuthRepository>(
    () => _i153.AuthRepositoryImpl(
      gh<_i107.AuthRemoteDataSource>(),
      gh<_i852.AuthLocalDataSource>(),
    ),
  );
  gh.factory<_i560.ForgotPasswordUseCase>(
    () => _i560.ForgotPasswordUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i17.GetCurrentUserUseCase>(
    () => _i17.GetCurrentUserUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i188.LoginUseCase>(
    () => _i188.LoginUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i48.LogoutUseCase>(
    () => _i48.LogoutUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i157.RefreshTokenUseCase>(
    () => _i157.RefreshTokenUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i941.RegisterUseCase>(
    () => _i941.RegisterUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i698.ResendVerificationEmailUseCase>(
    () => _i698.ResendVerificationEmailUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i474.ResetPasswordUseCase>(
    () => _i474.ResetPasswordUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i449.ResetPasswordUseCase>(
    () => _i449.ResetPasswordUseCase(gh<_i787.AuthRepository>()),
  );
  gh.factory<_i30.VerifyEmailUseCase>(
    () => _i30.VerifyEmailUseCase(gh<_i787.AuthRepository>()),
  );
  gh.lazySingleton<_i963.ProductRepository>(
    () => _i764.ProductRepositoryImpl(
      gh<_i166.ProductRemoteDataSource>(),
      gh<_i823.ProductLocalDataSource>(),
    ),
  );
  gh.factory<_i15.GetProductsUseCase>(
    () => _i15.GetProductsUseCase(gh<_i963.ProductRepository>()),
  );
  gh.factory<_i343.SearchProductsUseCase>(
    () => _i343.SearchProductsUseCase(gh<_i963.ProductRepository>()),
  );
  gh.factory<_i270.ToggleFavoriteUseCase>(
    () => _i270.ToggleFavoriteUseCase(gh<_i963.ProductRepository>()),
  );
  gh.factory<_i975.ProductsBloc>(
    () => _i975.ProductsBloc(
      gh<_i15.GetProductsUseCase>(),
      gh<_i343.SearchProductsUseCase>(),
      gh<_i270.ToggleFavoriteUseCase>(),
    ),
  );
  gh.lazySingleton<_i644.CacheInterceptor>(
    () => _i644.CacheInterceptor(cacheManager: gh<_i326.CacheManager>()),
  );
  gh.singleton<_i797.AuthBloc>(
    () => _i797.AuthBloc(
      loginUseCase: gh<_i188.LoginUseCase>(),
      logoutUseCase: gh<_i48.LogoutUseCase>(),
      registerUseCase: gh<_i941.RegisterUseCase>(),
      authRepository: gh<_i787.AuthRepository>(),
    ),
  );
  return getIt;
}

class _$StorageModule extends _i148.StorageModule {}

class _$NetworkModule extends _i851.NetworkModule {}
