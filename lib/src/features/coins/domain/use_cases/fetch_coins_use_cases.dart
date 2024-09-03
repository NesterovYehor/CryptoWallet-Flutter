import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coins/domain/repositories/coin_repository.dart';

class FetchCoinsUseCase{
  final CoinRepository _repository;
  Future<List<CoinEntity>> call([int pageNumber = 1, int perPage = 25]) async{
    return await _repository.fetchCoinsApi(pageNumber, perPage);
  }
  FetchCoinsUseCase(this._repository);
}

class FetchSpecificCoinUseCases {
  final CoinRepository _repository;
  Future<CoinEntity> call(String coinId) async{
    return await _repository.fetchSpecificCoin(coinId);
  }
  FetchSpecificCoinUseCases(this._repository);
  

}