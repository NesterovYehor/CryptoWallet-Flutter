part of 'db_bloc.dart';

abstract class DbBlocState extends Equatable {
  const DbBlocState();
  
  @override
  List<Object> get props => [];
}

class DbBlocInitial extends DbBlocState {}

class PushedDataState extends DbBlocState {}

class DbBlocError extends DbBlocState {
  final String message;

  const DbBlocError(this.message);

  @override
  List<Object> get props => [message];
}

class FetchedPortfolioDataState extends DbBlocState{
  final List<PortfolioCoinModel> portfolioCoins;
  FetchedPortfolioDataState({required this.portfolioCoins});
}

class FetchingPortfolioDataState extends DbBlocState{}

class FetchPortfolioDataFailureState extends DbBlocState{
  final Error exception;
  FetchPortfolioDataFailureState({required this.exception});
}
