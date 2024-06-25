import 'package:bloc/bloc.dart';
import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/market_model.dart';
import 'package:crypto_track/domain/use_cases/api_use_cases.dart';
import 'package:crypto_track/domain/use_cases/sort_coins_use_cases.dart';
import 'package:crypto_track/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'api_bloc_event.dart';
part 'api_bloc_state.dart';

class ApiBloc extends Bloc<ApiBlocEvent, ApiBlocState> {
  final FetchAllCoins fetchApi;
  final FetchMarketData fetchMarketApi;
  final SortCoinsByPrice sortCoinsByPrice;
  SortByPriceType sortType = SortByPriceType.highestToLowestPrice;
  List<CoinModel> _allCoins = []; 
  MarketModel? _marketData;

  ApiBloc(this.fetchApi, this.fetchMarketApi, this.sortCoinsByPrice) : super(ApiBlocInitial()) {
    on<FetchApiEvent>(_fetchAllApi);
    on<SortCoinsByPriceEvent>(_sortCoinsByPrice);
  }

  void _fetchAllApi(FetchApiEvent event, Emitter<ApiBlocState> emit) async {
    emit(FetchingState());
    try {
      final marketData = await fetchMarketApi.call();
      final coins = await fetchApi.call();
      _allCoins = coins; 
      _marketData = marketData;
      emit(ApiFetchedState(coins: coins, marketData: marketData));
    } catch (e) {
      emit(FetchingFailedState(exception: Exception(e)));
    }
  }

  void _sortCoinsByPrice(SortCoinsByPriceEvent event, Emitter<ApiBlocState> emit) {
    emit(FetchingState());
    try {
      if (sortType == SortByPriceType.highestToLowestPrice) {
        sortType = SortByPriceType.lowestToHighestPrice;
      } else {
        sortType = SortByPriceType.highestToLowestPrice;
      }
      _allCoins = [...sortCoinsByPrice.call(_allCoins, sortType)];
      emit(ApiFetchedState(coins: _allCoins, marketData: _marketData!));
    } catch (e) {
      emit(FetchingFailedState(exception: Exception(e.toString())));
    }
  }
}
