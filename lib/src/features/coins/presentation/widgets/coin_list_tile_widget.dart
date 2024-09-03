import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coin_details/presentation/screens/detail_screen.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/widgets/app_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CoinListTileWidget extends StatelessWidget {
  final CoinEntity coin;
  final double amount;
  final bool showChart;
  final void Function(BuildContext)? slideAction;
  final bool isSlidable;

  const CoinListTileWidget({
    super.key,
    required this.coin,
    required this.amount,
    required this.showChart,
    required this.slideAction,
    required this.isSlidable,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.select((ThemeBloc bloc) => bloc.state.isDarkMode);
    final secondaryColor = AppColor.getSecondaryColor(isDarkMode);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DetailScreen(coin: coin),
        ),
      ),
      child: isSlidable
          ? Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: slideAction,
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.getPrimaryColor(isDarkMode),
                    icon: Icons.delete,
                    label: context.loc.delete,
                  ),
                ],
              ),
              child: _buildCoinListTile(context, secondaryColor),
            )
          : _buildCoinListTile(context, secondaryColor),
    );
  }

  Widget _buildCoinListTile(BuildContext context, Color secondaryColor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          _buildRank(secondaryColor),
          const SizedBox(width: 10),
          Image.network(coin.image, width: 30),
          const SizedBox(width: 5),
          _buildCoinSymbol(),
          if (amount != 0) _buildAmountAndPrice(context),
          if (showChart) _buildChart(context),
          const Spacer(),
          _buildPriceAndPercentage(context),
        ],
      ),
    );
  }

  Widget _buildRank(Color secondaryColor) {
    return Text(
      coin.marketCapRank.toString(),
      style: AppFont.normal.s14.copyWith(color: secondaryColor),
    );
  }

  Widget _buildCoinSymbol() {
    return SizedBox(
      width: 80, 
      child: Text(
        coin.symbol.toUpperCase(),
        style: AppFont.bold.s17,
      ),
    );
  }

  Widget _buildAmountAndPrice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.loc.asCurrencyWith2Decimals(amount * coin.currentPrice),
          style: AppFont.bold.s14,
        ),
        Text(
          amount.toString(),
          style: AppFont.normal.s14,
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    return AppChartWidget(
      coin: coin,
      width: MediaQuery.of(context).size.width * 0.27,
      height: MediaQuery.of(context).size.height * 0.05,
      showDates: false,
      barWidth: 1,
    );
  }

  Widget _buildPriceAndPercentage(BuildContext context) {
    final priceChange = coin.priceChangePercentage24H;
    final percentageStyle = priceChange != null
        ? AppFont.normal.s14.copyWith(
            color: priceChange > 0 ? AppColor.greenClr : AppColor.redClr,
          )
        : AppFont.normal.s14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          context.loc.asCurrencyWith2Decimals(coin.currentPrice),
          style: AppFont.bold.s14,
        ),
        if (priceChange != null)
          Text(
            context.loc.asPercentString(priceChange),
            style: percentageStyle,
          ),
      ],
    );
  }
}
