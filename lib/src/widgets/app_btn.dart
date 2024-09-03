import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({super.key, required this.label, required this.onTap});

  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
      ),
      child: Text(label, style: Theme.of(context).textTheme.bodyMedium,),
    );
  }
}
