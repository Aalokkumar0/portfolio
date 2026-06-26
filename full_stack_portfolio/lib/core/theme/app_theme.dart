import 'package:flutter/material.dart';

class AppTheme {
  // Font
  static const String fontFamily = 'Outfit';

  // ── Cotton Candy Skies Palette ──────────────────────────────
  static const Color lavender    = Color(0xFFB298E7); // primary
  static const Color mintCyan    = Color(0xFFB8E3E9); // secondary
  static const Color blushPink   = Color(0xFFF5B8D5); // tertiary
  static const Color softPink    = Color(0xFFF9BEDD); // accent

  // Backgrounds — dreamy cream/white
  static const Color scaffoldBg  = Color(0xFFFDF8FF); // near-white with lavender tint
  static const Color surfaceColor = Color(0xFFF5EEFF); // soft lavender surface
  static const Color cardBg      = Color(0xFFFFFFFF);  // pure white cards

  // Text
  static const Color textPrimary   = Color(0xFF2D1B69); // deep purple for headings
  static const Color textSecondary = Color(0xFF6B5B8A); // muted purple body
  static const Color textMuted     = Color(0xFF9B8FBB); // light muted

  // Shadows
  static const Color shadowColor = Color(0xFFB298E7);

  // ── Gradients ──────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [lavender, blushPink],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFF0E8FF), Color(0xFFFFE8F5), Color(0xFFE8F9FB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFFFFFFF), Color(0xFFF9F0FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [lavender, mintCyan],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: scaffoldBg,
      colorScheme: const ColorScheme.light(
        primary: lavender,
        secondary: mintCyan,
        tertiary: blushPink,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: textPrimary,
        onSurface: textPrimary,
        onTertiary: textPrimary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        foregroundColor: textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 96,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: 2,
          height: 1,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 72,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: 1.5,
          height: 1,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: 1,
          height: 1.1,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: textSecondary,
          height: 1.7,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: textMuted,
          height: 1.6,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.5,
          color: textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: lavender,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          elevation: 0,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 1.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: lavender, width: 2),
          foregroundColor: lavender,
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 13,
            letterSpacing: 1.5,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8D8FF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE8D8FF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: lavender, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: const TextStyle(
          color: textMuted,
          fontFamily: fontFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFEEE0FF),
        thickness: 1,
      ),
      useMaterial3: true,
    );
  }

  // Dark still maps to light for this portfolio (candy theme is always light)
  static ThemeData get darkTheme => lightTheme;
}
