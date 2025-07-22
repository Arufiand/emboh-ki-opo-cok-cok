import 'package:flutter/material.dart';
import 'package:epms_flutter/core/theme/app_colors.dart'; // Import AppColors
import 'package:epms_flutter/core/theme/app_text_styles.dart'; // Import AppTextStyles

// Kelas ini mendefinisikan tema terang dan gelap aplikasi.
class AppTheme {
  // Tema terang aplikasi.
  static ThemeData lightTheme = ThemeData(
    // Properti 'primaryColor' di level ThemeData, digunakan oleh beberapa widget lama.
    primaryColor: AppColors.primaryColor,

    // Konfigurasi ColorScheme yang direkomendasikan untuk Material Design 3.
    // seedColor akan menghasilkan palet warna yang harmonis berdasarkan warna utama.
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor, // Warna benih utama (biru)
      primary: AppColors.primaryColor, // Warna utama untuk komponen interaktif
      onPrimary: AppColors.onPrimaryColor, // Warna teks/ikon di atas primary
      secondary: AppColors.secondaryColor, // Warna sekunder
      onSecondary:
          AppColors.onSecondaryColor, // Warna teks/ikon di atas secondary
      tertiary: AppColors.accentColor, // Warna tersier
      error: AppColors.errorColor, // Warna error
      onError: AppColors.onErrorColor, // Warna teks/ikon di atas error
      background:
          AppColors.backgroundColor, // Warna latar belakang umum (kanvas)
      onBackground:
          AppColors.onBackgroundColor, // Warna teks/ikon di atas background
      surface: AppColors
          .surfaceColor, // Warna permukaan komponen (Card, Dialog, Scaffold default)
      onSurface: AppColors.onSurfaceColor, // Warna teks/ikon di atas surface
    ),
    brightness: Brightness.light, // Menentukan tema terang
    // Mengatur font default untuk seluruh aplikasi.
    fontFamily: 'Roboto', // Ganti dengan font yang Anda inginkan jika ada
    // Mengatur gaya teks global menggunakan AppTextStyles.
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      titleLarge: AppTextStyles.titleLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      labelLarge: AppTextStyles.buttonTextStyle, // Gaya teks untuk tombol
      headlineMedium:
          AppTextStyles.headlineMedium, // Untuk contoh counter di MyHomePage
      labelSmall: AppTextStyles.labelSmall, // Untuk label kecil
      // Tambahkan gaya teks lain dari AppTextStyles sesuai kebutuhan.
    ),

    // --- Tema Widget Spesifik ---

    // Tema untuk AppBar.
    appBarTheme: AppBarTheme(
      backgroundColor:
          AppColors.primaryColor, // Latar belakang AppBar adalah BIRU
      foregroundColor: AppColors
          .onPrimaryColor, // Warna ikon dan teks di AppBar adalah putih
      elevation: 2.0, // Bayangan di bawah AppBar
      titleTextStyle: AppTextStyles.titleLarge.copyWith(
        color: AppColors.onPrimaryColor,
      ), // Gaya teks judul AppBar
      iconTheme: IconThemeData(
        color: AppColors.onPrimaryColor,
      ), // Warna ikon di AppBar
    ),

    // Tema untuk ElevatedButton.
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            AppColors.primaryColor, // Latar belakang tombol adalah BIRU
        foregroundColor:
            AppColors.onPrimaryColor, // Warna teks/ikon tombol adalah putih
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Sudut membulat
        ),
        textStyle: AppTextStyles.buttonTextStyle, // Gaya teks tombol
      ),
    ),

    // Tema untuk InputDecoration (untuk TextFormField, TextField).
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.hintColor), // Border default
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.primaryColor,
          width: 2,
        ), // Border fokus adalah BIRU
      ),
      enabledBorder: OutlineInputBorder(
        // Border saat tidak fokus tapi aktif
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      errorBorder: OutlineInputBorder(
        // Border saat ada error
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.errorColor, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        // Border saat ada error dan fokus
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppColors.errorColor, width: 2),
      ),
      labelStyle: TextStyle(color: AppColors.textColor), // Gaya label
      hintStyle: TextStyle(color: AppColors.hintColor), // Gaya hint
      contentPadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ), // Padding konten
    ),

    // Warna latar belakang default untuk Scaffold.
    scaffoldBackgroundColor: AppColors
        .backgroundColor, // Latar belakang Scaffold adalah abu-abu sangat terang
    // Warna default untuk Card.
    cardColor: AppColors.surfaceColor, // Warna Card adalah putih
    // Tema untuk FloatingActionButton.
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor, // Latar belakang FAB adalah BIRU
      foregroundColor: AppColors.onPrimaryColor, // Warna ikon FAB adalah putih
    ),

    // Tema untuk TextButton.
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor:
            AppColors.primaryColor, // Warna teks TextButton adalah BIRU
        textStyle: AppTextStyles.buttonTextStyle.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    ),

    // Tambahkan tema untuk widget lain seperti DialogTheme, BottomSheetTheme, dll.
  );

  // Tema gelap aplikasi (kosong untuk saat ini, bisa diisi nanti).
  static ThemeData darkTheme = ThemeData(
      // ... definisi tema gelap Anda di sini
      );
}
