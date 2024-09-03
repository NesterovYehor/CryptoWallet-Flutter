import 'package:crypto_track/src/features/market/data/data_sources/market_remote_datasource.dart';
import 'package:crypto_track/src/features/market/data/models/market_model.dart';
import 'package:crypto_track/src/features/market/domain/repositories/market_repository.dart';

class MarketRepositoryImpl implements MarketRepository{

  final MarketRemoteDataSource _dataSource;

  const MarketRepositoryImpl(this._dataSource);

  @override
  Future<MarketModel> fetchMarketApi() async{
    try {
      return await _dataSource.fetchMarketApi();
    } catch (e) {
      rethrow;
    }
  }
  
}