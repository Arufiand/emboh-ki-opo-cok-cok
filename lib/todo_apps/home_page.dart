import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/todo_apps/utils/dialog_box.dart';
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

  final _textController = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      _toDoList[index][1] = !_toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      _toDoList.add([_textController.text, false]);
      _textController.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSaved: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(title: Text("TO DO"), elevation: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
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
