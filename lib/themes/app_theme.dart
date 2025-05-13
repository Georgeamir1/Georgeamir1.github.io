import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // DeveloperFolio inspired colors
  static const Color primaryColor = Color(0xFF0A192F); // Dark blue
  static const Color secondaryColor = Color(0xFF64FFDA); // Teal
  static const Color textColor = Color(0xFFE6F1FF); // Light blue-white
  static const Color subTextColor = Color(0xFF8892B0); // Gray-blue
  static const Color cardColor = Color(0xFF172A45); // Slightly lighter blue
  static const Color buttonColor = Color(0xFF64FFDA); // Teal
  static const Color buttonTextColor = Color(0xFF0A192F); // Dark blue
  static const Color navbarColor = Color(0xFF0A192F); // Dark blue
  static const Color shadowColor = Color(0xFF64FFDA); // Teal

  // Light theme colors
  static const Color lightPrimaryColor = Color(0xFFFFFFFF); // White
  static const Color lightSecondaryColor = Color(0xFF6D83F2); // Purple
  static const Color lightTextColor = Color(0xFF303030); // Dark gray
  static const Color lightSubTextColor = Color(0xFF7F8DAA); // Gray-blue
  static const Color lightCardColor = Color(0xFFF4F6F8); // Light gray
  static const Color lightButtonColor = Color(0xFF6D83F2); // Purple
  static const Color lightButtonTextColor = Color(0xFFFFFFFF); // White
  static const Color lightNavbarColor = Color(0xFFFFFFFF); // White
  static const Color lightShadowColor = Color(0xFF6D83F2); // Purple

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryColor,
    scaffoldBackgroundColor: lightPrimaryColor,
    cardColor: lightCardColor,
    shadowColor: lightShadowColor.withAlpha(25),
    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 56.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: lightTextColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.montserrat(
        color: lightSubTextColor,
        fontSize: 16.0,
      ),
      bodyMedium: GoogleFonts.montserrat(
        color: lightSubTextColor,
        fontSize: 14.0,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: lightSecondaryColor,
      secondary: lightSecondaryColor,
      onPrimary: lightPrimaryColor,
      onSecondary: lightPrimaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: lightNavbarColor,
      elevation: 0,
      foregroundColor: lightTextColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: lightButtonColor,
        foregroundColor: lightButtonTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: primaryColor,
    cardColor: cardColor,
    shadowColor: shadowColor.withAlpha(25),
    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 56.0,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: GoogleFonts.montserrat(
        color: textColor,
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.montserrat(color: subTextColor, fontSize: 16.0),
      bodyMedium: GoogleFonts.montserrat(color: subTextColor, fontSize: 14.0),
    ),
    colorScheme: ColorScheme.dark(
      primary: secondaryColor,
      secondary: secondaryColor,
      onPrimary: primaryColor,
      onSecondary: primaryColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: navbarColor,
      elevation: 0,
      foregroundColor: textColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: buttonTextColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  );

  // Card decoration
  static BoxDecoration cardDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? cardColor : lightCardColor,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color:
              isDark
                  ? shadowColor.withAlpha(25)
                  : lightShadowColor.withAlpha(25),
          blurRadius: 10,
          spreadRadius: 1,
        ),
      ],
    );
  }

  // Button decoration
  static BoxDecoration buttonDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: isDark ? secondaryColor : lightSecondaryColor,
        width: 2,
      ),
    );
  }

  // Section decoration
  static BoxDecoration sectionDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      color: isDark ? primaryColor : lightPrimaryColor,
      borderRadius: BorderRadius.circular(8),
    );
  }

  // Neon box decoration
  static BoxDecoration neonBoxDecoration(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color:
              isDark
                  ? Colors.cyanAccent.withOpacity(0.4)
                  : Colors.deepPurple.withOpacity(0.2),
          blurRadius: 16,
          spreadRadius: 2,
        ),
      ],
    );
  }
}
