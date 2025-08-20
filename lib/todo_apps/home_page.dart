import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/todo_apps/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("TO DO"), elevation: 0),
      backgroundColor: Colors.yellow[200],
      body: ListView(
        children: [
          TodoList(
            onChanged: (p0) {},
            taskCompleted: false,
            taskName: "Do Exercise",
          ),
        ],
      ),
    );
  }
}
