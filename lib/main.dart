import 'package:flutter/material.dart';
import 'package:epms_flutter/core/theme/app_theme.dart'; // Import tema global Anda
import 'package:epms_flutter/presentation/pages/login_page.dart'; // Akan kita buat ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPMS App',
      // --- Mengaplikasikan Tema Global Anda ---
      theme: AppTheme.lightTheme, // Menggunakan tema terang dari AppTheme
      // darkTheme: AppTheme.darkTheme, // Jika Anda memiliki tema gelap
      // themeMode: ThemeMode.system, // Opsional: Ikuti pengaturan sistem
      home: const LoginPage(), // Mulai dengan halaman login
    );
  }
}
