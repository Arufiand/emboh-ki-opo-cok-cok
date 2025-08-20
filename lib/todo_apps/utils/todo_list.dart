import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;

  Function(bool?)? onChanged;

  TodoList({
    super.key,
    required this.taskName,
    required this.onChanged,
    required this.taskCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: EdgeInsets.only(left: 24, top: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Checkbox(value: taskCompleted, onChanged: onChanged),
            Text(taskName),
          ],
        ),
      ),
    );
  }
}
