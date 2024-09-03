part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletAddCoinEvent extends WalletEvent {
  final WalletCoinEntity newCoin;
  final String userId;
  const WalletAddCoinEvent({required this.newCoin, required this.userId});

  @override
  List<Object> get props => [newCoin];
}

class WalletFetchDataEvent extends WalletEvent {
  final String userId;

  const WalletFetchDataEvent({required this.userId});
}

class WalletDeleteCoinEvent extends WalletEvent{
  final String coinId;
  final String userId;

  const WalletDeleteCoinEvent({required this.coinId, required this.userId});
}


