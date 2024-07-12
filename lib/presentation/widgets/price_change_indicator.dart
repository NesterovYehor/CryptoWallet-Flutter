import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class PriceChangeIndicator extends StatelessWidget {
  final double priceChangePercentage;

  const PriceChangeIndicator({
    super.key,
    required this.priceChangePercentage,
  });

  @override
  Widget build(BuildContext context) {
    final isPositive = priceChangePercentage > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isPositive ? greenClr.withOpacity(0.1) : redClr.withOpacity(0.1),
      ),
      child: Text(
        priceChangePercentage.asPercentString(),
        style: titleStyle.copyWith(
          color: isPositive ? greenClr : redClr,
        ),
      ),
    );
  }
}
