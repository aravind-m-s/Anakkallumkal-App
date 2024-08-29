import 'package:anakallumkal_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

getThemeData(bool isDarkMode) {
  if (isDarkMode) {
    return ThemeData.dark().copyWith(
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFFCFCCE5),
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          color: Color(0xFFCFCCE5),
          fontWeight: FontWeight.normal,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFCFCCE5),
        ),
      ),
      scaffoldBackgroundColor: const Color(0xFF24293D),
      dividerColor: const Color(0xFF45495E),
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: const Color(0xFF323a54),
      iconTheme: const IconThemeData(color: Color(0xFFCFCCE5)),
    );
  } else {
    return ThemeData.light().copyWith(
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: Color(0xFF28282A),
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          color: Color(0xFF28282A),
          fontWeight: FontWeight.normal,
        ),
        titleSmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF28282A),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      dividerColor: const Color(0xFFE2E2E2),
      primaryColor: AppColors.primaryColor,
      secondaryHeaderColor: const Color(0xFFF7F8FA),
      iconTheme: const IconThemeData(
        color: Color(0xFF28282A),
      ),
    );
  }
}
