import 'package:crypto_track/src/features/market/data/models/market_model.dart';
import 'package:crypto_track/src/features/market/domain/repositories/market_repository.dart';

class FetchMarketDataUseCase{
  final MarketRepository repository;
  Future<MarketModel> call(){
    return repository.fetchMarketApi();
  } 
  FetchMarketDataUseCase({required this.repository});
}