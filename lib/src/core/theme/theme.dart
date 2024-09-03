import 'package:crypto_track/src/core/theme/app_color.dart';
import 'package:crypto_track/src/core/theme/app_font.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData data(bool isDark) {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
          isDark ? AppColor.darkBackground : AppColor.lightBackground,
      primaryColor: AppColor.getPrimaryColor(isDark),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: AppColor.getBackgroundColor(isDark)),
      iconTheme: IconThemeData(color: AppColor.getPrimaryColor(isDark)),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black,),
          backgroundColor:
              isDark ? AppColor.darkBackground : AppColor.lightBackground,
          centerTitle: true,
          titleTextStyle: AppFont.bold.s20.copyWith(color: AppColor.getPrimaryColor(isDark))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? Colors.black : Colors.white,
          textStyle: AppFont.bold.s17,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
          backgroundColor:
              isDark ? AppColor.darkBackground : AppColor.lightBackground),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
          bodySmall: AppFont.normal.s14
              .copyWith(color: AppColor.getSecondaryColor(isDark)),
          bodyMedium: AppFont.bold.s17
              .copyWith(color: AppColor.getPrimaryColor(isDark)),
          bodyLarge: AppFont.bold.s20
              .copyWith(color: AppColor.getPrimaryColor(isDark)),
          titleSmall: AppFont.normal.s25
              .copyWith(color: AppColor.getPrimaryColor(isDark))),
    );
  }
}
