import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextBtn extends StatelessWidget {
  AppTextBtn({super.key, required this.color, required this.lable, required this.onTap});

  final Color color;
  final String lable;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color
        ),
        child: Center(
          child: Text(lable, style: titleStyle.copyWith(color: Theme.of(context).colorScheme.background),),
        ),
      ),
    );
  }
}