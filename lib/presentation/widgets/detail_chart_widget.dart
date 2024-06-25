
import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class DetailChartWidget extends StatelessWidget {
  const DetailChartWidget({super.key, required this.title, required this.value, required this.persentege});

  final String title;
  final String value;
  final double? persentege;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),),
        Text(value, style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
        if (persentege != null)
        Row(
          children: [
            Icon(persentege! < 0 ? Icons.trending_down : Icons.trending_up, 
              color: persentege! < 0 ? redClr : greenClr,),
              Text(persentege!.asPercentString(), style: subTitleStyle.copyWith(color: persentege! < 0 ? redClr : greenClr,),)
          ],
        )
      ],
    );
  }
}