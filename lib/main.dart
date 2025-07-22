// lib/main.dart
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // <--- Komentari/hapus import ini untuk sementara
import 'package:get_it/get_it.dart'; // Import for sl
import 'package:epms_flutter/core/theme/app_theme.dart'; // Import tema global Anda
import 'core/utils/hive_config.dart'; // Import HiveConfig
import 'core/di/di.dart'; // Import GetIt init function
import 'core/router/app_router.dart'; // Import appRouter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Hive
  await HiveConfig.init();

  // 2. Inisialisasi GetIt
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider( // <--- Komentari baris ini
    //   // BlocProvider global untuk NetworkStatusCubit (sementara dikomentari)
    //   // Ini akan diaktifkan setelah NetworkStatusCubit dibuat di folder presentation/blocs
    //   create: (context) {
    //     // return sl<NetworkStatusCubit>()..checkNetworkStatus();
    //     return /* Placeholder for NetworkStatusCubit */; // Placeholder sementara
    //   },
    //   child: MaterialApp.router( // <--- Komentari baris ini
    return MaterialApp.router(
      // <--- Ganti dengan ini (jangan dibungkus BlocProvider dulu)
      title: 'EPMS App',
      // --- Mengaplikasikan Tema Global Anda ---
      theme: AppTheme.lightTheme, // Menggunakan tema terang dari AppTheme
      // darkTheme: AppTheme.darkTheme, // Jika Anda memiliki tema gelap
      // themeMode: ThemeMode.system, // Opsional: Ikuti pengaturan sistem

      // Menggunakan routerConfig dari GoRouter
      routerConfig:
          appRouter, // Mengarahkan ke GoRouter yang sudah didefinisikan
      //   ), // <--- Komentari baris ini
    ); // <--- Komentari baris ini
  }
}
