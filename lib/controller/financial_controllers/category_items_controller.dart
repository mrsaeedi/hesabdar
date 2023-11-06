import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/data/category_items.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hive/hive.dart';

RxList recentlyUsedCat = [].obs;
RxList recentlyUsedCatShow = [].obs;

class CategoryItemsController extends GetxController {
  //
  final RxList<IconData> assetsOfIcons = RxList<IconData>(
    [...assetsOfIconsData],
  );
  Rx<IconData?> selectedIcon = Rx<IconData?>(null);
//

  RxList<CategoresPayMoney> catDataForShow =
      <CategoresPayMoney>[...catDataAddOnInint].obs;
//
  void upDateSelectedIcon(IconData value) {
    selectedIcon.value = value;
  }

  // for add new item to the pay category List
  void addMoneyCatToMap(String name, int index) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');
    var myCategoresPayMoney = box.get(index);
    var newItem =
        ListOfcat(name: name, catIndex: index, catIcon: selectedIcon.value);
    myCategoresPayMoney!.catList.add(newItem);
    await box.put(index, myCategoresPayMoney);
    catDataForShow.refresh();
  }

  // for remove a item frome add category list
  void removeAddMoneyCatItem(index, subIndex) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');
    var myCategoresPayMoney = box.get(index);
    ListOfcat item = myCategoresPayMoney!.catList[subIndex];
    myCategoresPayMoney.catList.remove(item);
    await box.put(index, myCategoresPayMoney);
    catDataForShow.refresh();
  }

  // for remove a item frome add category list
  void updateAddMoneyCatiItem(index, subIndex, text, icon) async {
    var box = await Hive.openBox<CategoresPayMoney>('catListBox');
    var myCategoresPayMoney = box.get(index);

    ListOfcat item = myCategoresPayMoney!.catList[subIndex];
    item.name = text;
    item.catIcon = icon;

    await box.put(index, myCategoresPayMoney);
    catDataForShow.refresh();
  }

  final listBox = Hive.box<List>('listBox');
  //!------------------------------------
  void addMonyItemToResently1(ListOfcat item) async {
    final newItem = item; // ایتم جدید
    List myList = listBox.getAt(0)!;

    if (myList.contains(newItem)) {
      int index = myList.indexOf(newItem);
      myList.removeAt(index); // حذف ایتم تکراری
    } else if (myList.length >= 10) {
      myList
          .removeLast(); // اگر تعداد ایتم‌ها بیشتر یا مساوی 10 تا شده باشد، ایتم‌های اضافی را حذف کنید
    }
    myList.insert(0, newItem); // اضافه کردن ایتم جدید در ایندکس صفر
    // لیست را در محفظه Hive ذخیره کنید
    await listBox.putAt(0, myList);
  }

  // for (final element in listBox.values) {
  //   for (final ListOfcat i in element) {
  //     recentlyUsedCatShow.add(i);
  //   }
  // }

  // void addRecentToShowlist() {
  //   for (final element in listBox.values) {
  //     for (final ListOfcat i in element) {
  //       recentlyUsedCatShow.add(i);
  //     }
  //   }
  // }

//!----------------------------------------

  @override
  void onClose() {
    recentlyUsedCatShow.clear();
    super.onClose();
  }
}
