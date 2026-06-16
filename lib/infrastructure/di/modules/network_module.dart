import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_enterprise_boilerplate/infrastructure/network/client/dio_client.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

/// Third-party clients used across the app (Dio, connectivity, device info).
@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(DioClient client) => client.dio;

  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  InternetConnection get internetConnection => InternetConnection();

  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();
}
