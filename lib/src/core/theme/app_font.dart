import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  AppFont._();

  static TextStyle normal = GoogleFonts.lato(fontWeight: FontWeight.normal);
  static TextStyle bold = GoogleFonts.lato(fontWeight: FontWeight.bold);
}

extension AppFontSize on TextStyle {
  TextStyle get s14 {
    return copyWith(fontSize: 14.sp);
  }

  TextStyle get s17 {
    return copyWith(fontSize: 17.sp);
  }

  TextStyle get s20 {
    return copyWith(fontSize: 20.sp);
  }

  TextStyle get s25 {
    return copyWith(fontSize: 25.sp);
  }
}