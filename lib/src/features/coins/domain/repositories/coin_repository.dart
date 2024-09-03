import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';

abstract class CoinRepository{
  Future<List<CoinEntity>> fetchCoinsApi(int pageNumber, int perPage);
  Future<CoinEntity> fetchSpecificCoin(String coinId);
  
}