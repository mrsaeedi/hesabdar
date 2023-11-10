import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/data/category_items.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hive/hive.dart';

RxList recentlyUsedCat = [].obs;
RxList recentlyUsedCatShow = [].obs;

class CategoryItemsController extends GetxController {
  //
  final int selectedItem = controller.value.index;

  final RxList<IconData> assetsOfIcons = RxList<IconData>(
    [...assetsOfIconsData],
  );
  //
  Rx<IconData?> selectedIcon = Rx<IconData?>(null);
// لیست مخصوص پرداختی ها
  RxList<CategoresPayMoney> catPayDataForShow =
      <CategoresPayMoney>[...catPayDataAddOnInint].obs;
// لیست مخصوص دریافتی ها
  RxList<CategoresPayMoney> catGetDataForShow =
      <CategoresPayMoney>[...catGetDataAddOnInint].obs;
//
  void upDateSelectedIcon(IconData value) {
    selectedIcon.value = value;
  }
  //

  // for add new item to the pay category List
  void addMoneyCatToPayList(String name, int index) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');

    var myCategoresPayMoney = box.get(index);
    var newItem =
        ListOfcat(name: name, catIndex: index, catIcon: selectedIcon.value);
    myCategoresPayMoney!.catList.add(newItem);
    await box.put(index, myCategoresPayMoney);
    catPayDataForShow.refresh();
  }

  void addMoneyCatToGetList(String name, int index) async {
    var box = await Hive.openBox<CategoresPayMoney>('catGrtBox');
    var myCategoresGetMoney = box.get(index);
    var newItem =
        ListOfcat(name: name, catIndex: index, catIcon: selectedIcon.value);
    myCategoresGetMoney!.catList.add(newItem);
    await box.put(index, myCategoresGetMoney);
    catPayDataForShow.refresh();
  }

  // for remove a item frome add category list
  void removeAddMoneyCatItem(index, subIndex) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');
    var myCategoresPayMoney = box.get(index);
    ListOfcat item = myCategoresPayMoney!.catList[subIndex];
    myCategoresPayMoney.catList.remove(item);
    await box.put(index, myCategoresPayMoney);
    catPayDataForShow.refresh();
  }

  void removeAddMoneyCatGetItem(index, subIndex) async {
    var box = await Hive.openBox<CategoresPayMoney>('catGrtBox');
    var myCategoresGetMoney = box.get(index);
    ListOfcat item = myCategoresGetMoney!.catList[subIndex];
    myCategoresGetMoney.catList.remove(item);
    await box.put(index, myCategoresGetMoney);
    catGetDataForShow.refresh();
  }

  // for remove a item frome add category list
  void updateAddMoneyPayiItem(index, subIndex, text, icon) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');
    var myCategoresPayMoney = box.get(index);
    ListOfcat item = myCategoresPayMoney!.catList[subIndex];
    item.name = text;
    item.catIcon = icon;
    await box.put(index, myCategoresPayMoney);
    catPayDataForShow.refresh();
    catGetDataForShow.refresh();
  }

  void updateAddMoneyGetiItem(index, subIndex, text, icon) async {
    var box = await Hive.openBox<CategoresPayMoney>('catGrtBox');
    var myCategoresGetMoney = box.get(index);
    ListOfcat item = myCategoresGetMoney!.catList[subIndex];
    item.name = text;
    item.catIcon = icon;
    await box.put(index, myCategoresGetMoney);
    catPayDataForShow.refresh();
    catGetDataForShow.refresh();
  }

  //!------------------------------------

  final listBox = Hive.box<List>('listBox');
  void addMonyItemToResently1(ListOfcat item) async {
    final newItem = item; // ایتم جدید
    List myList = listBox.getAt(0)!;

    if (myList.contains(newItem)) {
      int index = myList.indexOf(newItem);
      myList.removeAt(index); // حذف ایتم تکراری
    } else if (myList.length == 10) {
      myList
          .removeLast(); // اگر تعداد ایتم‌ها بیشتر یا مساوی 10 تا شده باشد، ایتم‌های اضافی را حذف کنید
    }
    myList.insert(0, newItem); // اضافه کردن ایتم جدید در ایندکس صفر
    // لیست را در محفظه Hive ذخیره کنید
    await listBox.putAt(0, myList);
  }

  final listGetBox = Hive.box<List>('listGetBox');
  void addMonyItemToResently2(ListOfcat item) async {
    final newItem = item; // ایتم جدید
    List myList = listGetBox.getAt(0)!;
    if (myList.contains(newItem)) {
      int index = myList.indexOf(newItem);
      myList.removeAt(index); // حذف ایتم تکراری
    } else if (myList.length == 10) {
      myList
          .removeLast(); // اگر تعداد ایتم‌ها بیشتر یا مساوی 10 تا شده باشد، ایتم‌های اضافی را حذف کنید
    }
    myList.insert(0, newItem); // اضافه کردن ایتم جدید در ایندکس صفر
    // لیست را در محفظه Hive ذخیره کنید
    await listGetBox.putAt(0, myList);
  }

  void addRecentleyUpdate() {
    if (selectedItem == 1) {
      for (final element in listGetBox.values) {
        for (final ListOfcat i in element) {
          recentlyUsedCatShow.add(i);
        }
      }
    } else {
      for (final element in listBox.values) {
        for (final ListOfcat i in element) {
          recentlyUsedCatShow.add(i);
        }
      }
    }
  }
}
