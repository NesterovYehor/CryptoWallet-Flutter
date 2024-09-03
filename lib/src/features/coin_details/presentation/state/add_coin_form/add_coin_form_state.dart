part of 'add_coin_form_bloc.dart';


sealed class AddCoinFormState extends Equatable {
  final double amount;
  final double price;

  const AddCoinFormState({
    required this.amount,
    required this.price,
  });

  @override
  List<Object> get props => [
        amount,
        price,
      ];
}

class WalletFormInitialState extends AddCoinFormState {
  const WalletFormInitialState()
      : super(
          amount: 0,
          price: 0,
        );
}

class CoinFormDataState extends AddCoinFormState {
  final double inputAmount;
  final double inputPrice;

  const CoinFormDataState({
    required this.inputAmount,
    required this.inputPrice,
  }) : super(
          amount: inputAmount,
          price: inputPrice,
        );

  @override
  List<Object> get props => [
        inputAmount,
        inputPrice,
      ];
}