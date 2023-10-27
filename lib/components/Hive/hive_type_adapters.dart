import 'package:flutter/widgets.dart';
import 'package:hesabdar/components/Hive/new_adapter.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveManager {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(MoneyModellAdapter())
      ..registerAdapter(ListOfcatAdapter())
      ..registerAdapter(AddTodoModelAdapter())
      ..registerAdapter(NoteModelAdapter())
      ..registerAdapter(AddNewPayAdapter())
      ..registerAdapter(AddNewGetAdapter())
      ..registerAdapter(AddNewBudgetAdapter())
      ..registerAdapter(IconDataAdapter());

    await Hive.openBox<MoneyModell>('moneyBox');
    await Hive.openBox<ListOfcat>('catBox');
    await Hive.openBox<AddTodoModel>('todoBox');
    await Hive.openBox<NoteModel>('noteBox');
    await Hive.openBox<AddNewPay>('payBox');
    await Hive.openBox<AddNewGet>('getBox');
    await Hive.openBox<AddNewBudget>('budgetBox');
    await Hive.openBox<IconData>('iconBox');
  }
}
