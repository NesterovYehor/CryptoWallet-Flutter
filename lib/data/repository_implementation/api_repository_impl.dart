import 'dart:convert';
import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/market_model.dart';
import 'package:crypto_track/domain/interfaces/api_repository.dart';
import 'package:http/http.dart' as http;

class ApiRepositoryImpl implements ApiRepository{
  final Uri _urlCoins = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true&x_cg_demo_api_key=CG-UKmWUafngVfdHFFXSPrWTar9");
  final Uri _urlMarket = Uri.parse("https://api.coingecko.com/api/v3/global?vs_currency=usd&x_cg_demo_api_key=CG-UKmWUafngVfdHFFXSPrWTar9");
  @override
  Future<List<CoinModel>> fetchCoinsApi() async{
    try {
      final response = await http.get(_urlCoins);
      if (response.statusCode == 200){
        final List<dynamic> jsonResponse = json.decode(response.body);
        final fetchedData = jsonResponse.map((data) => CoinModel.fromJson(data)).toList();
        return fetchedData;
      }
      else if (500 > response.statusCode && response.statusCode >= 400){
        throw("Bad Request ERROR: ${response.statusCode}");
      }
      else if (response.statusCode >= 500){
        throw("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw(e);
    }
    throw UnimplementedError();
  }

  @override
  Future<MarketModel> fetchMarketApi() async {
    try {
      final response = await http.get(_urlMarket);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body)['data'];
        final fetchedData = MarketModel.fromJson(jsonResponse);
        return fetchedData;
      } else if (500 > response.statusCode && response.statusCode >= 400) {
        throw Exception("Bad Request ERROR: ${response.statusCode}");
      } else if (response.statusCode >= 500) {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnimplementedError();
  }

}




