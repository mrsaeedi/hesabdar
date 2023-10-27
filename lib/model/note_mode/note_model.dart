// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
part 'note_model.g.dart';

@HiveType(typeId: 3)
class NoteModel {
  @HiveField(1)
  String tile;
  @HiveField(2)
  String contents;
  @HiveField(3)
  String category;
  @HiveField(4)
  String date;
  NoteModel({
    required this.tile,
    required this.contents,
    required this.category,
    required this.date,
  });
}
