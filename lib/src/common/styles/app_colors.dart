// lib/src/common/styles/app_colors.dart

import 'package:flutter/material.dart';

/// A class to define and centralize all application-wide color constants.
/// This promotes consistency in UI design and makes color changes easy.
class AppColors {
  // Primary Color Palette
  static const Color primaryColor = Color(0xFF42A5F5); // A shade of blue
  static const Color primaryLight = Color(0xFF80D6FF);
  static const Color primaryDark = Color(0xFF0077C2);

  // Accent Color
  static const Color accentColor = Color(0xFFFFC107); // A shade of amber

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color darkGrey = Color(0xFF616161);

  // Semantic Colors (for feedback)
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color error = Color(0xFFF44336);   // Red
  static const Color warning = Color(0xFFFFEB3B); // Yellow
  static const Color info = Color(0xFF2196F3);    // Blue

  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5); // Light grey background

  // Text Colors
  static const Color textColorPrimary = Color(0xFF212121); // Dark grey for primary text
  static const Color textColorSecondary = Color(0xFF757575); // Medium grey for secondary text

  // You can also define a MaterialColor swatch for your primary color
  static const MaterialColor primaryMaterialColor = MaterialColor(
    0xFF42A5F5, // Primary color value
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF2196F3),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
