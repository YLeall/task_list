import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );
}

TextStyle get subtTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.grey[400],
    ),
  );
}


TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}
