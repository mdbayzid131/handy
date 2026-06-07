import 'package:flutter/material.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static ThemeData get lightTheme => LightTheme.theme;
  static ThemeData get darkTheme => DarkTheme.theme;

  // Common colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color backgroundColor = Color(0xFF0D1535);
  static const Color primaryColor = Color(0xFF0B2CB3); //bluecontainerColor
  static const Color containerColor = Color(0xFF1A2D6E); // Soft, elegant blue container
  static const Color secondaryColor = Color(0xFF3B56AD); // Lighter blue border for contrast
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

  // Dark/Navy variants
  static const Color darkNavy = Color(0xFF091244);
  static const Color navyBlue = Color(0xFF142470);
  static const Color deepBlackBlue = Color(0xFF0B101E);
  static const Color darkCardVariant = Color(0xFF1A223E);
  static const Color darkSlate = Color(0xFF2A3355);
  static const Color slateBlue = Color(0xFF384370);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color cardVariantLight = Color(0xFF1B233D);
  static const Color cardVariantLighter = Color(0xFF1E2846);

  // Blues
  static const Color brightBlue = Color(0xFF4A72FF);
  static const Color brightBlueDark = Color(0xFF284EE6);
  static const Color lightBlue = Color(0xFF64B5F6);
  static const Color standardBlue = Color(0xFF1976D2);
  static const Color indigo = Color(0xFF2F45D1);
  static const Color royalBlue = Color(0xFF476BFF);

  // Reds
  static const Color lightRed = Color(0xFFFF6B6B);
  static const Color standardRed = Color(0xFFFF4747);
  static const Color accentRed = Color(0xFFFF5252);
  static const Color pinkRed = Color(0xFFFF416C);
  static const Color coralRed = Color(0xFFE54148);
  static const Color red600 = Color(0xFFE53935);
  static const Color red700 = Color(0xFFD32F2F);
  static const Color red800 = Color(0xFFC62828);
  static const Color red500 = Color(0xFFF44336);
  static const Color deepRed = Color(0xFF5D0000);

  // Oranges
  static const Color standardOrange = Color(0xFFFF9800);
  static const Color darkOrange = Color(0xFFF57C00);
  static const Color lightDeepOrange = Color(0xFFFF7043);
  static const Color darkDeepOrange = Color(0xFFE64A19);
  static const Color lightOrange = Color(0xFFFFB74D);
  static const Color burntOrange = Color(0xFFDD6120);
  static const Color orange500 = Color(0xFFF97316);

  // Purples
  static const Color lightPurple = Color(0xFFD088FF);
  static const Color standardPurple = Color(0xFFA64DFF);
  static const Color purple300 = Color(0xFFCE93D8);
  static const Color purple800 = Color(0xFF8E24AA);
  static const Color purple900 = Color(0xFF6A1B9A);
  static const Color deepPurple = Color(0xFF7524AA);

  // Teals / Greens
  static const Color lightTeal = Color(0xFF4DB6AC);
  static const Color standardTeal = Color(0xFF00897B);
  static const Color teal400 = Color(0xFF26A69A);
  static const Color darkTeal = Color(0xFF00796B);
  static const Color tealAccent = Color(0xFF00BFA5);
  static const Color deepTeal = Color(0xFF0F8A74);
  static const Color teal800 = Color(0xFF00695C);

  static const Color lightGreen = Color(0xFF66BB6A);
  static const Color standardGreen = Color(0xFF388E3C);
  static const Color green300 = Color(0xFF81C784);
  static const Color greenAccent = Color(0xFF00E676);

  // Yellows
  static const Color yellowAccentVariant = Color(0xFFFFB800);

  // Greys/BlueGreys
  static const Color blueGreyLight = Color(0xFFB0BEC5);
  static const Color blueGreyDark = Color(0xFF607D8B);
  static const Color mutedTextVariant = Color(0xFF8C93A8);
}
