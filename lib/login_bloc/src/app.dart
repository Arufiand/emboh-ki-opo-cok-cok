import 'package:flutter/material.dart';
import 'package:learning/login_bloc/screens/login_blocScreen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Log Me In',
      home: Scaffold(body: LoginBlocScreen()),
    );
  }
}
