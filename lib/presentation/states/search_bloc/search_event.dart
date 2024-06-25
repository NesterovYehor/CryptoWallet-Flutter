part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
  
  @override
  List<Object?> get props => [];
}

class SearchCoinEvent extends SearchEvent {
  final String coinName;
  final List<CoinModel> coins;

  const SearchCoinEvent({required this.coinName, required this.coins});

  @override
  List<Object?> get props => [coinName];
}
