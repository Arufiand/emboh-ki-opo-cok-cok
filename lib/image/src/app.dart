import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' show get;
import 'package:learning/image/models/image_model.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;

  void fetchImage() async {
    counter += 1;
    var res = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'),
    );
    var imageModel = ImageModel.parseJson(json.decode(res.body));

    setState(() {
      counter += 1;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Text('$counter'),
        appBar: AppBar(title: Text('See Images From Custom Lib')),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
