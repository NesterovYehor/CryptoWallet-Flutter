import 'package:crypto_track/src/features/market/data/models/market_model.dart';

abstract class MarketRepository{
  Future<MarketModel> fetchMarketApi();
}