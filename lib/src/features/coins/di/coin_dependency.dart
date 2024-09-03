import 'package:crypto_track/src/features/coins/data/data_sources/coin_remote_datasource.dart';
import 'package:crypto_track/src/features/coins/data/repository_implementation/coin_repository_impl.dart';
import 'package:crypto_track/src/features/coins/domain/repositories/coin_repository.dart';
import 'package:crypto_track/src/features/coins/domain/use_cases/fetch_coins_use_cases.dart';
import 'package:crypto_track/src/features/coins/presentation/state/bloc/coins_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../configs /injector/injector.dart';

class CoinDependency {
  final getIt = GetIt.instance;

  void setupDependencies() {
    // Register Bloc
    getIt.registerLazySingleton<CoinsBloc>(() => CoinsBloc(
        getIt<FetchCoinsUseCase>(), getIt<FetchSpecificCoinUseCases>()));

    getIt.registerLazySingleton<FetchSpecificCoinUseCases>(
        () => FetchSpecificCoinUseCases(getIt<CoinRepository>()));

    getIt.registerLazySingleton<FetchCoinsUseCase>(
        () => FetchCoinsUseCase(getIt<CoinRepository>()));

    // Register Repository
    getIt.registerLazySingleton<CoinRepository>(
        () => CoinRepositoryImpl(getIt<CoinRemoteDataSource>()));

    // Register Data Source
    getIt.registerLazySingleton<CoinRemoteDataSource>(
        () => CoinRemoteDataSourceImpl(getIt<ApiHelper>()));
  }
}
