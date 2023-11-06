import 'package:flutter/widgets.dart';
import 'package:hesabdar/components/Hive/new_adapter.dart';
import 'package:hesabdar/controller/financial_controllers/category_items_controller.dart';
import 'package:hesabdar/main.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/category_items.dart';

class HiveManager {
  static CategoryItemsController catController = CategoryItemsController();

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
      ..registerAdapter(IconDataAdapter())
      ..registerAdapter(CategoresPayMoneyAdapter());

    await Hive.openBox<MoneyModell>('moneyBox');
    await Hive.openBox<ListOfcat>('catBox');
    await Hive.openBox<AddTodoModel>('todoBox');
    await Hive.openBox<NoteModel>('noteBox');
    await Hive.openBox<AddNewPay>('payBox');
    await Hive.openBox<AddNewGet>('getBox');
    await Hive.openBox<AddNewBudget>('budgetBox');
    await Hive.openBox<IconData>('iconBox');
    await Hive.openBox<CategoresPayMoney>('catListBox');
    await Hive.openBox<List>('listBox');
    await Hive.openBox<ListOfcat>('recentBox');

    // چک کردن وضعیت نصب اولیه
    var box = await Hive.openBox<bool>('install_status_box');
    firstInstall = box.get('installed') ?? true;

    if (firstInstall!) {
      Hive.box<List>('listBox').add(recentlyUsedCat);
      await box.put('installed', false);
      for (final c in catData) {
        await Hive.box<CategoresPayMoney>('catListBox').add(c);
      }
    }
    // for (final element in Hive.box<List>('listBox').values) {
    //   for (final ListOfcat i in element) {
    //     recentlyUsedCatShow.add(i);
    //   }
    // }

    Hive.box<CategoresPayMoney>('catListBox').values.forEach((element) {
      catDataAddOnInint.add(element);
    });
  }
}
