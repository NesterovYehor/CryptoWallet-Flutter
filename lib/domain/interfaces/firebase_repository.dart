import 'package:crypto_track/data/models/portfolio_coin_model.dart';

abstract class DbRepository{
  Stream<List<PortfolioCoinModel>> fetchPortfolioData(String userId);
  Future<void> addCoinToPortfolio(PortfolioCoinModel portfolioCoin, String userId);
  // Future<void> deleteCoinFromPortfolio(CoinModel coin, double amount);
}