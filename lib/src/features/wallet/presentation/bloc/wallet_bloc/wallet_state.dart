part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitialState extends WalletState {}

class WalletErrorState extends WalletState {
  final String errorMessage;

  const WalletErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class WalletFetchedState extends WalletState {
  final List<WalletCoinEntity> walletCoins ;

  const WalletFetchedState({required this.walletCoins});

  @override
  List<Object> get props => [walletCoins];
}

class WalletFetchingState extends WalletState {}
