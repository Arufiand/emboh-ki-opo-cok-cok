// lib/core/di/di.dart
import 'package:epms_flutter/data/datasources/remote/auth_remote_datasource.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive

import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../utils/hive_config.dart'; // Import HiveConfig untuk nama box
// import '../../presentation/blocs/network_status/network_status_cubit.dart'; // Masih dikomentari untuk saat ini

// --- Import untuk Fitur Konfigurasi API ---
import '../../data/datasources/local/app_config_local_datasource.dart';
import '../../data/repositories/app_config_repository_impl.dart';
import '../../domain/repositories/app_config_repository.dart';
import '../../domain/usecases/get_api_url.dart';
import '../../domain/usecases/save_api_url.dart';
import '../../presentation/blocs/ip_config/ip_config_bloc.dart';

// --- Import untuk Fitur Konfigurasi Auth ---
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_user.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> init() async {
  // External Dependencies
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => Connectivity());

  // Hive Boxes - Pastikan Box sudah dibuka di main.dart sebelum GetIt init() dipanggil
  sl.registerLazySingleton<Box<String>>(
      () => Hive.box<String>(HiveConfig.SETTINGS_BOX),
      instanceName: HiveConfig.SETTINGS_BOX);
  sl.registerLazySingleton<Box<String>>(
      () => Hive.box<String>(HiveConfig.AUTH_BOX), // Untuk nanti di fitur Login
      instanceName: HiveConfig.AUTH_BOX);

  // Core Utilities & Services
  sl.registerLazySingleton(() => DioClient(sl()));
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl(), sl()),
  );

// API CONFIG
  // Data Sources
  sl.registerLazySingleton<AppConfigLocalDataSource>(
    () => AppConfigLocalDataSourceImpl(
      settingsBox: sl<Box<String>>(instanceName: HiveConfig.SETTINGS_BOX),
    ),
  );
  // Repositories
  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(localDataSource: sl()),
  );
  // Use Cases
  sl.registerLazySingleton(() => GetApiUrl(sl()));
  sl.registerLazySingleton(() => SaveApiUrl(sl()));

  // Blocs
  sl.registerFactory(() => IpConfigBloc(
        getApiUrl: sl(),
        saveApiUrl: sl(),
      ));

  // Auth
  // Data Sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      authBox: sl<Box<String>>(instanceName: HiveConfig.AUTH_BOX),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioClient: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  // Blocs
  sl.registerFactory(() => AuthBloc(
        loginUser: sl(),
        authRepository: sl(),
      ));
}
