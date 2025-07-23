// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BlocProvider/context.read
import 'package:get_it/get_it.dart'; // Import GetIt untuk mengakses Bloc
import '../../presentation/pages/ip_config_page.dart';
import '../../presentation/pages/login_page.dart';
// import '../../presentation/pages/dashboard_page.dart'; // Akan kita buat nanti
// import '../../presentation/pages/employee_page.dart'; // Akan kita buat nanti
import '../../presentation/blocs/auth/auth_bloc.dart'; // Import AuthBloc

final GoRouter appRouter = GoRouter(
  // initialLocation: '/', // Tidak perlu explicit jika ada redirect yang menangani '/'

  routes: <RouteBase>[
    // Rute awal default akan ditangani oleh redirect
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/ip-config',
      name: 'ipConfig',
      builder: (BuildContext context, GoRouterState state) {
        return const IpConfigPage();
      },
    ),
    // --- Rute untuk Dashboard Page ---
    // GoRoute(
    //   path: '/dashboard',
    //   name: 'dashboard',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const DashboardPage(); // Pastikan Anda membuat DashboardPage
    //   },
    // ),
    // --- Rute untuk Employee Page ---
    // GoRoute(
    //   path: '/employee',
    //   name: 'employee',
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const EmployeePage(); // Pastikan Anda membuat EmployeePage
    //   },
    // ),
  ],

  // --- Redirect Logic ---
  redirect: (BuildContext context, GoRouterState state) {
    // Dapatkan instance AuthBloc dari GetIt atau dari context
    // Menggunakan context.read<AuthBloc>() lebih disarankan jika BlocProvider sudah ada di atas MaterialApp.router
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;

    // Cek apakah pengguna sudah terautentikasi
    final bool isAuthenticated = authState is AuthAuthenticated;

    // Cek apakah pengguna sedang mencoba mengakses halaman login
    final bool goingToLogin = state.uri.toString() == '/login';
    final bool goingToSplash =
        state.uri.toString() == '/'; // Jika ada splash screen

    // Jika belum terautentikasi dan mencoba mengakses halaman selain login/ip-config
    if (!isAuthenticated &&
        !goingToLogin &&
        state.uri.toString() != '/ip-config') {
      return '/login'; // Arahkan ke halaman login
    }

    // Jika sudah terautentikasi dan mencoba mengakses halaman login
    if (isAuthenticated && goingToLogin) {
      return '/dashboard'; // Arahkan ke dashboard
    }

    // Jika sedang di root path (/) dan belum terautentikasi, arahkan ke login
    if (!isAuthenticated && goingToSplash) {
      return '/login';
    }

    // Izinkan navigasi ke rute yang diminta
    return null;
  },

  // --- Error Handling (Opsional) ---
  // errorBuilder: (BuildContext context, GoRouterState state) => const ErrorPage(),
);
