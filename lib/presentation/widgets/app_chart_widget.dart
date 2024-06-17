import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:crypto_track/theme/theme.dart';  
import 'package:crypto_track/data/models/coin_model.dart';

class AppChartWidget extends StatelessWidget {
  final List<double> data;
  final double maxY;
  final double minY;
  final Color lineColor;
  final DateTime startingDate;
  final DateTime endingDate;

  AppChartWidget({super.key, required this.coin})
      : data = coin.sparklineIn7D?.price ?? [],
        maxY = (coin.sparklineIn7D?.price ?? []).isNotEmpty
            ? (coin.sparklineIn7D?.price ?? []).reduce((a, b) => a > b ? a : b)
            : 0,
        minY = (coin.sparklineIn7D?.price ?? []).isNotEmpty
            ? (coin.sparklineIn7D?.price ?? []).reduce((a, b) => a < b ? a : b)
            : 0,
        lineColor = ((coin.sparklineIn7D?.price ?? []).isNotEmpty &&
                (coin.sparklineIn7D?.price ?? []).last >
                    (coin.sparklineIn7D?.price ?? []).first)
            ? greenClr
            : redClr,
        endingDate = coin.lastUpdated,
        startingDate = coin.lastUpdated.subtract(const Duration(days: 7));

  final CoinModel coin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: AnimatedPositionedDirectional(
            duration: const Duration(minutes: 1),
            curve: Curves.easeInOut,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: false),
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(
                  show: false,
                ),
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
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: false,
                      color: lineColor.withOpacity(0.3),
                    ),
                    shadow: Shadow(
                      color: lineColor,
                      blurRadius: 20,
                      offset: const Offset(2, 2)
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat.yMd().format(startingDate)),
              Text(DateFormat.yMd().format(endingDate)),
            ],
          ),
        ),
      ],
    );
  }
}
