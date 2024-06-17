import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/market_model.dart';
import 'package:crypto_track/domain/interfaces/api_repository.dart';

class FetchAllCoins{
  final ApiRepository repository;
  Future<List<CoinModel>> call(){
    return repository.fetchCoinsApi();
  }
  FetchAllCoins({required this.repository});
}

class FetchMarketData{
  final ApiRepository repository;
  Future<MarketModel> call(){
    return repository.fetchMarketApi();
  } 
  FetchMarketData({required this.repository});
}