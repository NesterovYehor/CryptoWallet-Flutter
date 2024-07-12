import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/search_bloc/search_bloc.dart';
import 'package:crypto_track/presentation/widgets/app_coin_list.dart';
import 'package:crypto_track/presentation/widgets/app_icon_btn.dart';
import 'package:crypto_track/presentation/widgets/app_input_field.dart';
import 'package:crypto_track/presentation/widgets/app_statistics_row.dart';
import 'package:crypto_track/presentation/widgets/sidebar_menu.dart.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      _fetchApiData();
    }
  }

  void _fetchApiData() {
    context.read<ApiBloc>().add(FetchApiEvent());
    _isApiFetched = true;
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SidebarMenu(),
      appBar: _buildAppBar(context),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ApiBloc, ApiBlocState>(
            listener: (context, state) {
              _handleApiBlocState(context, state);
            },
          ),
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              _handleSearchBlocState(context, state);
            },
          ),
        ],
        child: BlocBuilder<ApiBloc, ApiBlocState>(
          builder: (context, state) {
            if (state is FetchingState) {
              return _buildLoadingState();
            } else if (state is FetchingFailedState) {
              return _buildFetchFailedState(state);
            } else if (state is ApiFetchedState) {
              return _buildApiFetchedState(state);
            } else {
              return _buildErrorState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildFetchFailedState(FetchingFailedState state) {
    return Center(
      child: Text(state.exception.toString()),
    );
  }

  Widget _buildApiFetchedState(ApiFetchedState state) {
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
            onChanged: (value) {
              _handleSearchInput(value, coins);
            },
          ),
        ),
        coinListHeader(context),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
              return _buildCoinList(searchState, coins);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState() {
    return const Center(
      child: Text("Something went wrong"),
    );
  }

  void _handleApiBlocState(BuildContext context, ApiBlocState state) {
    if (state is FetchingFailedState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.exception.toString())),
      );
    }
  }

  void _handleSearchBlocState(BuildContext context, SearchState state) {
    if (state is SearchError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  void _handleSearchInput(String value, List<CoinModel> coins) {
    context.read<SearchBloc>().add(SearchCoinEvent(coinName: value, coins: coins));
  }

  Widget _buildCoinList(SearchState searchState, List<CoinModel> coins) {
    List<CoinModel> displayedCoins = coins;
    if (searchState is FoundedCoins) {
      displayedCoins = searchState.coins;
    }
    return AppCoinList(coins: displayedCoins);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
    );
  }

  Widget coinListHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.read<ApiBloc>().add(SortCoinsByRankEvent()),
            child: Text(
              "Coin",
              style: subTitleStyle.copyWith(
                  color: Theme.of(context).colorScheme.secondary),
            ),
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
    );
  }
}
