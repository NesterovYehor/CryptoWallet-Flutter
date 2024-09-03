part of 'market_bloc.dart';

sealed class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object> get props => [];
}


class MarketFetchEvent extends MarketEvent{}

class MarketRefreshEvent extends MarketEvent{}