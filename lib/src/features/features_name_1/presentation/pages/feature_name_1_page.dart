import 'package:flutter/material.dart';

class FeatureName1Page extends StatelessWidget {
  const FeatureName1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feature 1')),
      body: const Center(
        child: Text('Welcome to Feature 1! This is a placeholder page.'),
      ),
    );
  }
}