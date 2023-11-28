import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NoteController extends GetxController {
  int selectedIndex = 0;
  bool noteEditMode = false;
  RxList noteCategory = [].obs;
  var selectedCategory = ''.obs;
  String selectedCategoryshow = '';
  RxList<NoteModel> showNotes = <NoteModel>[].obs;
  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteContent = TextEditingController();
  RxString dateToSave =
      '${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;
  void upDateSelectedCategory(String value) {
    selectedCategory.value = value;
  }

  readNotesFroemHive(cat) {
    showNotes.clear();
    Hive.box<NoteModel>('noteBox').values.forEach((element) {
      if (cat == '') {
        showNotes.add(element);
      } else if (element.category == cat) {
        showNotes.add(element);
      }
    });
    showNotes.refresh();
  }

  addToNoteCat() {
    noteCategory.clear();
    Hive.box<String>('noteCatBox').values.forEach((element) {
      noteCategory.add(element);
    });
  }

  updateNoteInHive({index, title, describtion, date, catNote}) {
    Hive.box<NoteModel>('noteBox').putAt(
        index,
        NoteModel(
            title: title,
            contents: describtion,
            category: catNote,
            date: date));
  }

  deleteFromeHive(index) async {
    Hive.box<NoteModel>('noteBox').deleteAt(index);
    showNotes.removeAt(index);
  }

  @override
  void onInit() async {
    await addToNoteCat();
    await readNotesFroemHive('');
    Hive.box<NoteModel>('noteBox').watch().listen((event) async {
      await readNotesFroemHive('');
      await addToNoteCat();
    });

    super.onInit();
  }
}
