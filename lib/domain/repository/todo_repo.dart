// define what todo will do

import 'package:mitch_koko_bloc_learning/domain/models/todo.dart';

abstract class TodoRepo {
  //   get all todo
  Future<List<Todo>> getTodos();

  //   Create todo
  Future<List<Todo>> createTodo();

  // edit todo
  Future<List<Todo>> editTodo();

  // delete todo
  Future<List<Todo>> deleteTodo();
}
