import 'package:flutter/material.dart';
import 'package:learning/login_bloc/blocs/provider.dart';
import '../screens/login_blocScreen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Log Me In',
        home: Scaffold(body: LoginBlocScreen()),
      ),
    );
  }
}
