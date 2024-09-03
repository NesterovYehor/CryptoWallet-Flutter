import 'package:bloc/bloc.dart';
import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/core/utils/enums.dart';
import 'package:crypto_track/src/features/wallet/domain/use_cases/add_coin_to_wallet_usecase.dart';
import 'package:crypto_track/src/features/wallet/domain/use_cases/delete_coin_usecase.dart';
import 'package:crypto_track/src/features/wallet/domain/use_cases/fetch_wallet_coins_usecase.dart';
import 'package:equatable/equatable.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final FetchWalletUseCase _fetchWallet;
  final AddCoinToWalletUseCase _addCoinToWallet;
  final DeleteCoinFromWalletUseCase _deleteCoinFromWallet;
 
  SortByAmountType sortType = SortByAmountType.highestToLowestAmount;

  WalletBloc(
    this._fetchWallet,
    this._addCoinToWallet, this._deleteCoinFromWallet,
  ) : super(WalletInitialState()) {
    on<WalletFetchDataEvent>(_onFetchWalletData);
    on<WalletAddCoinEvent>(_onAddCoin);
    on<WalletDeleteCoinEvent>(_onDeleteCoin);
  }

  _onAddCoin(WalletAddCoinEvent event, Emitter<WalletState> emit) async {
    try {
      _addCoinToWallet.call(event.newCoin, event.userId);
      add(WalletFetchDataEvent(userId: event.userId));
    } catch (e) {
      emit(WalletErrorState("Failed to add coin to portfolio: $e"));
    }
  }

  _onFetchWalletData(
      WalletFetchDataEvent event, Emitter<WalletState> emit) async {
    emit(WalletFetchingState());
    try {
      final walletData = await _fetchWallet.call(event.userId);
      emit(WalletFetchedState(walletCoins: walletData));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }

  _onDeleteCoin(WalletDeleteCoinEvent event, Emitter<WalletState> emit) async{
    try {
      await _deleteCoinFromWallet.call(event.coinId, event.userId);
      add(WalletFetchDataEvent(userId: event.userId));
    } catch (e) {
      emit(WalletErrorState(e.toString()));
    }
  }
}
