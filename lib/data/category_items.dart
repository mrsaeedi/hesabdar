import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';

List assetsOfIconsData = [
  Icons.home,
  Icons.add_a_photo_sharp,
  Icons.payment,
  Icons.no_crash_rounded,
  Icons.phone,
  Icons.new_label,
];

// RxMap<String, List<ListOfcat>> categoryData = {
//   'بهداشتی': [
//     ListOfcat(
//       name: 'دارو',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'بیمارستان',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'ازمایش',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'لوازم رایشی بهداشتی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'جراحی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'دندان پزشکی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//     ListOfcat(
//       name: 'ویزیت پزشک',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 0,
//     ),
//   ].obs,
//   'غذا': [
//     ListOfcat(
//       name: 'تنقلات',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'شام',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'ناهار',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'صبحانه',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'نوشیدنی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'میوه',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//     ListOfcat(
//       name: 'کافی شاپ',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 1,
//     ),
//   ].obs,
//   'کرایه': [
//     ListOfcat(
//       name: 'اتبوس',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//     ListOfcat(
//       name: 'قطار',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//     ListOfcat(
//       name: 'اژانس',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//     ListOfcat(
//       name: 'اسنپ',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//     ListOfcat(
//       name: 'مترو',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//     ListOfcat(
//       name: 'محل اقامت',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 2,
//     ),
//   ].obs,
//   'سرگرمی': [
//     ListOfcat(
//       name: 'بازی وشهر بازی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 3,
//     ),
//     ListOfcat(
//       name: 'فیلم',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 3,
//     ),
//     ListOfcat(
//       name: 'کتاب',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 3,
//     ),
//     ListOfcat(
//       name: 'کنسرت',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 3,
//     ),
//   ].obs,
//   'خانه': [
//     ListOfcat(
//       name: 'اجاره',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'قبض اب',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'قبض برق',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'قبض گاز',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'تلفن و وای فای',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'لوازم خانه',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//     ListOfcat(
//       name: 'شارژ',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 4,
//     ),
//   ].obs,
//   'موبایل و کامپیوتر': [
//     ListOfcat(
//       name: 'تعمیر مبایل',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 5,
//     ),
//     ListOfcat(
//       name: 'تعمیر کامپیوتر',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 5,
//     ),
//     ListOfcat(
//       name: 'شارژ مبایل',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 5,
//     ),
//     ListOfcat(
//       name: 'قبض مبایل',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 5,
//     ),
//     ListOfcat(
//       name: 'لوازم جانبی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 5,
//     ),
//   ].obs,
//   'بانکی': [
//     ListOfcat(
//       name: 'دیر کرد',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 6,
//     ),
//     ListOfcat(
//       name: 'سود',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 6,
//     ),
//     ListOfcat(
//       name: 'کارمزد',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 6,
//     ),
//   ].obs,
//   'خودرو': [
//     ListOfcat(
//       name: 'بنزین',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//     ListOfcat(
//       name: 'بیمه',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//     ListOfcat(
//       name: 'روغن موتور',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//     ListOfcat(
//       name: 'عوارضی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//     ListOfcat(
//       name: 'مکانیکی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//     ListOfcat(
//       name: 'پارکینگ',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 7,
//     ),
//   ].obs,
//   'پوشاک': [
//     ListOfcat(
//       name: 'خرید پوشاک',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 8,
//     ),
//     ListOfcat(
//       name: 'خیاطی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 8,
//     ),
//   ].obs,
//   'آموزش': [
//     ListOfcat(
//       name: 'کلاس اموزشی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//     ListOfcat(
//       name: 'دوره',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//     ListOfcat(
//       name: 'باشگاه',
//       catIndex: 9,
//       catIcon: Icons.account_tree_rounded,
//     ),
//     ListOfcat(
//       name: 'وبینار',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//     ListOfcat(
//       name: 'لوازم تحریر',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//     ListOfcat(
//       name: 'کتاب',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//     ListOfcat(
//       name: 'لاوازم ورزشی',
//       catIcon: Icons.account_tree_rounded,
//       catIndex: 9,
//     ),
//   ].obs,
// }.obs;

// RxMap<String, List<ListOfcat>> categoryData1 = {
//   'بهداشتی': <ListOfcat>[].obs,
//   'غذا': <ListOfcat>[].obs,
//   'کرایه': <ListOfcat>[].obs,
//   'سرگرمی': <ListOfcat>[].obs,
//   'خانه': <ListOfcat>[].obs,
//   'موبایل و کامپیوتر': <ListOfcat>[].obs,
//   'بانکی': <ListOfcat>[].obs,
//   'خودرو': <ListOfcat>[].obs,
//   'آموزش': <ListOfcat>[].obs,
// }.obs;

List<CategoresPayMoney> catData = [
  CategoresPayMoney(
    name: 'بهداشتی',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'دارو',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'بیمارستان',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'ازمایش',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'لوازم رایشی بهداشتی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'جراحی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'دندان پزشکی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
      ListOfcat(
        name: 'ویزیت پزشک',
        catIcon: Icons.account_tree_rounded,
        catIndex: 0,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'غذا',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'تنقلات',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'شام',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'ناهار',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'صبحانه',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'نوشیدنی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'میوه',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
      ListOfcat(
        name: 'کافی شاپ',
        catIcon: Icons.account_tree_rounded,
        catIndex: 1,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'کرایه',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'اتبوس',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
      ListOfcat(
        name: 'قطار',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
      ListOfcat(
        name: 'اژانس',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
      ListOfcat(
        name: 'اسنپ',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
      ListOfcat(
        name: 'مترو',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
      ListOfcat(
        name: 'محل اقامت',
        catIcon: Icons.account_tree_rounded,
        catIndex: 2,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'سرگرمی',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'بازی وشهر بازی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 3,
      ),
      ListOfcat(
        name: 'فیلم',
        catIcon: Icons.account_tree_rounded,
        catIndex: 3,
      ),
      ListOfcat(
        name: 'کتاب',
        catIcon: Icons.account_tree_rounded,
        catIndex: 3,
      ),
      ListOfcat(
        name: 'کنسرت',
        catIcon: Icons.account_tree_rounded,
        catIndex: 3,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'خانه',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'اجاره',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'قبض اب',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'قبض برق',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'قبض گاز',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'تلفن و وای فای',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'لوازم خانه',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
      ListOfcat(
        name: 'شارژ',
        catIcon: Icons.account_tree_rounded,
        catIndex: 4,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'موبایل و کامپیوتر',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'تعمیر مبایل',
        catIcon: Icons.account_tree_rounded,
        catIndex: 5,
      ),
      ListOfcat(
        name: 'تعمیر کامپیوتر',
        catIcon: Icons.account_tree_rounded,
        catIndex: 5,
      ),
      ListOfcat(
        name: 'شارژ مبایل',
        catIcon: Icons.account_tree_rounded,
        catIndex: 5,
      ),
      ListOfcat(
        name: 'قبض مبایل',
        catIcon: Icons.account_tree_rounded,
        catIndex: 5,
      ),
      ListOfcat(
        name: 'لوازم جانبی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 5,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'بانکی',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'دیر کرد',
        catIcon: Icons.account_tree_rounded,
        catIndex: 6,
      ),
      ListOfcat(
        name: 'سود',
        catIcon: Icons.account_tree_rounded,
        catIndex: 6,
      ),
      ListOfcat(
        name: 'کارمزد',
        catIcon: Icons.account_tree_rounded,
        catIndex: 6,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'خودرو',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'بنزین',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
      ListOfcat(
        name: 'بیمه',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
      ListOfcat(
        name: 'روغن موتور',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
      ListOfcat(
        name: 'عوارضی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
      ListOfcat(
        name: 'مکانیکی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
      ListOfcat(
        name: 'پارکینگ',
        catIcon: Icons.account_tree_rounded,
        catIndex: 7,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'پوشاک',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'خرید پوشاک',
        catIcon: Icons.account_tree_rounded,
        catIndex: 8,
      ),
      ListOfcat(
        name: 'خیاطی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 8,
      ),
    ].obs,
  ),
  CategoresPayMoney(
    name: 'آموزش',
    catIndex: 0,
    catList: <ListOfcat>[
      ListOfcat(
        name: 'کلاس اموزشی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
      ListOfcat(
        name: 'دوره',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
      ListOfcat(
        name: 'باشگاه',
        catIndex: 9,
        catIcon: Icons.account_tree_rounded,
      ),
      ListOfcat(
        name: 'وبینار',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
      ListOfcat(
        name: 'لوازم تحریر',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
      ListOfcat(
        name: 'کتاب',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
      ListOfcat(
        name: 'لاوازم ورزشی',
        catIcon: Icons.account_tree_rounded,
        catIndex: 9,
      ),
    ].obs,
  ),
];

List<CategoresPayMoney> catDataAddOnInint = <CategoresPayMoney>[];
