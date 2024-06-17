import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const greenClr = Color.fromARGB(255, 0, 143, 0);
const redClr = Color.fromARGB(255, 251, 46, 145);
const white = Colors.white;
const blueclr = Color.fromARGB(255, 128, 168, 221);

class Themes{
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      background: Colors.white,
      secondary: Color.fromARGB(255, 145, 145, 145)
    )  
  );

  static final dark = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 250, 207, 252),
      background: Colors.black,
      secondary: Color.fromARGB(255, 192, 192, 192)
    ) 
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    )
  );
}