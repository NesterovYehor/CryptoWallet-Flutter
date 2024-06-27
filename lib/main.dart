import 'package:crypto_track/data/repository_implementation/api_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/auth_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/db_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/sorting_repository_impl.dart';
import 'package:crypto_track/domain/interfaces/api_repository.dart';
import 'package:crypto_track/domain/interfaces/auth_repository.dart';
import 'package:crypto_track/domain/interfaces/firebase_repository.dart';
import 'package:crypto_track/domain/interfaces/sorting_repository.dart';
import 'package:crypto_track/domain/use_cases/api_use_cases.dart';
import 'package:crypto_track/domain/use_cases/auth_use_cases.dart';
import 'package:crypto_track/domain/use_cases/firebase_use_cases.dart';
import 'package:crypto_track/domain/use_cases/sort_coins_use_cases.dart';
import 'package:crypto_track/firebase_options.dart';
import 'package:crypto_track/my_app_with_router.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/presentation/states/db_bloc/db_bloc.dart';
import 'package:crypto_track/presentation/states/search_bloc/search_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );  
  final ApiRepository apiRepository = ApiRepositoryImpl();
  final DbRepository dbRepository = DbRepositoryImpl();
  final SortingRepository sortRepository = SortingRepositoryImpl();
  final AuthRepository authRepository = AuthRepositoryImpl();
  final DeleteCoinFromPortfolio deleteCoinFromPortfolio = DeleteCoinFromPortfolio(repository: dbRepository);
  final SortCoinsByPrice sortCoinsByPrice = SortCoinsByPrice(ropository: sortRepository);
  final SortCoinsByAmount sortCoinsByAmount = SortCoinsByAmount(repository: sortRepository);
  final AddCoinToPortfolio addCoinToPortfolio = AddCoinToPortfolio(repository: dbRepository);
  final FetchPortfolioData fetchPortfolioData = FetchPortfolioData(repository: dbRepository);
  final FetchAllCoins fetchCoinsApi = FetchAllCoins(repository: apiRepository);
  final FetchMarketData fetchMarketApi = FetchMarketData(repository: apiRepository);
  final LogInUseCase logIn = LogInUseCase(repository: authRepository);
  final SignUpUseCase signUp = SignUpUseCase(repository: authRepository);
  final LogOutUseCase logOut = LogOutUseCase(repository: authRepository);
  final GetCurrentUserUseCase getCurrentUser = GetCurrentUserUseCase(repository: authRepository);
  final AuthenticationBloc authenticationBloc = AuthenticationBloc(logIn, signUp, logOut, getCurrentUser);
  final ApiBloc apiBloc = ApiBloc(fetchCoinsApi, fetchMarketApi, sortCoinsByPrice);
  final DbBloc dbBloc = DbBloc(addCoinToPortfolio, getCurrentUser, fetchPortfolioData, deleteCoinFromPortfolio, sortCoinsByAmount: sortCoinsByAmount);
  runApp(MyApp(authenticationBloc: authenticationBloc, apiBloc: apiBloc, dbBloc: dbBloc,));
}

class MyApp extends StatelessWidget {
  final AuthenticationBloc authenticationBloc;
  final ApiBloc apiBloc;
  final DbBloc dbBloc;
  const MyApp({super.key, required this.authenticationBloc, required this.apiBloc, required this.dbBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => dbBloc),
        BlocProvider(create: (context) => authenticationBloc),
        BlocProvider(create: (context) => apiBloc),
        BlocProvider(create: (context) => SearchBloc())
      ],
      child: const MyAppWithRouter()
    );
  }
}