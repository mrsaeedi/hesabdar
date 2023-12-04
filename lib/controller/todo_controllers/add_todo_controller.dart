import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddTodoController extends GetxController {
  final Rx<Jalali> pickedDateSelectedTodo = Jalali.now().obs;
  final RxString weekDayString = ''.obs;
  final Rx<Jalali> pickedDateSelectedHomeTodo = Jalali.now().obs;
  RxString dateToSaveTodo =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;
  RxString dateValueTodo =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;
  //
  RxBool isClearButtonPressedDis = true.obs;
  //
  RxBool isClearButtonPressedTitle = true.obs;
  //
  bool checkValue = false;
  //
  RxInt selectedValue = 1.obs;
  //
  RxList<AddTodoModel> notDoneList = <AddTodoModel>[].obs;
  //
  RxList<AddTodoModel> doneList = <AddTodoModel>[].obs;
  //
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());
  //
  String nowDate =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';

  RxDouble getProsess() {
    if (notDoneList.isEmpty) {
      return 1.0.obs;
    } else if (doneList.isEmpty) {
      return 0.0.obs;
    } else {
      double prosessReturn =
          doneList.length / (notDoneList.length + doneList.length);
      return prosessReturn.obs;
    }
  }

  RxString getProsessPir() {
    if (notDoneList.isEmpty) {
      return '100'.obs;
    } else if (doneList.isEmpty) {
      return '0'.obs;
    } else {
      double prosessReturn =
          doneList.length / (notDoneList.length + doneList.length) * 100;
      return prosessReturn.toStringAsFixed(0).obs;
      //  prosesPirintshow.value = prosesPirint.toStringAsFixed(0);
    }
  }

  void handleRadioValueChange(int? value) {
    selectedValue.value = value ?? 1;
  }

  final Box<AddTodoModel> todoBox = Hive.box<AddTodoModel>('todoBox');
  final Box<AddTodoModel> todoBoxDone = Hive.box<AddTodoModel>('todoDoneBox');

  void updateItemInHive(id, item) async {
    doneList.clear();
    notDoneList.clear();
    doneList.refresh();
    notDoneList.refresh();

    if (item == 1) {
      // خواندن عنصر مورد نظر از todoBox
      var itemTodo = todoBox.values.firstWhere(
        (item) => item.id == id,
      );

      AddTodoModel getItem = todoBox.get(itemTodo.key)!;
      // حذف عنصر از todoBox
      todoBox.delete(itemTodo.key);
      // افزودن عنصر به todoBoxDone
      todoBoxDone.add(getItem);
    } else if (item == 2) {
      var itemTodoDone = todoBoxDone.values.firstWhere(
        (item) => item.id == id,
      );
      // خواندن عنصر مورد نظر از todoBoxDone
      AddTodoModel getItem = todoBoxDone.get(itemTodoDone.key)!;
      // حذف عنصر از todoBoxDone
      todoBoxDone.delete(itemTodoDone.key);
      // افزودن عنصر به todoBox
      todoBox.add(getItem);
    }
    // ذخیره تغییرات در Hive
    await Future.wait([todoBox.compact(), todoBoxDone.compact()]);
  }

  deleteFromeHiveTodo(id, item) async {
    if (item == 1) {
      var itemToDelete = todoBox.values.firstWhere(
        (item) => item.id == id,
      );
      await todoBox.delete(itemToDelete.key);
    } else if (item == 2) {
      var itemToDelete = todoBoxDone.values.firstWhere(
        (item) => item.id == id,
      );
      await todoBoxDone.delete(itemToDelete.key);
    }
  }

  addTodosToRxListForShow() {
    doneList.clear();
    notDoneList.clear();
    doneList.refresh();
    notDoneList.refresh();

    Hive.box<AddTodoModel>('todoBox').values.forEach((element) {
      if (element.date == dateToSaveTodo.value) {
        notDoneList.add(element);
      }
    });
    Hive.box<AddTodoModel>('todoDoneBox').values.forEach((element) {
      if (element.date == dateToSaveTodo.value) {
        doneList.add(element);
      }
    });
  }

  void updateItemsInHive(
      {index, title, describtion, isDone, date, time, importance}) {
    Hive.box<AddTodoModel>('todoBox').putAt(
        index,
        AddTodoModel(
            title: title,
            describtion: describtion,
            isDone: isDone,
            date: date,
            time: time,
            importance: importance,
            id: generateUniqueId()));
  }

  @override
  void onInit() async {
    addTodosToRxListForShow();
    Hive.box<AddTodoModel>('todoBox').watch().listen((event) async {});

    super.onInit();
  }
}
