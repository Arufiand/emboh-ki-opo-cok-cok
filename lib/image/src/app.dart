import 'package:flutter/material.dart';

class App extends StatelessWidget{
  @override
  Widget build(context){
    return  MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('See Images From Custom Lib'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              print('hi there');
            },),
        )
    );
  }
}