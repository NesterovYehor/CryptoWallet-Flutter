import 'package:crypto_track/src/core/cache/hive_local_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'injector.dart';


final getIt = GetIt.I;

void configureDependencies() {
  // Register Dio first since it's needed by ApiHelper
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register ApiHelper next, which depends on Dio
  getIt.registerLazySingleton<ApiHelper>(() => ApiHelper(getIt<Dio>()));

  getIt.registerLazySingleton(
    () => AppRouteConf(),
  );

  getIt.registerLazySingleton<ThemeBloc>(() => ThemeBloc());
  getIt.registerLazySingleton<AddCoinFormBloc>(() => AddCoinFormBloc());

  // Register Local Storage next
  getIt.registerLazySingleton<HiveLocalStorage>(() => HiveLocalStorage());
  getIt.registerLazySingleton<SecureLocalStorage>(() => const SecureLocalStorage(FlutterSecureStorage()));

  // Setup other dependencies
  AuthDependency().setupDependencies();

  CoinDependency().setupDependencies();

  MarketDependency().setupDependencies();

  WalletDependency().setupDependencies();
}