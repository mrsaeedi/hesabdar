import 'package:hive/hive.dart';
part 'add_todo_model.g.dart';

@HiveType(typeId: 2)
class AddTodoModel {
  @HiveField(1)
  String title;
  @HiveField(2)
  String describtion;
  @HiveField(3)
  bool isDone;
  @HiveField(4)
  String date;
  @HiveField(5)
  String time;
  @HiveField(6)
  int importance;
  AddTodoModel(
      {required this.title,
      required this.describtion,
      required this.isDone,
      required this.date,
      required this.time,
      required this.importance});
}
