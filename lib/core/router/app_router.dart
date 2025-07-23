// lib/core/router/app_router.dart
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/pages/ip_config_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/dashboard_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) => const LoginPage(),
    ),
    GoRoute(
      path: '/ip-config',
      name: 'ipConfig',
      builder: (BuildContext context, GoRouterState state) =>
          const IpConfigPage(),
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
    final authState = context.read<AuthBloc>().state;
    final bool isAuthenticated = authState is AuthAuthenticated;

    final bool goingToLogin = state.uri.toString() == '/login';
    final bool goingToSplash = state.uri.toString() == '/';

    if (!isAuthenticated &&
        !goingToLogin &&
        state.uri.toString() != '/ip-config') {
      return '/login';
    }
    if (isAuthenticated && goingToLogin) {
      return '/dashboard';
    }
    if (!isAuthenticated && goingToSplash) {
      return '/login';
    }

    return null;
  },
);
