part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

class Searching extends SearchState{}

class FoundedCoins extends SearchState {
  final List<CoinModel> coins;
  
  const FoundedCoins(this.coins);

  @override
  List<Object> get props => [coins];
}

class SearchError extends SearchState{
  final String message;
  const SearchError({required this.message});
}