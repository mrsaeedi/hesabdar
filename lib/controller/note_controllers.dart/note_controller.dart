import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hive/hive.dart';

class NoteController extends GetxController {
  bool noteEditMode = false;
  RxList<String> noteCategory = <String>[
    '',
    'همه',
  ].obs;
  RxList<NoteModel> allNotes = <NoteModel>[].obs;
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();

  void readNotesFroemHive() {
    final item = Hive.box<NoteModel>('noteBox').values.toList();
    allNotes.clear();
    allNotes.value = item;
  }

  void updateNoteInHive({index, title, describtion, date, catNote}) {
    Hive.box<NoteModel>('noteBox').putAt(
        index,
        NoteModel(
            title: title,
            contents: describtion,
            category: catNote,
            date: date));
  }

  void deleteFromeHive(index) {
    Hive.box<NoteModel>('noteBox').deleteAt(index);
    allNotes.removeAt(index);
  }

  @override
  void onInit() {
    readNotesFroemHive();
    Hive.box<NoteModel>('noteBox').watch().listen((event) {
      readNotesFroemHive();
    });

    super.onInit();
  }
}
