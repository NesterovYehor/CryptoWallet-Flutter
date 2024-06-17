import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/market_model.dart';

abstract class ApiRepository{
  Future<List<CoinModel>> fetchCoinsApi();
  Future<MarketModel> fetchMarketApi();
}