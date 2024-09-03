part of 'market_bloc.dart';

class MarketState extends Equatable { 
  @override
  List<Object> get props => [];
}

class MarketFetchingState extends MarketState{}

class MarketFetchedState extends MarketState{
  final MarketEntity marketData;

  MarketFetchedState({required this.marketData});
}

class MarketFetchErrorState extends MarketState{
  final String errorMessage;

  MarketFetchErrorState({required this.errorMessage});
}