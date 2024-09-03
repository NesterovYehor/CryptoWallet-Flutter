import 'dart:ui';
import 'package:flutter/material.dart';

class AppColor{
  static Color getSecondaryColor(bool isDarkMode) {
    return isDarkMode ? _darkSecondary : _lightSecondary;
  }
  static Color getBackgroundColor(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  
  static Color getContainerColor(bool isDark) =>
      isDark ? const Color.fromARGB(255, 29, 37, 50) : Colors.white;

  static Color getPrimaryColor(bool isDark) =>
      isDark ? Colors.white : Colors.black;

  static Color getTextColor(bool isDark) =>
      isDark ? Colors.white : Colors.black;

  static const greenClr = Color(0xFF10DC78);
  static const redClr = Color.fromARGB(255, 251, 46, 145);
  static const whiteClr = Colors.white;
  static const blueClr = Color(0xFF00BDB0);
  static const darkBackground = Color(0xFF141B29);
  static const lightBackground = Color(0xFFF8F8F8);
  static const _lightSecondary = Color.fromARGB(255, 145, 145, 145);
  static const _darkSecondary = Color.fromARGB(255, 208, 208, 208);
}