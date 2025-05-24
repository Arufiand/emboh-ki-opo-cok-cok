import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' show get;
import 'package:learning/image/models/image_model.dart';
import 'package:learning/image/widgets/image_lists.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int counter = 0;
  List<ImageModel> images = [];

  void fetchImage() async {
    counter += 1;
    final res = await get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos/$counter'),
    );
    var imageModel = ImageModel.parseJson(json.decode(res.body));

    setState(() {
      images.add(imageModel);
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: ImageLists(images),
        appBar: AppBar(title: Text('See Images From Custom Lib')),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
