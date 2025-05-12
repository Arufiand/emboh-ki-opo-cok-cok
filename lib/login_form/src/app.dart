import 'package:flutter/material.dart';
import 'package:learning/login_form/screens/login_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(title: 'Log Me in', home: Scaffold(body: LoginScreen()));
  }
}
