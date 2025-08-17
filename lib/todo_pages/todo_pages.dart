import 'package:flutter/material.dart';

class TodoPages extends StatefulWidget {
  const TodoPages({super.key});

  @override
  State<TodoPages> createState() => _TodoPagesState();
}

class _TodoPagesState extends State<TodoPages> {
  TextEditingController textEditor = TextEditingController();

  String username = "";

  void greetUser() {
    setState(() {
      username = "Hello ${textEditor.text}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(username),

              TextField(
                controller: textEditor,

                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Username",
                ),
              ),
              ElevatedButton(onPressed: greetUser, child: Text("Tap")),
            ],
          ),
        ),
      ),
    );
  }
}
