// class to implements the todo repo and handle storing, retrieving, updating, deleting in the ISAR Database

import 'package:isar/isar.dart';
import 'package:mitch_koko_bloc_learning/data/models/isar_todo.dart';
import 'package:mitch_koko_bloc_learning/domain/models/todo.dart';
import 'package:mitch_koko_bloc_learning/domain/repository/todo_repo.dart';

class IsarTodoRepo implements TodoRepo {
  final Isar db;
  IsarTodoRepo(this.db);

  @override
  Future<List<Todo>> getTodos() async {
    final todos = await db.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  @override
  Future<List<Todo>> addTodo(Todo newTodo) async {
    final todoIsar = TodoIsar.fromDomain(newTodo);

    await db.writeTxn(() => db.todoIsars.put(todoIsar));
    final updatedTodosIsar = await db.todoIsars.where().findAll();
    return updatedTodosIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Todo>> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));

    final updatedTodosIsar = await db.todoIsars.where().findAll();
    return updatedTodosIsar.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Todo>> editTodo(Todo todo) async {
    final todoIsar = TodoIsar.fromDomain(todo);

    await db.writeTxn(() => db.todoIsars.put(todoIsar));
    final updatedTodosIsar = await db.todoIsars.where().findAll();
    return updatedTodosIsar.map((e) => e.toDomain()).toList();
  }
}
