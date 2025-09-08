import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mitch_koko_bloc_learning/domain/models/todo.dart';
import 'package:mitch_koko_bloc_learning/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    // 1. todo_cubit create loadTodos
    // 2. loadTodos is calling the todoRepo getTodos on the domain/repository/todo_repo.dart
    // 3. the todo_repo.dart is implemented from the data/repository/isar_todo_repo.dart
    final todoList = await todoRepo.getTodos();
    emit(todoList);
  }

  Future<void> addTodo(String text) async {
    final newTodo = Todo(id: DateTime.now().microsecondsSinceEpoch, text: text);

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  Future<void> editTodo(Todo todo) async {
    final updateTodo = Todo(id: todo.id, text: todo.text);

    await todoRepo.editTodo(updateTodo);

    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);
    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updatedTodo = todo.toggleCompletion();
    await todoRepo.editTodo(updatedTodo);
    loadTodos();
  }
}
