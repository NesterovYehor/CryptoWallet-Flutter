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

class FetchedPortfolioDataState extends DbBlocState {
  final List<PortfolioCoinModel> portfolioCoins;

  const FetchedPortfolioDataState({required this.portfolioCoins});

  @override
  List<Object> get props => [portfolioCoins];
}

class FetchingPortfolioDataState extends DbBlocState {}

class FetchPortfolioDataFailureState extends DbBlocState {
  final dynamic exception;

  const FetchPortfolioDataFailureState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class DeletingPortfolioDataFailureState extends DbBlocState {
  final dynamic exception;

  const DeletingPortfolioDataFailureState({required this.exception});

  @override
  List<Object> get props => [exception];
}
