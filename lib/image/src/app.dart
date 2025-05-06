import 'package:flutter/material.dart';

class App extends StatefulWidget{
  @override
  createState(){
    return AppState();
  }
}

class AppState extends State<App>{
  int counter = 0;

  @override
  Widget build(context){
    return  MaterialApp(
        home: Scaffold(
          body: Text('$counter'),
          appBar: AppBar(
            title: Text('See Images From Custom Lib'),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){
              setState(() {
                counter += 1;
              });
            },),
        )
    );
  }
}