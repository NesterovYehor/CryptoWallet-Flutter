import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/screens/detail/detail_screen.dart';
import 'package:crypto_track/presentation/widgets/app_chart_widget.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class CoinListTileWidget extends StatelessWidget {
  CoinListTileWidget({
    super.key,
    required this.coin,
    required this.amount, 
    required this.showChart,
    required this.onPressed,
    required this.isSlidable
  });

  final CoinModel coin;
  final double amount;
  final bool showChart;
  void Function(BuildContext)? onPressed;
  final bool isSlidable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailScreen(coin: coin),)),
      child: isSlidable ? 
        Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: onPressed,
                backgroundColor: redClr,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]
          ),
          child: _buildcoinListTile(coin, context, amount, showChart)
        ) : _buildcoinListTile(coin, context, amount, showChart),
    );
  }
}


Widget _buildcoinListTile(CoinModel coin, BuildContext context, double amount, bool showChart){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    padding: const EdgeInsets.symmetric(vertical: 15),
    decoration: BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(color: Theme.of(context).colorScheme.primary, width: 0.2)),
    ),
    child: Row(
      children: [
        Text(
          coin.marketCapRank.toString(),
          style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
        ),
        const SizedBox(width: 10),
        Image.network(coin.image, width: 30),
        const SizedBox(width: 5),
        Text(
          coin.symbol.toUpperCase(),
          style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.17),
        if (amount != 0)
        _buildAmountAndPrice(coin, amount, context),
        if (showChart)
        AppChartWidget(
          coin: coin,
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.05,
          showDates: false,
          barWidth: 1,
        ),
        const Spacer(),
        _buildPriceAndPersentege(coin, context)
      ],
    ),
  );
}

Widget _buildPriceAndPersentege(CoinModel coin, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        coin.currentPrice.asCurrencyWith2Decimals(),
        style: subTitleStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      if (coin.priceChangePercentage24H != null)
        Text(
          coin.priceChangePercentage24H!.asPercentString(),
          style: subTitleStyle.copyWith(
            color: coin.priceChangePercentage24H! > 0 ? greenClr : redClr,
          ),
        ),
    ],
  );
}

Widget _buildAmountAndPrice(CoinModel coin, double amount, BuildContext context){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        (amount * coin.currentPrice).asCurrencyWith2Decimals(),
        style: subTitleStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        amount.toString(),
        style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
      ),
    ],
  );
}


