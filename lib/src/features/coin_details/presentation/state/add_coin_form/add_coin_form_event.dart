part of 'add_coin_form_bloc.dart';

sealed class AddCoinFormEvent {}

class CoinAmountChangedEvent extends AddCoinFormEvent{
  final double amount;
  final double price;

  CoinAmountChangedEvent({required this.amount, required this.price});
}