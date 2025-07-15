import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class AppTheme {
  // Primary color palette
  static const Color primaryColor = Color(0xFF2E7D32); // Dark Green
  static const Color primaryLight = Color(0xFF60AD5E);
  static const Color primaryDark = Color(0xFF005005);
  
  // Secondary color palette
  static const Color secondaryColor = Color(0xFFFFC107); // Amber
  static const Color secondaryLight = Color(0xFFFFF350);
  static const Color secondaryDark = Color(0xFFC79100);
  
  // Status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);
  static const Color infoColor = Color(0xFF2196F3);
  
  // Text colors
  static const Color primaryTextColor = Color(0xFF212121);
  static const Color secondaryTextColor = Color(0xFF757575);
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.black87;
  
  // Background colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color surfaceColor = Colors.white;
  static const Color disabledColor = Color(0xFFBDBDBD);
  
  // Border radius
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;
  
  // Spacing
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // App bar theme
  static AppBarTheme get appBarTheme {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  
  // Button theme
  static ButtonThemeData get buttonTheme {
    return ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      buttonColor: primaryColor,
      textTheme: ButtonTextTheme.primary,
    );
  }
  
  // Text theme
  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryTextColor),
      displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryTextColor),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primaryTextColor),
      headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: primaryTextColor),
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: primaryTextColor),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: primaryTextColor),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: primaryTextColor),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: secondaryTextColor),
      bodyLarge: TextStyle(fontSize: 16, color: primaryTextColor),
      bodyMedium: TextStyle(fontSize: 14, color: primaryTextColor),
      bodySmall: TextStyle(fontSize: 12, color: secondaryTextColor),
    );
  }
  
  // Input decoration theme
  static InputDecorationTheme get inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMedium,
        vertical: spacingSmall,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
        borderSide: const BorderSide(color: errorColor, width: 2),
      ),
      labelStyle: const TextStyle(color: secondaryTextColor),
      hintStyle: TextStyle(color: Colors.grey[500]),
      errorStyle: const TextStyle(color: errorColor),
    );
  }
  
  // Card theme
  static CardTheme get cardTheme {
    return CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      margin: const EdgeInsets.all(spacingSmall),
    );
  }
  
  // Apply theme to the app
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: errorColor,
        onPrimary: textOnPrimary,
        onSecondary: textOnSecondary,
        onSurface: primaryTextColor,
        onBackground: primaryTextColor,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      appBarTheme: appBarTheme,
      buttonTheme: buttonTheme,
      textTheme: textTheme,
      inputDecorationTheme: inputDecorationTheme,
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: cardTheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
  
  // Get a custom elevated button style
  static ButtonStyle getElevatedButtonStyle({Color? backgroundColor, Color? foregroundColor}) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? primaryColor,
      foregroundColor: foregroundColor ?? Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      elevation: 2,
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  
  // Get a custom outlined button style
  static ButtonStyle getOutlinedButtonStyle({Color? borderColor, Color? textColor}) {
    return OutlinedButton.styleFrom(
      foregroundColor: textColor ?? primaryColor,
      side: BorderSide(color: borderColor ?? primaryColor),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  
  // Get a custom text button style
  static ButtonStyle getTextButtonStyle({Color? textColor}) {
    return TextButton.styleFrom(
      foregroundColor: textColor ?? primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
