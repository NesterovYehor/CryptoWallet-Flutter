import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/utils/enums.dart';

abstract class SortingRepository{
  List<CoinModel> sortCoinsByPrice(List<CoinModel> coins, SortByPriceType sortType);
  List<PortfolioCoinModel> sortCoinsByAmout(List<PortfolioCoinModel> coins, SortByAmountType sortType);
  List<CoinModel> sortCoinsByRank(List<CoinModel> coins, SortByRankType sortType);
}