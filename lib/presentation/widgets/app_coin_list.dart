import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/presentation/widgets/coin_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppCoinList extends StatelessWidget {
  const AppCoinList({super.key, required this.coins});

  final List<CoinModel> coins;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(25)
      ),
      child: ListView.builder(
        itemCount: coins.length,
        itemBuilder: (context, index) {
          final coin = coins[index];
          return CoinListTileWidget(
            key: ValueKey(coin.id),
            coin: coin,
            amount: 0,
            showChart: true,
            onPressed: (BuildContext context) {
              context.go('/detail/${coin.id}');
            },
            isSlidable: false,
          );
        },
      ),
    );
  }
}