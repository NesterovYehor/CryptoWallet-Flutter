import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/logo.png", width: width,);
  }
}