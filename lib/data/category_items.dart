import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/model/category_items_mode.dart';

List assetsOfIconsData = [
  Icon(Icons.home),
  Icon(Icons.add_a_photo_sharp),
  Icon(Icons.payment),
  Icon(Icons.no_crash_rounded),
  Icon(Icons.phone),
  Icon(Icons.new_label),
];

RxMap<String, List<ListOfcat>> categoryData = {
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
    ListOfcat(
      name: 'لوازم رایشی بهداشتی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'جراحی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'دندان پزشکی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'ویزیت پزشک',
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
    ListOfcat(
      name: 'صبحانه',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'نوشیدنی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'میوه',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'کافی شاپ',
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
    ListOfcat(
      name: 'اسنپ',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'مترو',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'محل اقامت',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'سرگرمی': [
    ListOfcat(
      name: 'بازی وشهر بازی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'فیلم',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'کتاب',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'کنسرت',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'خانه': [
    ListOfcat(
      name: 'اجاره',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'قبض اب',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'قبض برق',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'قبض گاز',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'تلفن و وای فای',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'لوازم خانه',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'شارژ',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'موبایل و کامپیوتر': [
    ListOfcat(
      name: 'تعمیر مبایل',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'تعمیر کامپیوتر',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'شارژ مبایل',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'قبض مبایل',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'لوازم جانبی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'بانکی': [
    ListOfcat(
      name: 'دیر کرد',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'سود',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'کارمزد',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'خودرو': [
    ListOfcat(
      name: 'بنزین',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'بیمه',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'روغن موتور',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'عوارضی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'مکانیکی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'پارکینگ',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'پوشاک': [
    ListOfcat(
      name: 'خرید پوشاک',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'خیاطی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
  'آموزش': [
    ListOfcat(
      name: 'کلاس اموزشی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'دوره',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'باشگاه',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'وبینار',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'لوازم تحریر',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'کتاب',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
    ListOfcat(
      name: 'لاوازم ورزشی',
      catIcon: Icon(Icons.account_tree_rounded),
    ),
  ].obs,
}.obs;
//