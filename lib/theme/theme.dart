import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const greenClr = Color(0xFF10DC78);
const redClr = Color.fromARGB(255, 251, 46, 145);
const whiteClr = Colors.white;
const blueclr = Color(0xFF00BDB0);

class Themes{
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.black,
      background: Color(0xFFF8F8F8),
      secondary: Color.fromARGB(255, 145, 145, 145),
      secondaryContainer: Colors.white
    )  
  );

  static final dark = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      background: Color(0xFF141B29),
      secondary: Color.fromARGB(255, 208, 208, 208),
      secondaryContainer: Color(0x33484D58)
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
      fontSize: 25,
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
    )
  );
}