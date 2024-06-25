import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/interfaces/sorting_repository.dart';
import 'package:crypto_track/utils/enums.dart';

class SortCoinsByPrice{
  final SortingRepository ropository;

  List<CoinModel> call(List<CoinModel> coins, SortByPriceType sortType){
    return ropository.sortCoinsByPrice(coins, sortType);
  }
  SortCoinsByPrice({required this.ropository});
}

class SortCoinsByAmount{
  final SortingRepository repository;
  List<PortfolioCoinModel> call(List<PortfolioCoinModel> coins, SortByAmountType sortType){
    return repository.sortCoinsByAmout(coins, sortType);
  }
  SortCoinsByAmount({required this.repository});
}