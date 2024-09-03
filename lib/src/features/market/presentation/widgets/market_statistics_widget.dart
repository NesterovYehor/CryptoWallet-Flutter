import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:crypto_track/src/features/market/domain/entities/market_entite.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketStatisticsWidget extends StatelessWidget {
  final MarketEntity market;

  const MarketStatisticsWidget({super.key, required this.market});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatisticWidget(
              context.loc.marketCap,
              context.loc.asCurrencyWith2Decimals(market.totalMarketCap),
              market.marketCapPercentage,
              context),
          _buildStatisticWidget(
              context.loc.tradingVolume24h,
              context.loc.asCurrencyWith2Decimals(market.totalVolume),
              null,
              context),
          _buildStatisticWidget(context.loc.btcDominance,
              context.loc.asPercentString(market.btcDominance), null, context),
        ],
      ),
    );
  }

  Widget _buildStatisticWidget(String title, String value,
      double? percentageChange, BuildContext context) {
    final percentageStyle = percentageChange != null
        ? AppFont.normal.s14.copyWith(
            color: percentageChange > 0
                ? AppColor.greenClr
                : AppColor.redClr)
        : null;

    return Column(
      children: [
        Text(title,
            style: AppFont.normal.s14.copyWith(
                color: AppColor.getSecondaryColor(
              context.select((ThemeBloc bloc) => bloc.state.isDarkMode),
            ))),
        Text(value, style: AppFont.bold.s17),
        if (percentageChange != null)
          Text(
            context.loc.asPercentString(market.marketCapPercentage),
            style: percentageStyle,
          ),
      ],
    );
  }
}
