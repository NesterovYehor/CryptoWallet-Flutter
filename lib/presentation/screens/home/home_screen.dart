import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/presentation/screens/detail/detail_screen.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/search_bloc/search_bloc.dart';
import 'package:crypto_track/presentation/widgets/app_icon_btn.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_statistics_row.dart';
import 'package:crypto_track/presentation/widgets/coin_list_tile_widget.dart';
import 'package:crypto_track/presentation/widgets/sidebar_menu.dart.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();
  bool _isApiFetched = false;

  @override
  void initState() {
    super.initState();
    if (!_isApiFetched) {
      context.read<ApiBloc>().add(FetchApiEvent());
      _isApiFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarMenu(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Live Prices",
          style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              return AppIconBtn(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icons.info_outlined,
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppIconBtn(
              onPressed: () => context.push("/portfolio"),
              icon: Icons.arrow_forward_ios_sharp,
            ),
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApiBloc, ApiBlocState>(
            listener: (context, state) {
              if (state is FetchingFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.exception.toString())),
                );
              }
            },
          ),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<ApiBloc, ApiBlocState>(
          builder: (context, state) {
            if (state is FetchingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FetchingFailedState) {
              return Center(
                child: Text(state.exception.toString()),
              );
            } else if (state is ApiFetchedState) {
              final coins = state.coins;
              final market = state.marketData;
              return Column(
                children: [
                  StatisticsRow(market: market),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05),
                    child: AppInputField(
                      controller: _search,
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
                        Text(
                          "Coin",
                          style: subTitleStyle.copyWith(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.read<ApiBloc>().add(SortCoinsByPriceEvent()),
                          child: Text(
                            "Price",
                            style: subTitleStyle.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: () => context.read<ApiBloc>().add(FetchApiEvent()),
                          child: Icon(
                            Icons.replay,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, searchState) {
                        List<CoinModel> displayedCoins = coins;
                        if (searchState is FoundedCoins) {
                          displayedCoins = searchState.coins;
                        }
                        return ListView.builder(
                          itemCount: displayedCoins.length,
                          itemBuilder: (context, index) {
                            final coin = displayedCoins[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailScreen(coin: coin),
                                ));
                              },
                              child: CoinListTileWidget(
                                key: ValueKey(coin.id),
                                coin: coin,
                                amount: 0,
                                showChart: true,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}



