part of 'api_bloc.dart';

sealed class ApiBlocState extends Equatable {
  const ApiBlocState();
  
  @override
  List<Object> get props => [];
}

class ApiBlocInitial extends ApiBlocState {}

class ApiFetchedState extends ApiBlocState{
  final List<CoinModel> coins;
  final MarketModel marketData;
  ApiFetchedState({required this.coins, required this.marketData});
}

class FetchingState extends ApiBlocState{}

class FetchingFailedState extends ApiBlocState{
  final Exception exception;
  FetchingFailedState({required this.exception});
}


class SearchResultsState extends ApiBlocState {
  final List<CoinModel> searchResults;

  SearchResultsState(this.searchResults);
}