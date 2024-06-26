import 'package:crypto_track/data/models/market_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/presentation/widgets/app_statistic_widget.dart';

class StatisticsRow extends StatelessWidget {
  final MarketModel market;

  const StatisticsRow({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
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
    );
  }
}
