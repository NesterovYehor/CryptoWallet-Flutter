import 'package:bloc/bloc.dart';
import 'package:crypto_track/data/models/portfolio_coin_model.dart';
import 'package:crypto_track/domain/use_cases/auth_use_cases.dart';
import 'package:crypto_track/domain/use_cases/firebase_use_cases.dart';
import 'package:equatable/equatable.dart';

part 'db_bloc_event.dart';
part 'db_bloc_state.dart';

class DbBloc extends Bloc<DbBlocEvent, DbBlocState> {
  final AddCoinToPortfolio addCoinToPortfolio;
  final GetCurrentUserUseCase getCurrentUser;
  final FetchPortfolioData fetchPortfolioData;

  DbBloc(
    this.addCoinToPortfolio,
    this.getCurrentUser,
    this.fetchPortfolioData,
  ) : super(DbBlocInitial()) {
    on<PushDataEvent>((event, emit) async {
      try {
        print("Adding coin to portfolio: ${event.portfolioCoin}");
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
      } catch (e) {
        print("Something went wrong while fetching portfolio data: $e");
        emit(FetchPortfolioDataFailureState(exception: e as Error));
      }
    });
  }
}
