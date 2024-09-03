import 'package:crypto_track/src/features/wallet/domain/repositories/firebase_repository.dart';

class DeleteCoinFromWalletUseCase{
  final WalletRepository _repository;
  Future<void> call(String coinId, String userId){
    return _repository.deleteCoinFromPortfolio(coinId, userId);
  }
  DeleteCoinFromWalletUseCase(this._repository);
}