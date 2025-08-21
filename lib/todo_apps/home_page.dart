import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/todo_apps/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _toDoList = [
    ["Make Exercise", false],
    ["Make Exercise 2", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _toDoList[index][1] = !_toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TO DO"), elevation: 0),
      backgroundColor: Colors.yellow[200],
      body: ListView.builder(
        itemCount: _toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: _toDoList[index][0],
            onChanged: (value) => checkBoxChanged(value, index),
            taskCompleted: _toDoList[index][1],
          );
        },
      ),
    );
  }
}
