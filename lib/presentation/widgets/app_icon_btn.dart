import 'package:flutter/material.dart';

class AppIconBtn extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;

  AppIconBtn({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background, 
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5), 
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 0), 
          ),
        ],
      ),
      child: IconButton(
        iconSize: 24.0,
        padding: const EdgeInsets.all(8.0),
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Theme.of(context).colorScheme.primary, 
        ),
      ),
    );
  }
}
