import 'package:crypto_track/src/core/utils/logger.dart';
import 'package:crypto_track/src/features/wallet/data/datasources/wallet_data_source.dart';
import 'package:crypto_track/src/features/wallet/data/models/wallet_coin_model.dart';
import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/features/wallet/domain/repositories/firebase_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource _dataSource;

  WalletRepositoryImpl(this._dataSource); 
  @override
  Future<void> addCoinToPortfolio(WalletCoinEntity newCoin, String userId) async {
  try {
    await _dataSource.addCoinToWallet(userId, WalletCoinModel.fromEntity(newCoin));
  } catch (e) {
    logger.e(e);
    rethrow;
  }
}

  @override
  Future<List<WalletCoinModel>> fetchPortfolioData(String userId) async{
    try {
      return await _dataSource.fetchWalletData(userId); 
    } catch (e) {
     rethrow;
    }
  }
  
  @override
  Future<void> deleteCoinFromPortfolio(String coinId, String userId) async {
    try {
      await _dataSource.deleteFromWallet(userId, coinId);
    } catch (e) {
      rethrow;
    } 
  }
}
