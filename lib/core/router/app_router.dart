// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart'; // Import Flutter material design components

// Import halaman-halaman yang akan kita gunakan
// Nanti Anda perlu membuat file-file ini di folder presentation/pages
// import '../../presentation/pages/splash_page.dart'; // Halaman splash (opsional)
import '../../presentation/pages/ip_config_page.dart';
import '../../presentation/pages/login_page.dart'; // Halaman login

// GoRouter instance
// Kita buat sebagai final di level top-level agar bisa diakses di mana saja
final GoRouter appRouter = GoRouter(
  // initialLocation: '/', // Opsional: Tentukan rute awal jika tidak '/'. Defaultnya adalah '/'.

  // List of routes for the app
  routes: <RouteBase>[
    // --- Rute untuk Splash Page (Opsional) ---
    // Ini adalah rute awal aplikasi Anda.
    // Biasanya digunakan untuk menampilkan logo atau melakukan inisialisasi awal.
    // GoRoute(
    //   path: '/',
    //   name: 'splash', // Memberi nama rute untuk navigasi berbasis nama
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SplashPage(); // Mengarahkan ke SplashPage
    //   },
    // ),

    // --- Rute untuk Login Page ---
    // Halaman login adalah titik masuk utama setelah splash (jika ada) atau jika tidak terautentikasi.
    GoRoute(
      path: '/login',
      name: 'login', // Memberi nama rute
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage(); // Mengarahkan ke LoginPage
      },
    ),
    // --- Rute untuk Halaman Konfigurasi IP ---
    GoRoute(
      path: '/ip-config', // Rute untuk halaman konfigurasi IP
      builder: (BuildContext context, GoRouterState state) {
        return const IpConfigPage();
      },
    ),
    // --- Placeholder untuk rute lainnya ---
    // Nantinya akan ada rute untuk IP Config, Dashboard, Employee, dll.
    // Contoh:
    // GoRoute(
    //   path: '/ip-config',
    //   name: 'ipConfig',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const IpConfigPage();
    //   },
    // ),
    // GoRoute(
    //   path: '/dashboard',
    //   name: 'dashboard',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const DashboardPage();
    //   },
    // ),
    // GoRoute(
    //   path: '/employee',
    //   name: 'employee',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const EmployeePage();
    //   },
    // ),
  ],

  // --- Redirect Logic (akan kita implementasikan nanti di Fase 3) ---
  // redirect: (BuildContext context, GoRouterState state) {
  //   // Ini adalah tempat untuk menentukan apakah pengguna harus dialihkan ke rute lain
  //   // berdasarkan kondisi tertentu (misalnya, status autentikasi).
  //   // Contoh:
  //   // final bool loggedIn = // cek status login dari AuthBloc;
  //   // final bool goingToLogin = state.uri.toString() == '/login';

  //   // if (!loggedIn && !goingToLogin) {
  //   //   return '/login'; // Jika belum login dan mencoba mengakses halaman lain, arahkan ke login
  //   // }
  //   // if (loggedIn && goingToLogin) {
  //   //   return '/dashboard'; // Jika sudah login dan mencoba mengakses halaman login, arahkan ke dashboard
  //   // }
  //   // return null; // Izinkan navigasi ke rute yang diminta
  // },

  // --- Error Handling (Opsional) ---
  // errorBuilder: (BuildContext context, GoRouterState state) => const ErrorPage(),
);
