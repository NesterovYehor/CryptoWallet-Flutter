import 'package:bloc/bloc.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/use_cases/auth_use_cases.dart';
import 'package:crypto_track/domain/use_cases/firebase_use_cases.dart';
import 'package:crypto_track/domain/use_cases/sort_coins_use_cases.dart';
import 'package:crypto_track/utils/enums.dart';
import 'package:equatable/equatable.dart';

part 'db_bloc_event.dart';
part 'db_bloc_state.dart';

class DbBloc extends Bloc<DbBlocEvent, DbBlocState> {
  final AddCoinToPortfolio addCoinToPortfolio;
  final GetCurrentUserUseCase getCurrentUser;
  final FetchPortfolioData fetchPortfolioData;
  final SortCoinsByAmount sortCoinsByAmount;
  final DeleteCoinFromPortfolio deleteCoinFromPortfolio;
  
  SortByAmountType sortType = SortByAmountType.highestToLowestAmount;
  List<PortfolioCoinModel> _allCoins = []; 
  
  DbBloc(
    this.addCoinToPortfolio, 
    this.getCurrentUser, 
    this.fetchPortfolioData, 
    this.deleteCoinFromPortfolio, 
    {required this.sortCoinsByAmount}
  ) : super(DbBlocInitial()) {
    on<PushDataEvent>(_onPushDataEvent);
    on<FetchPortfolioDataEvent>(_onFetchPortfolioDataEvent);
    on<SortCoinsByAmountEvent>(_onSortCoinsByAmountEvent);
    on<DeleteCoinFromPortfolioEvent>(_onDeleteCoinFromPortfolioEvent);
  }

  Future<void> _onPushDataEvent(PushDataEvent event, Emitter<DbBlocState> emit) async {
    try {
      final user = getCurrentUser.call();
      if (user == null) throw Exception('User not logged in');

      await addCoinToPortfolio.call(event.portfolioCoin, user.uid);
      emit(PushedDataState());
      add(FetchPortfolioDataEvent());
    } catch (e) {
      emit(DbBlocError("Failed to add coin to portfolio: $e"));
    }
  }

  Future<void> _onFetchPortfolioDataEvent(FetchPortfolioDataEvent event, Emitter<DbBlocState> emit) async {
    emit(FetchingPortfolioDataState());
    try {
      final user = getCurrentUser.call();
      if (user == null) throw Exception('User not logged in');

      final portfolioDataStream = fetchPortfolioData.call(user.uid);
      await emit.forEach<List<PortfolioCoinModel>>(
        portfolioDataStream,
        onData: (portfolioData) {
          _allCoins = portfolioData;
          return FetchedPortfolioDataState(portfolioCoins: portfolioData);
        },
        onError: (error, stackTrace) => FetchPortfolioDataFailureState(exception: error),
      );
    } catch (e) {
      emit(FetchPortfolioDataFailureState(exception: e));
    }
  }

  void _onSortCoinsByAmountEvent(SortCoinsByAmountEvent event, Emitter<DbBlocState> emit) {
    emit(FetchingPortfolioDataState());
    try {
      sortType = (sortType == SortByAmountType.highestToLowestAmount) 
        ? SortByAmountType.lowestToHighestAmount 
        : SortByAmountType.highestToLowestAmount;

      _allCoins = sortCoinsByAmount.call(_allCoins, sortType);
      emit(FetchedPortfolioDataState(portfolioCoins: _allCoins));
    } catch (e) {
      emit(DbBlocError("Failed to sort coins: $e"));
    }
  }

  void _onDeleteCoinFromPortfolioEvent(DeleteCoinFromPortfolioEvent event, Emitter<DbBlocState> emit) {
    emit(FetchingPortfolioDataState());
    try {
      final user = getCurrentUser.call();
      if (user == null) throw Exception('User not logged in');

      deleteCoinFromPortfolio.call(event.portfolioCoin, user.uid);

      _allCoins.remove(event.portfolioCoin);
      emit(FetchedPortfolioDataState(portfolioCoins: _allCoins));
    } catch (e) {
      emit(DeletingPortfolioDataFailureState(exception: e));
    }
  }
}
