import 'dart:math';

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
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween(
      begin: -35.00,
      end: -80.0,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  onTap() {
    catController.status == AnimationStatus.completed
        ? catController.reverse()
        : catController.forward();

    //  Or
    //   if(catController.status == AnimationStatus.completed){}
    //   else if(catController.status == AnimationStatus.dismissed){} // -> To check whether animation is started or not
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [buildCatAnimation(), buildBox(), buildLeftFlap()],
          ),
        ),
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder:
          (context, child) => Positioned(
            top: catAnimation.value,
            left: 0.0,
            right: 0.0,
            child: child ?? const SizedBox(),
          ),
      child: Cat(),
    );
  }

  Widget buildBox() {
    return Container(height: 200.0, width: 200.0, color: Colors.brown);
  }

  Widget buildLeftFlap() {
    return Transform.rotate(
      angle: pi / 2.0,
      alignment: Alignment.topLeft,
      child: Container(height: 10.0, width: 120.0, color: Colors.red),
    );
  }
}
