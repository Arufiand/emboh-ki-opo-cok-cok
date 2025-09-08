import 'package:flutter/material.dart';
import 'package:mitch_koko_bloc_learning/presentation/todo/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();
    
    showDialog(context: context, builder: builder)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
    );
  }
}
