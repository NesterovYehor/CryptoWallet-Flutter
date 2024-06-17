import 'package:crypto_track/data/models/coin_model.dart';
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/presentation/widgets/app_chart_widget.dart';
import 'package:crypto_track/presentation/widgets/detail_chart_widget.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.coin});

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: GestureDetector(
            onTap: () => context.pop(),
           child: Text("Back", style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),), 
          ),
        ),
        actions: [
          _navigationBarTrailingItems(coin, context),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(coin.name, style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                      AppChartWidget(coin: coin,),
                      Text("Overview", style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                      const Divider(),
                      _overviewGrid(coin, context),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                      Text("Additional Details", style: headingStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
                      const Divider(),
                      _additionalGrid(coin, context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _navigationBarTrailingItems(CoinModel coin, BuildContext context){
  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Row(
            children: [
              Text(coin.symbol.toUpperCase(), style: titleStyle.copyWith(color: Theme.of(context).colorScheme.secondary)),
              const SizedBox(width: 5,),
              Image.network(coin.image, width: 30,),
            ],
          ),
  );
}

Widget _overviewGrid(CoinModel coin, BuildContext context){
  return Column(
    children: [
      Row(
        children: [
          DetailChartWidget(
            persentege: coin.priceChangePercentage24H, 
            title: 'Current Price', 
            value: coin.currentPrice.asCurrencyWith2Decimals(),
          ),
          const Spacer(),
          DetailChartWidget(
            persentege: coin.marketCapChangePercentage24H, 
            title: 'Market Capitalizationi', 
            value: coin.marketCap.formattedWithAbbreviations(),
          ),
          const Spacer()
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
      Row(
        children: [
          DetailChartWidget(
            persentege: null, 
            title: 'Rank', 
            value: coin.marketCapRank.toString(),
          ),
          const Spacer(),
          DetailChartWidget(
            persentege: null, 
            title: 'Volumel', 
            value: coin.marketCap.formattedWithAbbreviations(),
          ),
          const Spacer()
        ],
      ),
    ],
  );
}

Widget _additionalGrid(CoinModel coin, BuildContext context){
  return Column(
    children: [
      Row(
        children: [
          DetailChartWidget(
            persentege: null, 
            title: '24h High', 
            value: coin.high24H.asCurrencyWith2Decimals(),
          ),
          const Spacer(),
          DetailChartWidget(
            persentege: null, 
            title: '24h Low', 
            value: coin.low24H.asCurrencyWith2Decimals(),
          ),
          const Spacer()
        ],
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
      Row(
        children: [
          DetailChartWidget(
            persentege: coin.priceChangePercentage24H, 
            title: '24h Price Change', 
            value: coin.priceChange24H!.asCurrencyWith2Decimals(),
          ),
          const Spacer(),
          DetailChartWidget(
            persentege: coin.marketCapChangePercentage24H, 
            title: '24h Market Cap Change', 
            value: coin.marketCapChange24H!.asCurrencyWith2Decimals(),
          ),
          const Spacer()
        ],
      ),
    ],
  );
}