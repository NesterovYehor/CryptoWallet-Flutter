import 'package:bloc/bloc.dart';
import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/data/models/market_model.dart';
import 'package:crypto_track/domain/use_cases/api_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'api_bloc_event.dart';
part 'api_bloc_state.dart';

class ApiBloc extends Bloc<ApiBlocEvent, ApiBlocState> {
  final FetchAllCoins fetchApi;
  final FetchMarketData fetchMarketApi;
  List<CoinModel> _allCoins = []; 
  MarketModel? _marketData = null;
  ApiBloc(this.fetchApi, this.fetchMarketApi) : super(ApiBlocInitial()) {
    on<FetchApiEvent>(_fetchAllApi);
    on<SearchCoinsEvent>(_searchCoins);
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

  void _searchCoins(SearchCoinsEvent event, Emitter<ApiBlocState> emit) {
    if (event.query.isEmpty) {
      emit(ApiFetchedState(coins: _allCoins, marketData: _marketData!)); 
    } else {
      final searchResults = _allCoins.where((coin) {
        final name = coin.name.toLowerCase();
        final symbol = coin.symbol.toLowerCase();
        final query = event.query.toLowerCase();
        return name.contains(query) || symbol.contains(query);
      }).toList();
      emit(SearchResultsState(searchResults));
    }
  }
}
