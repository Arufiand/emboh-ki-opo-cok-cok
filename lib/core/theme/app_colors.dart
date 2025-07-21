import 'package:flutter/material.dart';

// Kelas ini mendefinisikan konstanta warna yang digunakan di seluruh aplikasi.
class AppColors {
  // Warna utama aplikasi (biru).
  static const Color primaryColor = Color(0xFF2196F3); // Biru standar Material
  // Warna yang kontras dengan primaryColor (digunakan untuk teks/ikon di atas primary).
  static const Color onPrimaryColor = Colors.white;

  // Warna sekunder aplikasi (hijau).
  static const Color secondaryColor = Color(
    0xFF4CAF50,
  ); // Hijau standar Material
  // Warna yang kontras dengan secondaryColor.
  static const Color onSecondaryColor = Colors.white;

  // Warna tersier aplikasi (kuning/amber).
  static const Color accentColor = Color(0xFFFFC107); // Amber standar Material
  // Warna yang kontras dengan accentColor.
  static const Color onAccentColor = Colors.black;

  // Warna teks umum.
  static const Color textColor = Color(0xFF333333); // Abu-abu gelap untuk teks
  // Warna untuk placeholder atau hint teks.
  static const Color hintColor = Color(0xFF9E9E9E); // Abu-abu terang

  // Warna untuk indikasi error.
  static const Color errorColor = Color(0xFFF44336); // Merah standar Material
  // Warna yang kontras dengan errorColor.
  static const Color onErrorColor = Colors.white;

  // Warna latar belakang umum aplikasi (kanvas).
  // Ini bisa sedikit berbeda dari warna permukaan untuk memberikan kedalaman.
  static const Color backgroundColor = Color(
    0xFFF5F5F5,
  ); // Abu-abu sangat terang
  // Warna yang kontras dengan backgroundColor.
  static const Color onBackgroundColor = Color(0xFF333333);

  // Warna permukaan untuk komponen seperti Card, Dialog, BottomSheet, Scaffold.
  static const Color surfaceColor = Colors.white; // Putih bersih
  // Warna yang kontras dengan surfaceColor.
  static const Color onSurfaceColor = Color(0xFF333333);

  // Warna abu-abu untuk pembatas atau elemen non-aktif.
  static const Color greyColor = Color(0xFFE0E0E0);
}
