import 'package:crypto_track/src/core/extensions/buildcontext.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';

class DetailChartWidget extends StatelessWidget {
  const DetailChartWidget(
      {super.key,
      required this.title,
      required this.value,
      required this.percentage});

  final String title;
  final String value;
  final double? percentage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.bodySmall),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (percentage != null)
          Row(
            children: [
              Icon(
                percentage! < 0 ? Icons.trending_down : Icons.trending_up,
                color: percentage! < 0 ? AppColor.redClr : AppColor.greenClr,
              ),
              Text(context.loc.asPercentString(percentage ?? 0),
                  style: AppFont.normal.s14.copyWith(
                    color:
                        percentage! < 0 ? AppColor.redClr : AppColor.greenClr,
                  ))
            ],
          )
      ],
    );
  }
}
