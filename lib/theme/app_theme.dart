import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Custom Teal Color Palette
  static const Color primaryBlue = Color(0xFF005461);    // Main - Dark Teal
  static const Color primaryCyan = Color(0xFF0C7779);    // Second - Teal
  static const Color accentTeal = Color(0xFF249E94);     // Third - Seafoam
  static const Color accentMint = Color(0xFF3BC1A8);     // Fourth - Mint/Aqua

  // Complementary Accents
  static const Color accentCoral = Color(0xFFFF6B6B);    // Warm accent
  static const Color accentGold = Color(0xFFFFD93D);     // Highlight
  static const Color successGreen = Color(0xFF10B981);   // Success
  static const Color warningAmber = Color(0xFFFBBF24);   // Warning

  // Slate Color Scale (Tailwind)
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020617);

  // Dark Mode Backgrounds
  static const Color darkBg = slate900;
  static const Color darkCard = slate800;
  static const Color darkBorder = Color(0xFF334155);

  // Light Mode Backgrounds
  static const Color lightBg = slate50;
  static const Color lightCard = Colors.white;
  static const Color lightBorder = Color(0xFFE2E8F0);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    scaffoldBackgroundColor: lightBg,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: primaryCyan,
      tertiary: accentTeal,
      surface: lightCard,
      onSurface: slate900,
      onPrimary: Colors.white,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: slate900,
        letterSpacing: -2,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: slate900,
        letterSpacing: -1,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: slate900,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: slate900,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: slate800,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: slate600,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: slate500,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: slate500,
        letterSpacing: 2,
      ),
    ),
    cardTheme: CardThemeData(
      color: lightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: lightBorder),
      ),
    ),
    dividerColor: lightBorder,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryCyan,
    scaffoldBackgroundColor: darkBg,
    colorScheme: const ColorScheme.dark(
      primary: primaryCyan,
      secondary: accentTeal,
      tertiary: accentMint,
      surface: darkCard,
      onSurface: Colors.white,
      onPrimary: Colors.white,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(ThemeData.dark().textTheme)
        .copyWith(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 56,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: -2,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: -1,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: slate200,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: slate400,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: slate500,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: slate400,
        letterSpacing: 2,
      ),
    ),
    cardTheme: CardThemeData(
      color: darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: darkBorder),
      ),
    ),
    dividerColor: darkBorder,
  );

  // Gradients - Your custom teal palette
  static LinearGradient get primaryGradient => const LinearGradient(
        colors: [primaryBlue, accentMint],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static LinearGradient get tealGradient => const LinearGradient(
        colors: [primaryCyan, accentTeal],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static LinearGradient get mintGradient => const LinearGradient(
        colors: [accentTeal, accentMint],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  static LinearGradient get fullGradient => const LinearGradient(
        colors: [primaryBlue, primaryCyan, accentTeal, accentMint],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );

  // Glass effect colors
  static Color glassLight = Colors.white.withValues(alpha: 0.7);
  static Color glassDark = slate900.withValues(alpha: 0.6);
  static Color glassBorderLight = Colors.white.withValues(alpha: 0.2);
  static Color glassBorderDark = Colors.white.withValues(alpha: 0.05);

  // Hover/Active states
  static Color hoverLight = primaryCyan.withValues(alpha: 0.05);
  static Color hoverDark = primaryCyan.withValues(alpha: 0.1);
  static Color activeLight = primaryCyan.withValues(alpha: 0.1);
  static Color activeDark = primaryCyan.withValues(alpha: 0.2);
}
