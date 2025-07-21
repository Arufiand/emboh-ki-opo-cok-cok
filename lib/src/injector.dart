


import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:dio/dio.dart';
import 'package:epms_flutter/src/core/network/network_info.dart';
import 'package:epms_flutter/src/core/services/local_storage_service.dart';
import 'package:epms_flutter/src/core/network/dio_client.dart';
// import 'package:epms_flutter/src/core/usecases/usecase.dart'; // Base UseCase

final sl = GetIt.instance; // 'sl' stands for Service Locator

/// Initializes all the dependencies for the application.
/// This function should be called once at the start of the application (e.g., in main.dart).
Future<void> init() async {
  // -------------------------------------------------------------------------
  // Core
  // -------------------------------------------------------------------------

  // Register NetworkInfo
  // Checks for internet connectivity
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnection());

  // Register DioClient for network requests
  // This will be used by remote data sources
  sl.registerLazySingleton<DioClient>(() => DioClient(Dio()));

  // Register LocalStorageService (Hive)
  // Initializes Hive and registers the service
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageServiceImpl(Hive));
  await sl<LocalStorageService>().init(); // Initialize Hive storage

  // Register base UseCase (if you have a common abstract UseCase)
  // sl.registerLazySingleton<UseCase>(() => UseCase()); // Example if UseCase needs registration

  // -------------------------------------------------------------------------
  // Features
  // Register feature-specific dependencies here as they are developed.
  // Example for a hypothetical 'Auth' feature:
  //
  // Auth Feature
  // sl.registerFactory(() => AuthBloc(login: sl(), register: sl()));
  // sl.registerLazySingleton(() => LoginUseCase(sl()));
  // sl.registerLazySingleton(() => RegisterUseCase(sl()));
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  // sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  // sl.registerLazySingleton<AuthLocalDataSource>(() => AuthLocalDataSourceImpl(sl()));
  //
  // -------------------------------------------------------------------------
}
