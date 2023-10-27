import 'package:get/get.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive/hive.dart';

class AddTodoController extends GetxController {
  RxBool isClearButtonPressed = true.obs;
  bool checkValue = false;
  RxInt selectedValue = 1.obs;
  RxList<AddTodoModel> notDoneList = <AddTodoModel>[].obs;
  RxList<AddTodoModel> doneList = <AddTodoModel>[].obs;

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

    if (item != null) {
      item.isDone = isDone;
      await Hive.box<AddTodoModel>('todoBox').putAt(index, item);
    }
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

  void addItemToRxLists() {
    final items = Hive.box<AddTodoModel>('todoBox').values.toList();
    doneList.clear();
    notDoneList.clear();

    for (final item in items) {
      if (item.isDone) {
        doneList.add(item);
      } else {
        notDoneList.add(item);
      }
    }
  }

  @override
  void onInit() {
    addItemToRxLists();
    Hive.box<AddTodoModel>('todoBox').watch().listen((event) {
      addItemToRxLists();
    });

    super.onInit();
  }
}
