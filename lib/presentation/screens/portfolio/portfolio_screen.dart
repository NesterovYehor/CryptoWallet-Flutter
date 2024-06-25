import 'package:crypto_track/presentation/screens/detail/detail_screen.dart';
import 'package:crypto_track/presentation/screens/portfolio/edit_portfolio_screen.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/db_bloc/db_bloc.dart';
import 'package:crypto_track/presentation/states/search_bloc/search_bloc.dart';
import 'package:crypto_track/presentation/widgets/app_icon_btn.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/coin_list_tile_widget.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DbBloc>().add(FetchPortfolioDataEvent());

    final TextEditingController search = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Portfolio",
          style: subHeadingStyle.copyWith(
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AppIconBtn(
            onPressed: () {
              _showFullScreenModalBottomSheet(context);
            },
            icon: Icons.add,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppIconBtn(
              onPressed: () => context.go("/"),
              icon: Icons.arrow_back_ios_new,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DbBloc, DbBlocState>(
            listener: (context, state) {
              if (state is FetchPortfolioDataFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.toString())),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<DbBloc, DbBlocState>(
          builder: (context, dbState) {
            return BlocBuilder<ApiBloc, ApiBlocState>(
              builder: (context, apiState) {
                if (dbState is FetchingPortfolioDataState || apiState is FetchingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (dbState is FetchedPortfolioDataState && apiState is ApiFetchedState) {
                  final coins = apiState.coins;
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05),
                        child: AppInputField(
                          controller: search,
                          hint: "Search by name or symbol...",
                          title: "",
                          obscureText: false,
                          icon: Icons.search,
                          onChanged: (value) => context.read<SearchBloc>().add(SearchCoinEvent(coinName: value, coins: coins)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                        child: Row(
                          children: [
                            Text("Coin", style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => context.read<DbBloc>().add(SortCoinsByAmountEvent()),
                              child: Text("Holdings", style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),)),
                            const Spacer(),
                            Text("Price", style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),),
                            const SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () => context.read<ApiBloc>().add(FetchApiEvent()),
                              child: Icon(Icons.replay, color: Theme.of(context).colorScheme.secondary, size: 20,)
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: dbState.portfolioCoins.length,
                          itemBuilder: (context, index) {
                            final portfolioCoin = dbState.portfolioCoins[index];
                            final coin = coins.firstWhere(
                              (c) => c.symbol == portfolioCoin.index,
                            );
                            return GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(coin: coin),
                              )),
                              child: CoinListTileWidget(
                                showChart: false,
                                coin: coin,
                                amount: portfolioCoin.amount,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (dbState is DbBlocError || apiState is FetchingFailedState) {
                  return const Center(child: Text("Something went wrong"));
                } else {
                  return const Center(child: Text("No data available"));
                }
              },
            );
          },
        ),
      ),
    );
  }

  void _showFullScreenModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditPortfolioScreen(
          selectedCoin: null,
        );
      },
    );
  }
}
