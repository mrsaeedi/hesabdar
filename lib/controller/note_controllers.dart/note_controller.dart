import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NoteController extends GetxController {
  int selectedIndex = 0;
  bool noteEditMode = false;
  RxList<String> noteCategory = <String>[].obs;
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

  void updateNoteInHive({id, title, describtion, date, catNote}) async {
    var box = Hive.box<NoteModel>('noteBox');
    var itemToUpdate = box.values.firstWhere(
      (item) => item.id == id,
    );
    itemToUpdate.title = title;
    itemToUpdate.contents = describtion;
    itemToUpdate.category = catNote;
    itemToUpdate.date = date;
    itemToUpdate.id = id;
    await box.put(itemToUpdate.key, itemToUpdate);
  }

  deleteFromeHive(id) async {
    var box = Hive.box<NoteModel>('noteBox');
    var itemToDelete = box.values.firstWhere(
      (item) => item.id == id,
    );
    await box.delete(itemToDelete.key);
  }
//! یک روش برای حذف یک ایتم خاص با اسم یا هرچیزی هر چندتا که باشه
  // void deleteFromHive(String value) {
  //   var box = Hive.box<NoteModel>('noteBox');

  //   var itemsToDelete =
  //       box.values.where((item) => item.title == value).toList();

  //   for (var item in itemsToDelete) {
  //     box.delete(item.key);
  //   }
  // }
//!
  void deleteNoteCatFromHive(String value) async {
    var box = Hive.box<NoteModel>('noteBox');

    var itemsToDelete =
        box.values.where((item) => item.category == value).toList();
    for (var item in itemsToDelete) {
      await box.delete(item.key);
    }
  }

  @override
  void onInit() async {
    await addToNoteCat();
    await readNotesFroemHive('');
    Hive.box<NoteModel>('noteBox').watch().listen((event) async {
      //await readNotesFroemHive('');
      // await addToNoteCat();
    });

    super.onInit();
  }
}
