import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/widgets/app_chart_widget.dart';
import 'package:crypto_track/presentation/widgets/detail_chart_widget.dart';
import 'package:crypto_track/presentation/widgets/price_change_indicator.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _coinInfoWidget(context),
                      AppChartWidget(
                        coin: coin,
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        showDates: true,
                        barWidth: 2,
                      ),
                      _buildSectionTitle(context, "Overview"),
                      const Divider(),
                      _buildOverviewGrid(coin, context),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      _buildSectionTitle(context, "Additional Details"),
                      const Divider(),
                      _buildAdditionalGrid(coin, context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      title: Text(coin.name, style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary)),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: Text("Back", style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary)),
        ),
      ),
      actions: [_navigationBarTrailingItems(coin, context)],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget _navigationBarTrailingItems(CoinModel coin, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          Text(coin.symbol.toUpperCase(), style: titleStyle.copyWith(color: Theme.of(context).colorScheme.secondary)),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _coinInfoWidget(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(coin.image, width: 50),
            Text(
              coin.currentPrice.asCurrencyWith2Decimals(), 
              style: subHeadingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20),
              child: PriceChangeIndicator(
                priceChangePercentage: coin.priceChangePercentage24H!, 
              )
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewGrid(CoinModel coin, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: coin.priceChangePercentage24H,
              title: 'Current Price',
              value: coin.currentPrice.asCurrencyWith2Decimals(),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: coin.marketCapChangePercentage24H,
              title: 'Market Capitalization',
              value: coin.marketCap.formattedWithAbbreviations(),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: 'Rank',
              value: coin.marketCapRank.toString(),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: 'Volume',
              value: coin.marketCap.formattedWithAbbreviations(),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalGrid(CoinModel coin, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: '24h High',
              value: coin.high24H.asCurrencyWith2Decimals(),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: '24h Low',
              value: coin.low24H.asCurrencyWith2Decimals(),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: coin.priceChangePercentage24H,
              title: '24h Price Change',
              value: coin.priceChange24H!.asCurrencyWith2Decimals(),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: coin.marketCapChangePercentage24H,
              title: '24h Market Cap Change',
              value: coin.marketCapChange24H!.asCurrencyWith2Decimals(),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailChartWidget({
    required BuildContext context,
    double? percentage,
    required String title,
    required String value,
  }) {
    return DetailChartWidget(
      persentege: percentage,
      title: title,
      value: value,
    );
  }

}

