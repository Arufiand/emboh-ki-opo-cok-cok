import 'package:flutter/material.dart';
import 'package:learning/cat_in_the_box/widgets/cat.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;

  @override
  void initState() {
    super.initState();

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catAnimation = Tween(
      begin: 0.00,
      end: 100.0,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    catController.forward();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: buildAnimation(),
    );
  }

  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(top: catAnimation.value),
          child: child,
        );
      },
      child: Cat(),
    );
  }
}
