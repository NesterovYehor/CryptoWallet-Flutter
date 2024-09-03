import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';

abstract class WalletRepository{
  Future<List<WalletCoinEntity>> fetchPortfolioData(String userId);
  Future<void> addCoinToPortfolio(WalletCoinEntity portfolioCoin, String userId);
  Future<void> deleteCoinFromPortfolio(String coinId, String userId);
}