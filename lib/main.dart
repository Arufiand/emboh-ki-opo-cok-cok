import 'package:flutter/material.dart';

void main(){
  var app = MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('See Images'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
         print('hi there');
      },),
    )
  );

  runApp(app);
}
