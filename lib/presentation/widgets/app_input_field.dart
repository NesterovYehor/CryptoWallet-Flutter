import 'package:crypto_track/theme/theme.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key, 
    required this.controller, 
    required this.hint, 
    required this.title, 
    required this.obscureText, 
    required this.icon,
    required this.onChanged
  });

  final TextEditingController controller;
  final String hint;
  final String title;
  final bool obscureText;
  final IconData icon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: subTitleStyle,),
        Row(
          children: [
            Expanded(
              child: TextField(
                obscureText: obscureText,
                autocorrect: false,
                controller: controller,
                onChanged: onChanged,
                style: titleStyle.copyWith(color: Theme.of(context).colorScheme.primary),
                decoration: InputDecoration(
                  prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary,),
                  hintText: hint,
                  hintStyle: titleStyle.copyWith(color: Theme.of(context).colorScheme.secondary),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 0
                    )
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 0
                    )
                  )
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}