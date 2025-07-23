// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/pages/ip_config_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/dashboard_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/splash_screen.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Tetap mulai di splash screen
  routes: <RouteBase>[
    GoRoute(
      path: '/', // Rute untuk splash screen
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen(); // Tampilkan SplashScreen
      },
    ),
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
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const IpConfigPage()),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const DashboardPage()),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) =>
          NoTransitionPage(child: const SettingsPage()),
    ),
  ],
  redirect: (BuildContext context, GoRouterState state) {
    final authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    final bool isAuthenticated = authState is AuthAuthenticated;

    final bool goingToSplash = state.uri.toString() == '/';
    final bool goingToLogin = state.uri.toString() == '/login';
    final bool goingToIpConfig = state.uri.toString() == '/ip-config';

    // FIX: Hapus logika redirect khusus untuk 'goingToSplash' di sini.
    // SplashScreen itu sendiri yang akan menangani navigasinya setelah delay.
    // Redirect di sini hanya untuk MENCEGAH akses ke halaman terautentikasi
    // jika pengguna belum login dan tidak di rute login/ip-config.

    // Jika pengguna mencoba mengakses rute selain login/ip-config dan belum terautentikasi
    if (!isAuthenticated &&
        !goingToLogin &&
        !goingToIpConfig &&
        !goingToSplash) {
      return '/login';
    }

    // Jika sudah terautentikasi dan mencoba mengakses halaman login
    if (isAuthenticated && goingToLogin) {
      return '/dashboard';
    }

    // Tidak ada redirect jika kondisi lain tidak terpenuhi
    return null;
  },
);
