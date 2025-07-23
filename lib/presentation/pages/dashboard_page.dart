import 'package:flutter/material.dart';
import '../widgets/main_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Dashboard',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selamat datang di Dashboard!",
                style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 20),
            const Text("Ini adalah konten halaman dashboard."),
          ],
        ),
      ),
    );
  }
}
