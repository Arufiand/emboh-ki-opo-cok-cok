import 'package:flutter/material.dart';

void main(){
  var app = MaterialApp(
    home: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        print('hi there');
      },),
      appBar: AppBar(
        title: Text('See Images'),
      ),
    )
  );

  runApp(app);
}
