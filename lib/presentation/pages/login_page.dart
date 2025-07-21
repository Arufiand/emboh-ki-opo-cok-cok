import 'package:flutter/material.dart';
import 'package:epms_flutter/core/theme/app_colors.dart'; // Untuk mengakses warna langsung jika perlu
import 'package:epms_flutter/core/theme/app_text_styles.dart'; // Untuk mengakses gaya teks langsung jika perlu

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Kunci untuk validasi form

  @override
  Widget build(BuildContext context) {
    // Mengakses Theme.of(context) untuk menggunakan tema global Anda
    final theme = Theme.of(context);
    final textTheme = theme.textTheme; // Akses textTheme dari tema global
    final colorScheme = theme.colorScheme; // Akses colorScheme dari tema global

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EPMS LOGIN PAGE',
          // Gaya teks dari tema global, atau bisa di-override jika perlu
          style: textTheme.titleLarge?.copyWith(color: colorScheme.onPrimary),
        ),
        centerTitle: true,
        // Warna AppBar sudah diatur di app_theme.dart, jadi tidak perlu di sini
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome',
                  style: textTheme.headlineLarge?.copyWith(
                    color: AppColors
                        .primaryColor, // Menggunakan warna dari AppColors
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Masukkan username Anda',
                    prefixIcon: Icon(Icons.person),
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
                    hintText: 'Masukkan password Anda',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Hanya melakukan validasi form untuk saat ini
                    if (_formKey.currentState!.validate()) {
                      // Ini adalah tempat di mana Anda nanti akan memanggil BLoC login
                      // Untuk saat ini, kita hanya menampilkan pesan sederhana
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Username: ${_usernameController.text}, Password: ${_passwordController.text}',
                          ),
                        ),
                      );
                      // Contoh navigasi ke halaman lain setelah "login"
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(builder: (_) => const HomePage()),
                      // );
                    }
                  },
                  child: Text(
                    'Login',
                    // Gaya teks tombol biasanya diatur di elevatedButtonTheme
                    // Tetapi bisa di-override jika perlu
                    style: textTheme.labelLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    // Aksi untuk "Lupa Password?"
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fitur Lupa Password segera hadir!'),
                      ),
                    );
                  },
                  child: Text(
                    'IP CONFIGURATION',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
