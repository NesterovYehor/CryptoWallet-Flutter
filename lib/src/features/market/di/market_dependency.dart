import 'package:get_it/get_it.dart';
import '../../../configs /injector/injector.dart';
import '../data/data_sources/market_remote_datasource.dart';
import '../data/repository_impl/market_repository_impl.dart';
import '../domain/repositories/market_repository.dart';
import '../domain/use_cases/market_usecases.dart';
import '../presentation/bloc/market_bloc.dart';

class MarketDependency {
  final getIt = GetIt.instance;

  void setupDependencies() {
    // Register Bloc
    getIt.registerFactory<MarketBloc>(
        () => MarketBloc(getIt<FetchMarketDataUseCase>()));

    // Register Use Cases
    getIt.registerLazySingleton<FetchMarketDataUseCase>(
        () => FetchMarketDataUseCase(repository: getIt<MarketRepository>()));

    // Register Repository
    getIt.registerLazySingleton<MarketRepository>(
        () => MarketRepositoryImpl(getIt<MarketRemoteDataSource>()));

    // Register Data Source
    getIt.registerLazySingleton<MarketRemoteDataSource>(
        () => MarketRemoteDataSourceImpl(getIt<ApiHelper>()));
  }
}