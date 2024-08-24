import 'package:currency_converter/ui/theme/app_colors.dart';
import 'package:currency_converter/ui/theme/font.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final baseTheme = ThemeData.from(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        secondary: AppColors.background,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );

    final theme = baseTheme.copyWith(
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          minimumSize: const Size(42, 42),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(42, 42),
        ),
      ),
      appBarTheme: const AppBarTheme().copyWith(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: FontColor.black,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.roboto(
          fontSize: 57,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
        displayMedium: GoogleFonts.roboto(
          fontSize: 45,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
        displaySmall: GoogleFonts.roboto(
          fontSize: 36,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
        headlineLarge: GoogleFonts.roboto(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: FontColor.black,
        ),
        headlineMedium: GoogleFonts.roboto(
          fontSize: 38,
          fontWeight: FontWeight.bold,
          color: FontColor.black,
        ),
        headlineSmall: GoogleFonts.roboto(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: FontColor.black,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: AppColors.ash,
        ),
        titleMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: FontColor.black,
        ),
        titleSmall: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: FontColor.black,
        ),
        labelLarge: const TextStyle(
          color: AppColors.ash,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        labelMedium: const TextStyle(
          color: AppColors.ash,
          fontSize: 12,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
        labelSmall: GoogleFonts.roboto(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: FontColor.black,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: FontColor.black,
        ),
      ),
    );
    return theme;
  }
}
