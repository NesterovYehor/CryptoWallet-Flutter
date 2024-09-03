import 'package:crypto_track/src/core/api/api_helper.dart';
import 'package:crypto_track/src/core/api/api_url.dart';
import 'package:crypto_track/src/core/utils/logger.dart';
import 'package:crypto_track/src/features/market/data/models/market_model.dart';

sealed class MarketRemoteDataSource {
  Future<MarketModel> fetchMarketApi();
}

class MarketRemoteDataSourceImpl implements MarketRemoteDataSource {
  final ApiHelper _helper;

  MarketRemoteDataSourceImpl(this._helper);

  @override
  Future<MarketModel> fetchMarketApi() async {
    try {
      final response = await _helper.execute(method: Method.get, url: ApiUrl.baseMarketUrl);      
      final jsonResponse = response.data as Map<String, dynamic>;
      return MarketModel.fromJson(jsonResponse['data']);
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
