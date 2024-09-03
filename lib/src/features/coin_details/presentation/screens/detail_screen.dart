import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/add_coin_bottom_sheet.dart';
import 'package:crypto_track/src/widgets/app_chart_widget.dart';
import 'package:crypto_track/src/widgets/app_btn.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/detail_chart_widget.dart';
import 'package:crypto_track/src/features/coin_details/presentation/widgets/price_change_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.coin});

  final CoinEntity coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(context),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 20),
        child: AppBtn(
            label: context.loc.addToWallet,
            onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => AddCoinBottomSheet(
                    coin: coin,
                  ),
                )),
      ),
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
                      _buildSectionTitle(context, context.loc.overview),
                      const Divider(),
                      _buildOverviewGrid(coin, context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05),
                      _buildSectionTitle(context, context.loc.additionalDetails),
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
      title: Text(coin.name, style: AppFont.normal.s20),
      leading: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: Text("Back", style: AppFont.normal.s14),
        ),
      ),
      actions: [_navigationBarTrailingItems(coin, context)],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(title, style: AppFont.bold.s25);
  }

  Widget _navigationBarTrailingItems(CoinEntity coin, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        children: [
          Text(coin.symbol.toUpperCase(),
              style: AppFont.bold.s17.copyWith(
                  color: AppColor.getSecondaryColor(
                context.select((ThemeBloc bloc) => bloc.state.isDarkMode),
              ))),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _coinInfoWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(coin.image, width: 50),
            Text(
              context.loc.asCurrencyWith2Decimals(coin.currentPrice),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                child: PriceChangeIndicator(
                  priceChangePercentage: coin.priceChangePercentage24H!,
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewGrid(CoinEntity coin, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: coin.priceChangePercentage24H,
              title: context.loc.currentPrice,
              value: context.loc.asCurrencyWith2Decimals(coin.currentPrice),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: coin.marketCapChangePercentage24H,
              title: context.loc.marketCap,
              value: context.loc.asCurrencyWith2Decimals(coin.marketCap),
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
              title: context.loc.rank,
              value: coin.marketCapRank.toString(),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: context.loc.volume,
              value: context.loc.asCurrencyWith2Decimals(coin.marketCap),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalGrid(CoinEntity coin, BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: context.loc.high24h,
              value: context.loc.asCurrencyWith2Decimals(coin.high24H),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: null,
              title: context.loc.low24h,
              value: context.loc.asCurrencyWith2Decimals(coin.low24H),
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
              title: context.loc.priceChange24h,
              value: context.loc.asCurrencyWith2Decimals(coin.priceChange24H ?? 0),
            ),
            const Spacer(),
            _buildDetailChartWidget(
              context: context,
              percentage: coin.marketCapChangePercentage24H,
              title: context.loc.marketCapChange24h,
              value: context.loc.asCurrencyWith2Decimals(coin.marketCapChange24H ?? 0),
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
      percentage: percentage,
      title: title,
      value: value,
    );
  }
}
