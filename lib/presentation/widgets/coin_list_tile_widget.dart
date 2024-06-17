import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class CoinListTileWidget extends StatelessWidget {
  const CoinListTileWidget({super.key, 
    required this.marketCapRank, 
    required this.image, 
    required this.symbol, 
    required this.currentPrice, 
    required this.priceChangePercentage24H, 
    required this.amount
  });

  final int marketCapRank;
  final String image;
  final String symbol;
  final double currentPrice;
  final double? priceChangePercentage24H;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.1))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: Row(
          children: [
            Text(marketCapRank.toString()),
            const SizedBox(width: 10,),
            Image.network(image, width: 30,),
            const SizedBox(width: 5,),
            Text(symbol.toUpperCase(), style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
            SizedBox(width: MediaQuery.of(context).size.width * 0.17,),
            if(amount != 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (amount * currentPrice).asCurrencyWith2Decimals(), 
                  style: subTitleStyle.copyWith(color: 
                    Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold, 
                  ),),
                  Text(amount.toString(), style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),)
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currentPrice.asCurrencyWith2Decimals(), 
                  style: subTitleStyle.copyWith(
                    color: Theme.of(context).colorScheme.primary, 
                    fontWeight: FontWeight.bold),
                  ),
                if (priceChangePercentage24H != null)
                Text(
                  priceChangePercentage24H!.asPercentString(), 
                  style: subTitleStyle.copyWith(color: priceChangePercentage24H! > 0 ? greenClr : redClr,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}