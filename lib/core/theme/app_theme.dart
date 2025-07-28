// lib/core/theme/app_theme.dart (UPDATED)

import 'package:flutter/material.dart';

class AppColors {
  // Warna utama (Relatif aman karena biru)
  static const primary = Color(0xFF0A6EBD); // Biru utama
  static const secondary = Color(0xFF40A2E3); // Biru terang
  static const header = Color(0xFF003566); // Biru tua untuk header

  // FIX: Warna Aksen yang lebih aman untuk buta warna dan interaktif
  // Menggunakan warna yang cukup kontras dan berbeda dari warna status utama.
  static const accent = Color(
      0xFFF9A825); // Oranye keemasan, lebih menonjol dan berbeda dari biru

  // FIX: Warna Netral dan Background dengan kontras baik
  static const background =
      Color(0xFFF0F2F5); // Sedikit lebih gelap dari F5F5F5, kontras lebih baik
  static const scaffold = Color(0xFFFFFFFF); // Putih bersih
  static const surface =
      Color(0xFFE0E0E0); // Abu-abu terang untuk kartu/permukaan
  static const border = Color(0xFFBFBFBF); // Warna border yang lebih terlihat

  // FIX: Warna Teks dengan kontras yang kuat
  static const textPrimary = Color(0xFF212121); // Hampir hitam, kontras tinggi
  static const textSecondary =
      Color(0xFF616161); // Abu-abu gelap, kontras cukup
  static const textInverse =
      Colors.white; // Putih untuk teks di latar belakang gelap

  // FIX: Warna Status yang mendukung buta warna parsial
  // Gunakan warna dengan Hue yang berbeda jauh dan sertakan indikator visual lain.
  static const success = Color(0xFF388E3C); // Hijau tua yang lebih kebiruan
  static const warning = Color(0xFFFFB300); // Kuning-oranye yang jelas
  static const error = Color(0xFFD32F2F); // Merah bata yang lebih gelap
  static const info = Color(0xFF1976D2); // Biru sedang
}

class AppTextStyles {
  // FIX: Pastikan warna teks menggunakan AppColors yang baru
  static const heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );

  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textInverse,
  );

  static const caption = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.scaffold,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.header,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.textInverse,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.textInverse),
    ),
    cardColor: AppColors.surface,
    dividerColor: AppColors.border,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
      // FIX: Tambahkan onPrimary, onSecondary, dll.
      // Ini penting untuk TextTheme dan IconTheme default pada ColorScheme.
      onPrimary: AppColors.textInverse, // Teks di atas primary
      onSecondary: AppColors.textInverse, // Teks di atas secondary
      onSurface: AppColors.textPrimary, // Teks di atas background
      onError: AppColors.textInverse, // Teks di atas error
    ),
    textTheme: const TextTheme(
      // FIX: Gunakan headlineLarge/Medium, bodyLarge/Medium/Small, dll.
      // Sesuaikan dengan yang ada di AppTextStyles
      headlineLarge: AppTextStyles.heading1,
      headlineMedium: AppTextStyles.heading2,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.body,
      labelLarge: AppTextStyles.button, // Untuk tombol
      bodySmall: AppTextStyles.caption,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textInverse,
        textStyle: AppTextStyles.button,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        // FIX: Tambahkan visual feedback untuk interaktivitas
        // Misalnya, ubah elevation saat ditekan
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.4),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.button,
        // FIX: Tambahkan overlayColor untuk visual feedback saat ditekan/di-hover
        overlayColor: AppColors.secondary.withOpacity(0.1),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border), // FIX: Border default
        borderRadius:
            BorderRadius.all(Radius.circular(8)), // FIX: Tambahkan radius
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: AppColors.border), // FIX: Border saat enabled
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.primary, width: 2), // FIX: Lebih tebal saat fokus
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.error, width: 2), // FIX: Lebih jelas saat error
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: AppColors.error,
            width: 2.5), // FIX: Lebih tebal saat fokus & error
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      labelStyle: TextStyle(color: AppColors.textSecondary),
      hintStyle: TextStyle(color: AppColors.textSecondary),
      // FIX: Tambahkan filled dan fillColor untuk visual feedback
      filled: true,
      fillColor: AppColors
          .scaffold, // Menggunakan warna scaffold sebagai isian default
    ),
    // FIX: Tambahkan indikator progress bar yang sesuai
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
      linearTrackColor: AppColors.secondary,
      circularTrackColor: AppColors.secondary,
    ),
  );
}
