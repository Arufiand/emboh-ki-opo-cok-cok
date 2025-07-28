// lib/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/blocs/auth/auth_bloc.dart'; // Import AuthBloc

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Memberikan delay eksplisit selama 3 detik (sesuaikan sesuai kebutuhan)
    // Anda bisa mengganti ini menjadi 5 detik jika mau.
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return; // Pastikan widget masih ada di tree

    // Baca status autentikasi setelah delay
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      context.go('/dashboard');
    } else {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue, // Sesuaikan warna latar belakang
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Anda bisa menggunakan gambar logo di sini
            // Image.asset(
            //   'assets/images/logo.png', // Pastikan path benar
            //   width: 150,
            //   height: 150,
            // ),
            // const SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Loading...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
