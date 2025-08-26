import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mitch_koko_learning/todo_apps/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('myBox');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
