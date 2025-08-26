import 'package:hive/hive.dart';

class TodoModel {
  List toDoList = [];
  final _myBox = Hive.box('myBox');

  void createInitialData() {
    toDoList = [
      ["make tutorial", false],
      ["make tutorial 2", false],
    ];
  }

  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  void onChangeData() {
    _myBox.put('TODOLIST', toDoList);
  }
}
