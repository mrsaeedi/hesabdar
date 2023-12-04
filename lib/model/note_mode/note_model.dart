// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 3)
class NoteModel extends HiveObject {
  @HiveField(1)
  String title;
  @HiveField(2)
  String contents;
  @HiveField(3)
  String category;
  @HiveField(4)
  String date;
  @HiveField(5)
  String id;
  NoteModel({
    required this.title,
    required this.contents,
    required this.category,
    required this.date,
    required this.id,
  });
}
