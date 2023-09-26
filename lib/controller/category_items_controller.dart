import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/model/category_items_mode.dart';

import 'dart:collection';

class CategoryItemsController extends GetxController {
  late RxMap<String, List<ListOfcat>> myMap = {
    'بهداشتی': [
      ListOfcat(
        name: 'دارو',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'بیمارستان',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'ازمایش',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
    ].obs,
    'غذا': [
      ListOfcat(
        name: 'تنقلات',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'شام',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'ناهار',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
    ].obs,
    'کرایه': [
      ListOfcat(
        name: 'اتبوس',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'قطار',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
      ListOfcat(
        name: 'اژانس',
        catIcon: Icon(Icons.account_tree_rounded),
      ),
    ].obs,
  }.obs;

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

  CircularList recentlyUsedCat = CircularList(10);

// recently used categorys
  // RxList<CircularList> recentlyUsedCat= <CircularList>;
  // asset of icons used at drobDownButton in add new item
  final RxList<Icon> assetsOfIcons = RxList<Icon>(
    [
      Icon(Icons.home),
      Icon(Icons.add_a_photo_sharp),
      Icon(Icons.payment),
      Icon(Icons.no_crash_rounded),
    ],
  );
  Rx<Icon?> selectedIcon = Rx<Icon?>(null);
  void upDateSelectedIcon(Icon value) {
    selectedIcon.value = value;
  }

  RxList allNames = [].obs;
}











  // final RxList<Map<String, dynamic>> myList = RxList.from([
  //   {
  //     'title': 'آموزش',
  //     'items': [
  //       {'title': 'عنوان 1-1', 'icon': Icons.home},
  //       {'title': 'عنوان 1-2', 'icon': Icons.star},
  //       {'title': 'عنوان 1-3', 'icon': Icons.settings},
  //     ],
  //   },
  //   {
  //     'title': 'تغذیه',
  //     'items': [
  //       {'title': 'عنوان 2-1', 'icon': Icons.mail},
  //       {'title': 'عنوان 2-2', 'icon': Icons.phone},
  //       {'title': 'عنوان 2-3', 'icon': Icons.person},
  //     ],
  //   },
  //   {
  //     'title': 'بهداشت و درمان',
  //     'items': [
  //       {'title': 'عنوان 2-1', 'icon': Icons.mail},
  //       {'title': 'عنوان 2-2', 'icon': Icons.phone},
  //       {'title': 'عنوان 2-3', 'icon': Icons.person},
  //     ],
  //   },
  // ]);
