import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppIconBtn extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  const AppIconBtn({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select((ThemeBloc bloc) => bloc.state.isDarkMode);
    return Container(
      decoration: BoxDecoration(
        color: AppColor.getBackgroundColor(isDarkMode),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColor.getBackgroundColor(!isDarkMode).withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 0), 
          ),
        ],
      ),
      child: IconButton(
        iconSize: 24.0,
        padding: const EdgeInsets.all(8.0),
        onPressed: onPressed,
        icon: Icon(
          icon,
        ),
      ),
    );
  }
}
