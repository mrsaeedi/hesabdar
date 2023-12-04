import 'package:hive/hive.dart';
part 'add_todo_model.g.dart';

@HiveType(typeId: 2)
class AddTodoModel extends HiveObject {
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
  @HiveField(7)
  String id;
  AddTodoModel(
      {required this.title,
      required this.describtion,
      required this.isDone,
      required this.date,
      required this.time,
      required this.importance,
      required this.id});
}
