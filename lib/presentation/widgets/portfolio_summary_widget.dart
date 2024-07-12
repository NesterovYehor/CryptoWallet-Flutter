import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/states/db_bloc/db_bloc.dart';
import 'package:crypto_track/presentation/widgets/price_change_indicator.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class PortfolioSummaryWidget extends StatelessWidget {
  final FetchedPortfolioDataState dbState;
  final List<CoinModel> coins;

  const PortfolioSummaryWidget({
    super.key,
    required this.dbState,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    double totalInvestment = dbState.portfolioCoins.fold(0.0, (sum, element) {
      final coin = coins.firstWhere((coin) => coin.symbol == element.index);
      return sum + (coin.currentPrice * element.amount);
    });

    double totalCurrentValue = dbState.portfolioCoins.fold(0.0, (sum, element) {
      final coin = coins.firstWhere((coin) => coin.symbol == element.index);
      return sum + (coin.currentPrice * element.amount);
    });

    double totalProfitPercentage = totalInvestment > 0
        ? ((totalCurrentValue - totalInvestment) / totalInvestment) * 100
        : 0.0;

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [blueclr, greenClr]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: blueclr,
            offset: Offset(0, 15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTotalCoinsWidget(totalCurrentValue, context),
          _buildTodaysProfit(totalInvestment, totalCurrentValue, totalProfitPercentage, context),
        ],
      ),
    );
  }

  Widget _buildTotalCoinsWidget(double totalCurrentValue, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total Coins",
          style: subHeadingStyle.copyWith(color: whiteClr),
        ),
        Text(
          totalCurrentValue.asCurrencyWith2Decimals(),
          style: headingStyle.copyWith(color: whiteClr),
        ),
      ],
    );
  }

  Widget _buildTodaysProfit(double totalInvestment, double totalCurrentValue, double totalProfitPercentage, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Profit",
              style: subHeadingStyle.copyWith(color: whiteClr),
            ),
            Text(
              (totalCurrentValue - totalInvestment).asCurrencyWith2Decimals(),
              style: headingStyle.copyWith(color: whiteClr),
            ),
          ],
        ),
        PriceChangeIndicator(priceChangePercentage: totalProfitPercentage),
      ],
    );
  }
}
