import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/features/wallet/domain/repositories/firebase_repository.dart';

class FetchWalletUseCase{
  final WalletRepository _repository;
  Future<List<WalletCoinEntity>> call(String userId){
    return _repository.fetchPortfolioData(userId);
  }
  FetchWalletUseCase(this._repository);
}