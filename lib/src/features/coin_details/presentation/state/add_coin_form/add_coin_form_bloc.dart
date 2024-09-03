import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'add_coin_form_event.dart';
part 'add_coin_form_state.dart';

class AddCoinFormBloc extends Bloc<AddCoinFormEvent, AddCoinFormState> {
  AddCoinFormBloc() : super(const WalletFormInitialState()) {
    on<CoinAmountChangedEvent>(_onCoinAmountChanged);
  }

  _onCoinAmountChanged(
      CoinAmountChangedEvent event, Emitter<AddCoinFormState> emit) {
    emit(CoinFormDataState(
        inputAmount: event.amount, inputPrice: event.price * event.amount));
  }
}
