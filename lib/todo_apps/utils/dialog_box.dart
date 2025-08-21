// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mitch_koko_learning/todo_apps/utils/my_button_widget.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSaved;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hint: const Text("Input new Task"),
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButtonWidget(onPressed: onSaved, text: "Save"),
                const SizedBox(width: 8),
                MyButtonWidget(onPressed: onCancel, text: "Cancel"),
              ],
            ),
          ],
        ),
      ),
    );
    // return const CupertinoAlertDialog(
    //
    // );
  }
}
