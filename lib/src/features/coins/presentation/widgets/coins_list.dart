import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/utils/enums.dart';
import 'package:crypto_track/src/features/coins/presentation/state/bloc/coins_bloc.dart';
import 'package:crypto_track/src/features/coins/presentation/widgets/coin_list_tile_widget.dart';
import 'package:crypto_track/src/features/market/presentation/widgets/bottom_loader.dart';
import 'package:crypto_track/src/routes/app_route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoinsList extends StatefulWidget {
  const CoinsList({super.key});

  @override
  State<CoinsList> createState() => _CoinsListState();
}

class _CoinsListState extends State<CoinsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.select((ThemeBloc bloc) => bloc.state.isDarkMode);
    return BlocBuilder<CoinsBloc, CoinsState>(
      builder: (context, state) {
        if (state.status == DataStatus.failure) {
          return Center(
            child: Text(context.loc.errorGenericFailure),
          );
        } else {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: AppColor.getContainerColor(isDarkMode),
                borderRadius: BorderRadius.circular(25)),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.hasReachedMax
                  ? state.coins.length
                  : state.coins.length + 1,
              itemBuilder: (context, index) {
                return index >= state.coins.length
                    ? const BottomLoader()
                    : CoinListTileWidget(
                        key: ValueKey(state.coins[index].id),
                        coin: state.coins[index],
                        amount: 0,
                        showChart: true,
                        slideAction: (BuildContext context) {
                          context.pushNamed(AppRoute.details.name,
                              extra: state.coins[index]);
                        },
                        isSlidable: false,
                      );
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<CoinsBloc>().add(CoinFetchedEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
