import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900, //backgorund
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 57, 57, 57),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
);
