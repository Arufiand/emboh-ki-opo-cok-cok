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
  late Animation<double> boxAnimation;
  late AnimationController boxController;
  late AnimationController jiggleController;
  late Animation<double> jiggleAnimation;

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

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    boxAnimation = Tween(
      begin: pi * 0.6,
      end: pi * 0.65,
    ).animate(CurvedAnimation(parent: boxController, curve: Curves.easeInOut));

    // boxAnimation.addStatusListener((status) {
    // if (status == AnimationStatus.completed) {
    //   boxController.repeat();
    // }
    // if (status == AnimationStatus.completed) {
    //   boxController.reverse();
    // } else if (status == AnimationStatus.dismissed) {
    //   boxController.forward();
    // }
    // });

    boxController.forward();

    jiggleController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    jiggleAnimation = Tween(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(parent: jiggleController, curve: Curves.easeInOut),
    );

    // Optional: Start automatically
    jiggleController.forward();
    // start jiggle loop
  }

  onTap() {
    // catController.status == AnimationStatus.completed
    //     ? catController.reverse()
    //     : catController.forward();

    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.reverse();
    }
    // Trigger side-to-side jiggle
    jiggleController.forward(from: 0.0);
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
            children: [
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
              buildRightFlap(),
            ],
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
    return AnimatedBuilder(
      animation: jiggleAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(jiggleAnimation.value, 0),
          child: child,
        );
      },
      child: Container(height: 200.0, width: 200.0, color: Colors.brown),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 120.0, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10.0, width: 120.0, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    catController.dispose();
    boxController.dispose();
    jiggleController.dispose();
    super.dispose();
  }
}
