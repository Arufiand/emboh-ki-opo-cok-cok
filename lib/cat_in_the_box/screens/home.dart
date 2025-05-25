import 'package:flutter/material.dart';
import 'package:learning/cat_in_the_box/widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    return Cat();
  }
}
