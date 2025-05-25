import 'package:flutter/material.dart';

import '../screens/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(primarySwatch: Colors.red),
      home: Home(),
    );
  }
}
