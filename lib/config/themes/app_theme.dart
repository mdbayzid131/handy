import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static ThemeData get lightTheme => LightTheme.theme;
  static ThemeData get darkTheme => DarkTheme.theme;

  // Common colors
  static const Color backgroundColor = Color(0xFF0D1535);
  static const Color primaryColor = Color(0xFF0B2CB3); //bluecontainerColor
  static const Color containerColor = Color(0xFF1E2336); //gracontainerColor
  static const Color secondaryColor = Color(0x0DFFFFFF); //BorderColor
  static const Color warningColor = Color(0xFFFBBF24); //yellowColor
  static const Color successColor = Color(0xFF4CAF50);
  static const Color watchLiveColor = Color(0xFFFF5722);
  static const Color errorColor = Color(0xFFB00020);

  // Added refactored colors
  static const Color cardColor = Color(0xFF1A2340);
  static const Color primaryLighter = Color(0xFF2844B4);
  static const Color primaryDarker = Color(0xFF0A123D);
  static const Color mutedTextColor = Color(0xFF8E99AF);
  static const Color accentYellow = Color(0xFFFFC107);
  static const Color accentBlue = Color(0xFF3B68E7);
}
