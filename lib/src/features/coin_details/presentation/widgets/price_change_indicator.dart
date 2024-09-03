import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
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
        color: isPositive
            ? AppColor.greenClr.withOpacity(0.1)
            : AppColor.redClr.withOpacity(0.1),
      ),
      child: Text(
        context.loc.asPercentString(priceChangePercentage),
        style: AppFont.bold.s17.copyWith(
          color: isPositive ? AppColor.greenClr : AppColor.redClr,
        ),
      ),
    );
  }
}
