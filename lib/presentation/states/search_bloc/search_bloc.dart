import 'package:bloc/bloc.dart';
import 'package:crypto_track/data/models/coin_model.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchCoinEvent>(_searchCoin);
  }

  Future<void> _searchCoin(SearchCoinEvent event, Emitter<SearchState> emit) async {
    emit(Searching());

    try {
      final searchedCoins = event.coins.where((coin) => coin.name.toLowerCase().contains(event.coinName.toLowerCase())).toList();
      emit(FoundedCoins(searchedCoins));
    } catch (e) {
      emit(SearchError(message: 'Failed to search coins: ${e.toString()}'));
    }
  }
}
