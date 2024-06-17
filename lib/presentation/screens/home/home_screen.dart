import 'package:crypto_track/presentation/screens/detail/detail_screen.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/widgets/app_icon_btn.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_statistic_widget.dart';
import 'package:crypto_track/presentation/widgets/coin_list_tile_widget.dart';
import 'package:crypto_track/presentation/widgets/sidebar_menu%E2%80%8E.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      drawer: SidebarMenu(),
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
      body: BlocBuilder<ApiBloc, ApiBlocState>(
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppStatisticWidgets(
                        title: 'Market Cap',
                        value: market.marketCap,
                        percentageChange: market.marketCapChangePercentage24HUsd,
                      ),
                      AppStatisticWidgets(
                        title: '24h Volume',
                        value: market.volume,
                        percentageChange: null,
                      ),
                      AppStatisticWidgets(
                        title: 'BTC Dominance',
                        value: market.btcDominance,
                        percentageChange: null,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: AppInputField(
                    controller: _search,
                    hint: "Search by name or symbol...",
                    title: "",
                    obscureText: false,
                    icon: Icons.search,
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
                      Text(
                        "Price",
                        style: subTitleStyle.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
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
                  child: ListView.builder(
                    itemCount: coins.length,
                    itemBuilder: (context, index) {
                      final coin = coins[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailScreen(coin: coin),
                          ));
                        },
                        child: CoinListTileWidget(
                          marketCapRank: coin.marketCapRank,
                          image: coin.image,
                          symbol: coin.symbol,
                          currentPrice: coin.currentPrice,
                          priceChangePercentage24H: coin.priceChangePercentage24H,
                          amount: 0,
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
