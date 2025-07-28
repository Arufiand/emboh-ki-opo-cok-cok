// lib/presentation/widgets/main_layout.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart'; // Pastikan import AppTheme dan AppColors
import '../../presentation/blocs/auth/auth_bloc.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout({
    super.key,
    required this.child,
    this.title = 'Dashboard',
  });

  @override
  Widget build(BuildContext context) {
    // Akses tema melalui Theme.of(context) untuk konsistensi
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // AppBar secara otomatis mengambil styling dari AppTheme.appBarTheme
        // Jadi tidak perlu styling manual di sini kecuali ada override.
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // FIX: Gunakan Theme.of(context) untuk konsistensi warna dan teks
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.appBarTheme
                    .backgroundColor, // Ambil warna dari AppBarTheme
              ),
              child: Text(
                'Menu Utama',
                style: theme.appBarTheme.titleTextStyle?.copyWith(
                  // Pastikan ukuran dan warna teks sesuai
                  fontSize: 20,
                  color: AppColors.textInverse, // Pastikan teks invers
                ),
              ),
            ),
            // FIX: Styling ListTile untuk konsistensi
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: theme.colorScheme
                    .primary, // Warna ikon dari primary color scheme
              ),
              title: Text(
                'Dashboard',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary, // Warna teks dari textPrimary
                ),
              ),
              onTap: () {
                context.go('/dashboard');
                Navigator.of(context).pop(); // Tutup drawer setelah navigasi
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: theme.colorScheme.primary,
              ),
              title: Text(
                'Pengaturan',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                context.go('/settings');
                Navigator.of(context).pop(); // Tutup drawer setelah navigasi
              },
            ),
            Divider(
              color: theme.dividerColor, // Gunakan warna divider dari tema
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: theme
                    .colorScheme.error, // Gunakan warna error untuk ikon logout
              ),
              title: Text(
                'Logout',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary, // Warna teks dari textPrimary
                ),
              ),
              onTap: () {
                context.read<AuthBloc>().add(const LogoutRequested());
                Navigator.of(context).pop(); // Close drawer
              },
            ),
          ],
        ),
      ),
      body: SafeArea(child: child),
    );
  }
}
