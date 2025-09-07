import 'package:isar/isar.dart';
import 'package:mitch_koko_bloc_learning/domain/models/todo.dart';

// run : dart run build_runner build
// run for watch and delete previous one : dart run build_runner watch --delete-conflicting-outputs
part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement;
  late String text;
  late bool isCompleted;

  // Convert to domain pure object from isar object
  Todo toDomain() {
    return Todo(id: id, text: text, isCompleted: isCompleted);
  }

  //   Convert to isar object from pure todo object
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }
}
