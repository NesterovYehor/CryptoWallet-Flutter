import 'package:crypto_track/src/features/wallet/domain/use_cases/add_coin_to_wallet_usecase.dart';
import 'package:crypto_track/src/features/wallet/domain/use_cases/delete_coin_usecase.dart';
import 'package:crypto_track/src/features/wallet/domain/use_cases/fetch_wallet_coins_usecase.dart';
import 'package:get_it/get_it.dart';
import '../data/datasources/wallet_data_source.dart';
import '../data/repository_implementation/wallet_repository_impl.dart';
import '../domain/repositories/firebase_repository.dart';
import '../presentation/bloc/wallet_bloc/wallet_bloc.dart';


class WalletDependency {
  final getIt = GetIt.instance;

  void setupDependencies() {
    // Register WalletRemoteDataSource as a singleton or lazy singleton
    getIt.registerLazySingleton<WalletRemoteDataSource>(
      () => WalletRemoteDataSourceImpl(),
    );

    // Register WalletRepository and inject the WalletRemoteDataSource dependency
    getIt.registerLazySingleton<WalletRepository>(
      () => WalletRepositoryImpl(getIt<WalletRemoteDataSource>()),
    );

    // Register Use Cases and inject the WalletRepository dependency
    getIt.registerLazySingleton<FetchWalletUseCase>(
      () => FetchWalletUseCase(getIt<WalletRepository>()),
    );
    getIt.registerLazySingleton<AddCoinToWalletUseCase>(
      () => AddCoinToWalletUseCase(getIt<WalletRepository>()),
    );
     getIt.registerLazySingleton<DeleteCoinFromWalletUseCase>(
      () => DeleteCoinFromWalletUseCase(getIt<WalletRepository>()),
    );

    // Register WalletBloc and inject the FetchWalletUseCase dependency
    getIt.registerFactory<WalletBloc>(
      () => WalletBloc(getIt<FetchWalletUseCase>(), getIt<AddCoinToWalletUseCase>(), getIt<DeleteCoinFromWalletUseCase>()),
    );
  }
}