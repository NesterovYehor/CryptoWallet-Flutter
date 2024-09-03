import 'package:crypto_track/src/configs%20/injector/injector.dart';
import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
    required this.obscureText,
    required this.icon,
    this.textFieldHeight = 50.0,
  });

  final TextEditingController controller;
  final String hint;
  final String title;
  final bool obscureText;
  final IconData icon;
  final double textFieldHeight;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.read<ThemeBloc>().state.isDarkMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppFont.normal.s14
                .copyWith(color: AppColor.getSecondaryColor(isDarkMode))),
        SizedBox(
          height: textFieldHeight,
          child: TextField(
            obscureText: obscureText,
            autocorrect: false,
            controller: controller,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0), // Adjust internal padding
              prefixIcon:
                  Icon(icon),
              hintText: hint,
              hintStyle: AppFont.normal.s14
                  .copyWith(color: AppColor.getSecondaryColor(isDarkMode)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: AppColor.getSecondaryColor(isDarkMode),
                  width: 0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
