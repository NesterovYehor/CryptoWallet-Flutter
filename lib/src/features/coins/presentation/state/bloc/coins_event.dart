part of 'coins_bloc.dart';

sealed class CoinsEvent extends Equatable {
  const CoinsEvent();

  @override
  List<Object> get props => [];
}

class CoinFetchedEvent extends CoinsEvent{}

class CoinRefreshEvent extends CoinsEvent{}

class SpecificCoinFetchEvent extends CoinsEvent{
  final String coinId;

  const SpecificCoinFetchEvent({required this.coinId});
}