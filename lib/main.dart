// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:epms_flutter/core/theme/app_theme.dart';
import 'core/utils/hive_config.dart';
import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'package:go_router/go_router.dart'; // Keep import for routerConfig

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfig.init();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(CheckAuthStatusRequested()),
        ),
      ],
      // FIX: Remove direct navigation from top-level BlocListener.
      // Initial redirection is now solely handled by GoRouter's redirect.
      // This listener can be removed entirely if no other top-level
      // reactions to AuthState are needed, or kept for logging/global snackbars.
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // You can put global notifications here (e.g., if a session expires)
          // but avoid navigation that directly affects the initial app flow.
          // The GoRouter redirect handles moving from splash to login/dashboard.
          // If a logout happens AFTER initial setup (e.g., from MainLayout),
          // the MainLayout's code (context.read<AuthBloc>().add(const LogoutRequested());
          // followed by the GoRouter redirect) will handle it.
        },
        child: MaterialApp.router(
          title: 'EPMS App',
          theme: AppTheme.lightTheme,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
