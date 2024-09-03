import 'package:get_it/get_it.dart';
import 'package:crypto_track/src/configs%20/injector/injector.dart';
import '../../../core/cache/hive_local_storage.dart';
import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repository_impl/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/use_cases/check_signin_status_usecase.dart';
import '../domain/use_cases/login_usecase.dart';
import '../domain/use_cases/logout_usecase.dart';
import '../domain/use_cases/register_usecase.dart';
import '../presentation/authentication_bloc/authentication_bloc.dart';

class AuthDependency {
  final getIt = GetIt.instance;

  void setupDependencies() {
    // Register Bloc
    getIt.registerFactory<AuthBloc>(
      () => AuthBloc(getIt<AuthLoginUseCase>(), getIt<AuthRegisterUseCase>(),
          getIt<AuthLogoutUseCase>(), getIt<AuthCheckSignInStatusUseCase>()),
    );

    // Register Use Cases
    getIt.registerLazySingleton<AuthLoginUseCase>(
        () => AuthLoginUseCase(getIt<AuthRepository>()));
    getIt.registerLazySingleton<AuthRegisterUseCase>(
        () => AuthRegisterUseCase(getIt<AuthRepository>()));
    getIt.registerLazySingleton<AuthLogoutUseCase>(
        () => AuthLogoutUseCase(getIt<AuthRepository>()));
    getIt.registerLazySingleton<AuthCheckSignInStatusUseCase>(
        () => AuthCheckSignInStatusUseCase(getIt<AuthRepository>()));

    // Register Repository
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<AuthLocalDataSource>(),
        getIt<SecureLocalStorage>(),
        getIt<HiveLocalStorage>()));

    // Register Data Source
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(),
    );
    getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
          getIt<SecureLocalStorage>(), getIt<HiveLocalStorage>()),
    );
  }
}
