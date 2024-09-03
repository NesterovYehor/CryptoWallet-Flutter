import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/wallet/domain/entities/protfolio_coin_entitey.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/price_change_indicator.dart';
import 'package:flutter/material.dart';

class WalletSummaryWidget extends StatelessWidget {
  final List<WalletCoinEntity> walletCoins;
  final List<CoinEntity> coins;

  const WalletSummaryWidget({
    super.key,
    required this.walletCoins,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    double totalInvestment = walletCoins.fold(0.0, (sum, element) {
      final coin = coins.firstWhere((coin) => coin.id == element.id);
      return sum + (coin.currentPrice * element.amount);
    });

    double totalCurrentValue = walletCoins.fold(0.0, (sum, element) {
      final coin = coins.firstWhere((coin) => coin.id == element.id);
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
        gradient:
            const LinearGradient(colors: [AppColor.blueClr, AppColor.greenClr]),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.blueClr,
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
          _buildTodaysProfit(totalInvestment, totalCurrentValue,
              totalProfitPercentage, context),
        ],
      ),
    );
  }

  Widget _buildTotalCoinsWidget(
      double totalCurrentValue, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.loc.totalCoins,
          style: AppFont.bold.s20.copyWith(color: AppColor.whiteClr),
        ),
        Text(
          context.loc.asCurrencyWith2Decimals(totalCurrentValue),
          style: AppFont.bold.s25.copyWith(color: AppColor.whiteClr),
        ),
      ],
    );
  }

  Widget _buildTodaysProfit(double totalInvestment, double totalCurrentValue,
      double totalProfitPercentage, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.loc.todaysProfit,
              style: AppFont.bold.s20.copyWith(color: AppColor.whiteClr),
            ),
            Text(
              context.loc.asCurrencyWith2Decimals(totalCurrentValue - totalInvestment),
              style: AppFont.bold.s25.copyWith(color: AppColor.whiteClr),
            ),
          ],
        ),
        PriceChangeIndicator(priceChangePercentage: totalProfitPercentage),
      ],
    );
  }
}
