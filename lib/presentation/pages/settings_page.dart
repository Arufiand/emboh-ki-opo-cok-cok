import 'package:flutter/material.dart';
import '../widgets/main_layout.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Pengaturan',
      child: Center(
        child: Text('Ini halaman Pengaturan'),
      ),
    );
  }
}
