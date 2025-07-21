import 'package:flutter/material.dart';
import 'package:epms_flutter/core/theme/app_colors.dart'; // Import AppColors

// Kelas ini mendefinisikan gaya teks yang digunakan di seluruh aplikasi.
class AppTextStyles {
  // Gaya teks untuk judul besar atau tampilan utama.
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  // Gaya teks untuk judul halaman atau bagian penting.
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  // Gaya teks untuk body/konten utama.
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );

  // Gaya teks untuk tombol (ElevatedButton, TextButton).
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    // Warna teks tombol akan diatur oleh foregroundColor di ElevatedButton.styleFrom
    // atau TextButton.styleFrom, jadi tidak perlu di sini kecuali untuk override spesifik.
  );

  // Gaya teks untuk label kecil atau keterangan.
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.hintColor,
  );

  // Gaya teks untuk headline medium (misalnya, di MyHomePage counter).
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  // Anda bisa menambahkan lebih banyak gaya teks sesuai kebutuhan Material Design.
}
