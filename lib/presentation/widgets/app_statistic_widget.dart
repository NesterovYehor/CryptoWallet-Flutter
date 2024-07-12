import 'package:crypto_track/extensions/double.dart';
import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class AppStatisticWidgets extends StatelessWidget {
  const AppStatisticWidgets({super.key, required this.title, required this.value, required this.percentageChange});

  final String title;
  final String value;
  final double? percentageChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary)),
        Text(value, style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),),
        if (percentageChange != null)
        Text(percentageChange!.asPercentString(), style: subTitleStyle.copyWith(color: percentageChange! > 0 ? greenClr : redClr),)
      ],
    );
  }
}