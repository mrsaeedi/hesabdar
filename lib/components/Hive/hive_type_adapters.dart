import 'package:flutter/widgets.dart';
import 'package:hesabdar/components/Hive/new_adapter.dart';
import 'package:hesabdar/controller/financial_controllers/category_items_controller.dart';
import 'package:hesabdar/main.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/category_items.dart';

class HiveManager {
  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(MoneyModellAdapter())
      ..registerAdapter(MoneyAssetsAdapter())
      ..registerAdapter(ListOfcatAdapter())
      ..registerAdapter(AddTodoModelAdapter())
      ..registerAdapter(NoteModelAdapter())
      ..registerAdapter(AddNewPayAdapter())
      ..registerAdapter(AddNewGetAdapter())
      ..registerAdapter(AddNewBudgetAdapter())
      ..registerAdapter(IconDataAdapter())
      ..registerAdapter(CategoresPayMoneyAdapter());
// a model af category's for get and pay money
    await Hive.openBox<ListOfcat>('catBox');
// To Do model for add todo's
    await Hive.openBox<AddTodoModel>('todoBox');
// Note Hive model for add all note's
    await Hive.openBox<NoteModel>('noteBox');
// for add all payment's
    await Hive.openBox<AddNewPay>('payBox');
// for add received money
    await Hive.openBox<AddNewGet>('getBox');
// for add budget
    await Hive.openBox<AddNewBudget>('budgetBox');
//  icon model for add save to hive
    await Hive.openBox<IconData>('iconBox');
// for save all pay category's in hive
    await Hive.openBox<CategoresPayMoney>('catListBox');
// for add all Get category's in hive
    await Hive.openBox<CategoresPayMoney>('catGrtBox');
// List of recently pay items
    await Hive.openBox<List>('listBox');
// List of recently Get item's
    await Hive.openBox<List>('listGetBox');
// for money assets
    await Hive.openBox<MoneyAssets>('assetsBox');
// for save category's of note's
    Hive.openBox<String>('noteCatBox');
// Check initial installation status
    var box = await Hive.openBox<bool>('install_status_box');

    firstInstall = box.get('installed') ?? true;
// all voids for first install
    if (firstInstall!) {
      Hive.box<List>('listBox').add(recentlyUsedCat);
      Hive.box<List>('listGetBox').add(recentlyUsedCat);
      await box.put('installed', false);
      for (final pay in catPayData) {
        await Hive.box<CategoresPayMoney>('catListBox').add(pay);
      }
      for (final get in catGetData) {
        await Hive.box<CategoresPayMoney>('catGrtBox').add(get);
      }
    }

    Hive.box<CategoresPayMoney>('catListBox').values.forEach((element) {
      catPayDataAddOnInint.add(element);
    });
    Hive.box<CategoresPayMoney>('catGrtBox').values.forEach((element) {
      catGetDataAddOnInint.add(element);
    });
  }
}
