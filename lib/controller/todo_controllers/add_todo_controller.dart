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
  RxBool isClearButtonPressed = true.obs;
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

  void deleteFromeHive(index) {
    Hive.box<AddTodoModel>('todoBox').deleteAt(index);
    notDoneList.removeAt(index);
  }

  void toggleTodoState(int index) {
    notDoneList[index].isDone = true;
    if (notDoneList[index].isDone) {
      final todo = notDoneList.removeAt(index);
      doneList.add(todo);
    }
  }

  void toggleTodoStateDone(int index) {
    doneList[index].isDone = false;
    if (!doneList[index].isDone) {
      final todo = doneList.removeAt(index);
      notDoneList.add(todo);
    }
  }

  void updateItemInHive(int index, bool isDone) async {
    final AddTodoModel item = Hive.box<AddTodoModel>('todoBox').getAt(index)!;

    item.isDone = isDone;
    await Hive.box<AddTodoModel>('todoBox').putAt(index, item);
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
            importance: importance));
  }

  addItemToRxLists() {
    // final items = Hive.box<AddTodoModel>('todoBox').values.toList();
    doneList.clear();
    notDoneList.clear();
    doneList.refresh();
    notDoneList.refresh();
    Hive.box<AddTodoModel>('todoBox').values.forEach((element) {
      if (element.date == dateToSaveTodo.value) {
        if (element.isDone) {
          doneList.add(element);
        } else {
          notDoneList.add(element);
        }
      }
    });
  }

  @override
  void onInit() async {
    await addItemToRxLists();
    // await prosesBar();

    Hive.box<AddTodoModel>('todoBox').watch().listen((event) async {
      await addItemToRxLists();
      // await prosesBar();
    });

    super.onInit();
  }
}
