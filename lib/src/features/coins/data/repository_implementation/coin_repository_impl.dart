import 'package:crypto_track/src/features/coins/data/data_sources/coin_remote_datasource.dart';
import 'package:crypto_track/src/features/coins/data/models/coin_model.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coins/domain/repositories/coin_repository.dart';

class CoinRepositoryImpl implements CoinRepository{
  final CoinRemoteDataSource _dataSource;

  CoinRepositoryImpl(this._dataSource);
  @override
  Future<List<CoinModel>> fetchCoinsApi(int pageNumber, int perPage) async{
    try {
      return await _dataSource.fetchCoins(pageNumber, perPage);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CoinEntity> fetchSpecificCoin(String coinId)async {
    try {
      return await _dataSource.fetchSpecificCoin(coinId);
    } catch (e) {
     rethrow; 
    }
  }
}




