import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:crypto_track/src/features/coins/domain/entities/coin_entity.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AppChartWidget extends StatelessWidget {
  final List<double> data;
  final double maxY;
  final double minY;
  final Color lineColor;
  final DateTime startingDate;
  final DateTime endingDate;
  final double width;
  final double height;
  final bool showDates;
  final double barWidth;

  AppChartWidget({
    super.key,
    required this.coin,
    required this.width,
    required this.height,
    required this.showDates,
    required this.barWidth,
  })  : data = coin.sparklineIn7D?.price ?? [],
        maxY = (coin.sparklineIn7D?.price ?? []).isNotEmpty
            ? (coin.sparklineIn7D?.price ?? []).reduce((a, b) => a > b ? a : b)
            : 0,
        minY = (coin.sparklineIn7D?.price ?? []).isNotEmpty
            ? (coin.sparklineIn7D?.price ?? []).reduce((a, b) => a < b ? a : b)
            : 0,
        lineColor = ((coin.sparklineIn7D?.price ?? []).isNotEmpty &&
                (coin.sparklineIn7D?.price ?? []).last >
                    (coin.sparklineIn7D?.price ?? []).first)
            ? AppColor.blueClr
            : AppColor.redClr,
        endingDate = coin.lastUpdated,
        startingDate = coin.lastUpdated.subtract(const Duration(days: 7));

  final CoinEntity coin;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = AppColor.getSecondaryColor(
      context.select((ThemeBloc bloc) => bloc.state.isDarkMode),
    );
    return Column(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: LineChart(
            LineChartData(
              lineTouchData: const LineTouchData(enabled: false),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              minX: 0,
              maxX: data.length.toDouble() - 1,
              minY: minY,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: data.asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), e.value);
                  }).toList(),
                  isCurved: true,
                  color: lineColor,
                  barWidth: barWidth,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        lineColor.withOpacity(0.5),
                        lineColor.withOpacity(0)
                      ],
                      stops: const [0.1, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    color: lineColor.withOpacity(0.2),
                  ),
                  shadow: Shadow(
                    color: lineColor,
                    blurRadius: 20,
                    offset: const Offset(2, 2),
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 150),
            curve: Curves.linear,
          ),
        ),
        if (showDates)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMd().format(startingDate),
                    style: AppFont.normal.s14.copyWith(color: secondaryColor)),
                Text(DateFormat.yMd().format(endingDate),
                    style: AppFont.normal.s14.copyWith(color: secondaryColor)),
              ],
            ),
          ),
      ],
    );
  }
}
