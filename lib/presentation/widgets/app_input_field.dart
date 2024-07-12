import 'package:flutter/material.dart';
import 'package:crypto_track/theme/theme.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.title,
    required this.obscureText,
    required this.icon,
    required this.onChanged,
    this.textFieldHeight = 50.0, 
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final String title;
  final bool obscureText;
  final IconData icon;
  final Function(String)? onChanged;
  final double textFieldHeight; 

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: subTitleStyle.copyWith(color: Theme.of(context).colorScheme.secondary)),
        SizedBox(
          height: textFieldHeight, 
          child: TextField(
            obscureText: obscureText,
            autocorrect: false,
            controller: controller,
            onChanged: onChanged,
            style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10.0), // Adjust internal padding
              prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
              hintText: hint,
              hintStyle: titleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
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
                  color: Theme.of(context).colorScheme.secondary,
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
