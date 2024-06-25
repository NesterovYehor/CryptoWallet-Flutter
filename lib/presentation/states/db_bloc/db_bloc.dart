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
  SortByAmountType sortType = SortByAmountType.highestToLowestAmount;
  List<PortfolioCoinModel> _allCoins = []; 
  
  DbBloc(this.addCoinToPortfolio, this.getCurrentUser, this.fetchPortfolioData, { required this.sortCoinsByAmount}) : super(DbBlocInitial()) {
    on<PushDataEvent>((event, emit) async {
      try {
        await addCoinToPortfolio.call(event.portfolioCoin, getCurrentUser.call()!.uid);
        emit(PushedDataState());
        // Trigger fetching the updated portfolio data
        add(FetchPortfolioDataEvent());
      } catch (e) {
        emit(DbBlocError("Failed to add coin to portfolio: $e"));
      }
    });

    on<FetchPortfolioDataEvent>((event, emit) async {
      emit(FetchingPortfolioDataState());
      try {
        final userId = getCurrentUser.call()!.uid;
        final portfolioDataStream = fetchPortfolioData.call(userId);
        await emit.forEach<List<PortfolioCoinModel>>(
          portfolioDataStream,
          onData: (portfolioData) => FetchedPortfolioDataState(portfolioCoins: portfolioData),
          onError: (error, stackTrace) => FetchPortfolioDataFailureState(exception: error as Error),
        );
        _allCoins = portfolioDataStream as List<PortfolioCoinModel>;
      } catch (e) {
        emit(FetchPortfolioDataFailureState(exception: e as Error));
      }
    });
    on<SortCoinsByAmountEvent>(_sortCoinsByAmount);
  }

   void _sortCoinsByAmount(SortCoinsByAmountEvent event, Emitter<DbBlocState> emit) {
    emit(FetchingPortfolioDataState());
    try {
      if (sortType == SortByAmountType.highestToLowestAmount) {
        sortType = SortByAmountType.lowestToHighestAmount;
        _allCoins = sortCoinsByAmount.call(_allCoins, sortType);
        emit(FetchedPortfolioDataState(portfolioCoins: _allCoins));
      } else {
        sortType = SortByAmountType.highestToLowestAmount;
        _allCoins = sortCoinsByAmount.call(_allCoins, sortType);
        emit(FetchedPortfolioDataState(portfolioCoins: _allCoins));
      }
    } catch (e) {
      throw (Exception(e));
    }
  }
}
