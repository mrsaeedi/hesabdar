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

RxMap<String, List<ListOfcat>> categoryData = {
  'بهداشتی': [
    ListOfcat(
      name: 'دارو',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'بیمارستان',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'ازمایش',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'لوازم رایشی بهداشتی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'جراحی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'دندان پزشکی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'ویزیت پزشک',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'غذا': [
    ListOfcat(
      name: 'تنقلات',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'شام',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'ناهار',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'صبحانه',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'نوشیدنی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'میوه',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'کافی شاپ',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'کرایه': [
    ListOfcat(
      name: 'اتبوس',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'قطار',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'اژانس',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'اسنپ',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'مترو',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'محل اقامت',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'سرگرمی': [
    ListOfcat(
      name: 'بازی وشهر بازی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'فیلم',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'کتاب',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'کنسرت',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'خانه': [
    ListOfcat(
      name: 'اجاره',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'قبض اب',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'قبض برق',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'قبض گاز',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'تلفن و وای فای',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'لوازم خانه',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'شارژ',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'موبایل و کامپیوتر': [
    ListOfcat(
      name: 'تعمیر مبایل',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'تعمیر کامپیوتر',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'شارژ مبایل',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'قبض مبایل',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'لوازم جانبی',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'بانکی': [
    ListOfcat(
      name: 'دیر کرد',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'سود',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'کارمزد',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'خودرو': [
    ListOfcat(
      name: 'بنزین',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'بیمه',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'روغن موتور',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'عوارضی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'مکانیکی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'پارکینگ',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'پوشاک': [
    ListOfcat(
      name: 'خرید پوشاک',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'خیاطی',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
  'آموزش': [
    ListOfcat(
      name: 'کلاس اموزشی',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'دوره',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'باشگاه',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'وبینار',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'لوازم تحریر',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'کتاب',
      catIcon: Icons.account_tree_rounded,
    ),
    ListOfcat(
      name: 'لاوازم ورزشی',
      catIcon: Icons.account_tree_rounded,
    ),
  ].obs,
}.obs;
