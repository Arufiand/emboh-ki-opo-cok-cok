import 'package:flutter/material.dart';
import 'package:epms_flutter/src/common/styles/app_colors.dart';

/// A class to define and centralize all application-wide text styles.
/// This promotes consistency in typography across the entire application,
/// makes global font changes easy, and adheres to the **DRY (Don't Repeat Yourself)** principle.
///
/// It uses the new Material 3 typography scale (display, headline, title, body, label).
class AppTextStyles {
  // Define a default TextTheme for your application.
  // This will be applied globally via ThemeData.textTheme.
  static const TextTheme textTheme = TextTheme(
    // Display styles are for very large, short, and impactful text.
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400, // Regular
      color: AppColors.textColorPrimary,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),

    // Headline styles are for large, high-emphasis text.
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),

    // Title styles are for shorter, medium-emphasis text.
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500, // Medium weight for titles
      color: AppColors.textColorPrimary,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorPrimary,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorPrimary,
    ),

    // Body styles are for longer, lower-emphasis text.
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorPrimary,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.textColorSecondary, // Often a lighter color for less important text
    ),

    // Label styles are for text used in components like buttons, input fields, etc.
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorSecondary,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: AppColors.textColorSecondary,
    ),
  );

  // You can also define specific, custom text styles for common use cases
  // that might not fit perfectly into the Material 3 scale or need unique properties.
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white, // White text on colored buttons
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryColor,
    decoration: TextDecoration.underline,
  );

// Add more custom text styles as needed, keeping them consistent.
// Example:
// static const TextStyle errorTextStyle = TextStyle(
//   fontSize: 13,
//   color: AppColors.error,
//   fontStyle: FontStyle.italic,
// );
}
