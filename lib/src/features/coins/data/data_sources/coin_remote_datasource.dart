import '../../../../core/api/api_helper.dart';
import '../../../../core/api/api_url.dart';
import '../../../../core/utils/logger.dart';
import '../models/coin_model.dart';

sealed class CoinRemoteDataSource {
  Future<List<CoinModel>> fetchCoins(int pageNumber, int perPage);
  Future<CoinModel> fetchSpecificCoin(String coinId);
}

class CoinRemoteDataSourceImpl implements CoinRemoteDataSource {
  final ApiHelper _helper;

  const CoinRemoteDataSourceImpl(this._helper);

  @override
  Future<List<CoinModel>> fetchCoins(int pageNumber, int perPage) async {
    try {
      final response = await _helper.execute(
          method: Method.get,
          url:
              "${ApiUrl.baseCoinsUrl}&per_page=${perPage}&page=${pageNumber}x_cg_demo_api_key=CG-UKmWUafngVfdHFFXSPrWTar9");
      final jsonResponse = response.data;
      
      return CoinModel.fromJsonList(jsonResponse);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
  
  @override
  Future<CoinModel> fetchSpecificCoin(String coinId) async{
    try {
      final response = await _helper.execute(method: Method.get, url: "${ApiUrl.baseCoinsUrl}&id:${coinId}x_cg_demo_api_key=CG-UKmWUafngVfdHFFXSPrWTar9");
      return CoinModel.fromJson(response.data);
    } catch (e) {
      logger.e(e);
      rethrow;     
    }
  }
}

