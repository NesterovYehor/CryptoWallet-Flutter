import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/features/wallet/domain/repositories/firebase_repository.dart';

class AddCoinToWalletUseCase{
  final WalletRepository _repository;
  Future<void> call(WalletCoinEntity newCoin, String userId) async{
    return _repository.addCoinToPortfolio(newCoin, userId);
  }
  AddCoinToWalletUseCase(this._repository);
}