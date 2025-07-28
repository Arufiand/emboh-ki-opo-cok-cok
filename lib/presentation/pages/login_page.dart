// lib/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../blocs/auth/auth_bloc.dart';
// FIX: Import AppColors untuk penggunaan warna spesifik
import '../../core/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Akses tema melalui Theme.of(context)
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.of(context).pop();
              context.go('/dashboard');
            }
          });
        } else if (state is AuthError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              // FIX: Pastikan dialog tertutup sebelum SnackBar muncul
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop(); // Close loading dialog
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor:
                      AppColors.error, // Gunakan warna error dari tema
                  behavior:
                      SnackBarBehavior.floating, // Memberikan tampilan modern
                ),
              );
            }
          });
        }
      },
      child: Scaffold(
        // AppBar secara otomatis mengambil styling dari AppTheme.appBarTheme
        appBar: AppBar(
          title: const Text('Login Aplikasi EPMS'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_open_rounded,
                    size: 100,
                    color:
                        theme.primaryColor, // Mengambil warna primary dari tema
                  ),
                  const SizedBox(height: 30.0),
                  // FIX: TextFormField akan mengambil styling dari InputDecorationTheme
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      // border, focusedBorder, labelStyle dll. sudah diambil dari theme
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    // FIX: ElevatedButton akan mengambil styling dari ElevatedButtonThemeData
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final username = _usernameController.text;
                          final password = _passwordController.text;

                          context.read<AuthBloc>().add(
                                LoginRequested(
                                  username: username,
                                  password: password,
                                ),
                              );
                        }
                      },
                      // Styling sudah diatur di tema, jadi tidak perlu manual lagi di sini
                      // kecuali ada override spesifik untuk tombol ini.
                      child: Text(
                        'Login',
                        style: theme.textTheme
                            .labelLarge, // Gunakan textStyle dari tema
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      context.push('/ip-config');
                    },
                    // FIX: TextButton akan mengambil styling dari TextButtonThemeData
                    child: Text(
                      'Konfigurasi IP Backend',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme
                            .primaryColor, // Gunakan primaryColor dari tema
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
