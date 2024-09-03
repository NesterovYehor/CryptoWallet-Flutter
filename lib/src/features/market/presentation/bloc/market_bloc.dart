import 'package:bloc/bloc.dart';
import 'package:crypto_track/src/core/utils/logger.dart';
import 'package:crypto_track/src/features/market/domain/entities/market_entite.dart';
import 'package:crypto_track/src/features/market/domain/use_cases/market_usecases.dart';
import 'package:equatable/equatable.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final FetchMarketDataUseCase _fetchMarketData;
  MarketBloc(this._fetchMarketData) : super(MarketState()) {
    on<MarketFetchEvent>(_onMarketFetched);
  }

  _onMarketFetched(MarketFetchEvent event, Emitter<MarketState> emit) async{
    emit(MarketFetchingState());
    try {
      final market = await _fetchMarketData();
      emit(MarketFetchedState(marketData: market));
    } catch (e) {
      logger.e(e);
      emit(MarketFetchErrorState(errorMessage: e.toString()));
    }
  }

  _onMarketRefresh(MarketRefreshEvent event, Emitter<MarketState> emit) async {
    emit(MarketFetchingState());
    try {
      final market = await _fetchMarketData();
      return emit(MarketFetchedState(marketData: market));
    } catch (e) {
      emit(MarketFetchErrorState(errorMessage: e.toString()));
    }
  }
}
