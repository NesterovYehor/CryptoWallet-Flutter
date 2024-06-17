import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class CoinRowTileWidget extends StatelessWidget {
  const CoinRowTileWidget({super.key, required this.coin, required this.isSelected});

  final CoinModel coin;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(coin.image, width: 50),
          Text(
            coin.symbol.toUpperCase(),
            style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          Text(coin.name),
        ],
      ),
    );
  }
}
