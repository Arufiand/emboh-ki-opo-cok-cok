import 'package:flutter/material.dart';

class CounterPages extends StatefulWidget {
  const CounterPages({super.key});

  @override
  State<CounterPages> createState() => _CounterPagesState();
}

class _CounterPagesState extends State<CounterPages> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You pushed the button this many times : "),
            Text(_counter.toString(), style: TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("Increment button"),
            ),
          ],
        ),
      ),
    );
  }
}
