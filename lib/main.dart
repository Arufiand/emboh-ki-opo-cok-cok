import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/todo_pages/todo_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoPages());
  }
}
