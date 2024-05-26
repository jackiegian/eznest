import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class EznestTheme {
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: GoogleFonts.poppins(
        fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall: GoogleFonts.poppins(fontSize: 47, fontWeight: FontWeight.w400),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineSmall: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
    titleLarge: GoogleFonts.poppins(
        fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleSmall: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25), //button
    bodySmall: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelSmall: GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      textTheme: lightTextTheme,
      colorScheme: ColorScheme.fromSeed(seedColor: Color(0x476100)),

    );
  }

  static TextTheme darkTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: Colors.white),
    displayMedium: GoogleFonts.poppins(
        fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: Colors.white),
    displaySmall: GoogleFonts.poppins(fontSize: 47, fontWeight: FontWeight.w400, color: Colors.white),
    headlineMedium: GoogleFonts.poppins(
        fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: Colors.white),
    headlineSmall: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400, color: Colors.white),
    titleLarge: GoogleFonts.poppins(
        fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.white),
    titleMedium: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Colors.white),
    titleSmall: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: Colors.white),
    bodyLarge: GoogleFonts.poppins(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, color: Colors.white),
    bodyMedium: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: Colors.white),
    labelLarge: GoogleFonts.poppins(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: Colors.white), //button
    bodySmall: GoogleFonts.poppins(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: Colors.white),
    labelSmall: GoogleFonts.poppins(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: Colors.white)
  );

  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      textTheme: darkTextTheme,
      colorScheme: ColorScheme.dark(),
    );
  }
}
