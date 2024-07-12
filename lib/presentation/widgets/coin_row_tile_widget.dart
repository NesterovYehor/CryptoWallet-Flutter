import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CoinRowTileWidget extends StatelessWidget {
  const CoinRowTileWidget({super.key, required this.coin, required this.isSelected});

  final CoinModel coin;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        border: Border.all(
          color: isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.background,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.network(coin.image, width: 40),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coin.symbol.toUpperCase(),
                      style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(coin.name, style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary), overflow: TextOverflow.ellipsis,),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coin.currentPrice.asCurrencyWith2Decimals(),
                style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                coin.priceChangePercentage24H!.asPercentString(),
                style: titleStyle.copyWith(color: coin.priceChangePercentage24H! > 0 ? greenClr : redClr),
              ),
            ],
          )
        ],
      ),
    );
  }
}
