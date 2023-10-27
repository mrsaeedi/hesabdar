import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/data/category_items.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';

class CategoryItemsController extends GetxController {
  final RxMap<String, List<ListOfcat>> d = RxMap();

  RxMap<String, List<ListOfcat>> myMap = categoryData.value.obs;

  RxList<ListOfcat> recentlyUsedCat = <ListOfcat>[].obs;

  void addItem(item) {
    // اگر لیست پر است، ایتم قدیمی را حذف کنید
    if (recentlyUsedCat.length == 10) {
      recentlyUsedCat.removeAt(0);
    }

    // اگر ایتم تکراری است، آن را قبول نکنید
    if (recentlyUsedCat.contains(item)) {
      // ایتم قدیمی را پیدا کنید
      int index = recentlyUsedCat.indexOf(item);

      // ایتم قدیمی را حذف کنید
      recentlyUsedCat.removeAt(index);

      // ایتم جدید را در ایندکس 0 قرار دهید
      recentlyUsedCat.insert(recentlyUsedCat.length, item);
    } else {
      // ایتم جدید را اضافه کنید
      recentlyUsedCat.add(item);
    }
  }

  // for add new item to the map
  void addTextToMap(String name, int index) {
    myMap.values
        .elementAt(index)
        .add(ListOfcat(name: name, catIcon: selectedIcon.value));
    myMap.refresh();
  }

  // for remove a item frome map
  void removeTextMap(index, item) {
    myMap.values.elementAt(index).remove(item);
    myMap.refresh();
  }

  final RxList<IconData> assetsOfIcons = RxList<IconData>(
    [...assetsOfIconsData],
  );
  Rx<IconData?> selectedIcon = Rx<IconData?>(null);
  void upDateSelectedIcon(IconData value) {
    selectedIcon.value = value;
  }

  RxList allNames = [].obs;
}
