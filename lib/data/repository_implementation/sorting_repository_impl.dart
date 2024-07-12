import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/interfaces/sorting_repository.dart';
import 'package:crypto_track/utils/enums.dart';

class SortingRepositoryImpl implements SortingRepository{
  @override
  List<PortfolioCoinModel> sortCoinsByAmout(List<PortfolioCoinModel> coins, SortByAmountType sortType) {
    List<PortfolioCoinModel> sortedCoins = List.from(coins);
    if (sortType == SortByAmountType.highestToLowestAmount){
      sortedCoins.sort((a, b) => b.amount.compareTo(a.amount));
    }else{
      sortedCoins.sort((a, b) => a.amount.compareTo(b.amount));
    }
    return sortedCoins;
  }

  @override
  List<CoinModel> sortCoinsByPrice(List<CoinModel> coins, SortByPriceType sortType) {
    List<CoinModel> sortedCoins = List.from(coins);  
    try {
      if (sortType == SortByPriceType.highestToLowestPrice){
        sortedCoins.sort((a, b) => b.currentPrice.compareTo(a.currentPrice));
      }else if(sortType == SortByPriceType.lowestToHighestPrice){
        sortedCoins.sort((a, b) => a.currentPrice.compareTo(b.currentPrice));
      }
    } catch (e) {
      throw (Exception(e));
    }
    return sortedCoins;
  }
  
  @override
  List<CoinModel> sortCoinsByRank(List<CoinModel> coins, SortByRankType sortType) {
    List<CoinModel> sortedCoins = List.from(coins);  
    try {
      if (sortType == SortByRankType.highestToLowestRank){
        sortedCoins.sort((a, b) => b.marketCapRank.compareTo(a.marketCapRank));
      }else if(sortType == SortByRankType.lowestToHighestRank){
        sortedCoins.sort((a, b) => a.marketCapRank.compareTo(b.marketCapRank));
      }
    } catch (e) {
      throw (Exception(e));
    }
    return sortedCoins;
  }

}