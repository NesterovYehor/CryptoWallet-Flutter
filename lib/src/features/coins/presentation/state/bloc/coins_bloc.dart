import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:crypto_track/src/core/utils/enums.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coins/domain/use_cases/fetch_coins_use_cases.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

part 'coins_event.dart';
part 'coins_state.dart';

const throttleDuration = Duration(milliseconds: 200);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CoinsBloc extends Bloc<CoinsEvent, CoinsState> {
  final FetchCoinsUseCase _fetchCoins;
  final FetchSpecificCoinUseCases _fetchSpecificCoin;
  CoinsBloc(this._fetchCoins, this._fetchSpecificCoin) : super(const CoinsState()) {
    on<CoinFetchedEvent>(_onCoinFetched,
        transformer: throttleDroppable(throttleDuration));
    on<CoinRefreshEvent>(_onCoinRefresh);
    // on<SpecificCoinFetchEvent>(_onSpecificCoinFetch);
  }

  _onCoinFetched(CoinFetchedEvent event, Emitter<CoinsState> emit) async {
    if (state.hasReachedMax) return;
    try {
      emit(state.copyWith(isLoading: true));
      if (state.status == DataStatus.initial) {
        final List<CoinEntity> coins = await _fetchCoins();
        return emit(state.copyWith(
            status: DataStatus.success,
            coins: coins,
            hasReachedMax: false,
            pageNumber: 2));
      }
      if (state.coins.length == 100) {
        return emit(state.copyWith(hasReachedMax: true));
      } else {
        final coins = await _fetchCoins(state.pageNumber);
        emit(state.copyWith(
            status: DataStatus.success,
            coins: List.of(state.coins)..addAll(coins),
            pageNumber: state.pageNumber + 1));
      }
    } catch (e) {
      emit(state.copyWith(status: DataStatus.failure));
    }
  }

  _onCoinRefresh(CoinRefreshEvent event, Emitter<CoinsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final coins = await _fetchCoins.call(1, state.coins.length);
    coins.isEmpty
        ? emit(state.copyWith(hasReachedMax: true, isLoading: false))
        : emit(state.copyWith(
            isLoading: false,
            status: DataStatus.success,
            coins: List.of(state.coins)..addAll(coins),
            pageNumber: state.pageNumber + 1));
  }

  // _onSpecificCoinFetch(SpecificCoinFetchEvent event, Emitter<CoinsState> emit) async{
  //   try {
  //     emit(state.copyWith(isLoading: true)); 
  //     final coin = await _fetchSpecificCoin.call(event.coinId);
  //     emit(state.copyWith(coins: state.coins..add(coin), isLoading: false, status: DataStatus.success));
  //   } catch (e) {
  //     emit(state.copyWith(status: DataStatus.failure));
  //   }
  // }
}
