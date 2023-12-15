import 'package:flutter/material.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';

List assetsOfIconsData = [
  Icons.home,
  Icons.add_a_photo_sharp,
  Icons.payment,
  Icons.no_crash_rounded,
  Icons.phone,
  Icons.new_label,
];
// لیست دریافت و ذخیره دسته بندی پرداخت از دیتا بیس
List<CategoresPayMoney> catPayDataAddOnInint = <CategoresPayMoney>[];
// لیست دریافت و ذخیره دسته بندی دریافت از دیتا بیس
List<CategoresPayMoney> catGetDataAddOnInint = <CategoresPayMoney>[];
// دسته بندی پرداختیها
List<CategoresPayMoney> catPayData = [
  CategoresPayMoney(
    name: 'بهداشتی',
    catList: [
      ListOfcat(name: 'دارو', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'بیمارستان', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'آزمایش', catIcon: Icons.account_tree_rounded),
      ListOfcat(
          name: 'لوازم آرایشی بهداشتی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'جراحی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'دندان پزشکی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'ویزیت پزشک', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'غذا',
    catList: [
      ListOfcat(name: 'تنقلات', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'شام', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'ناهار', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'صبحانه', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'نوشیدنی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'میوه', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'کافی شاپ', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'کرایه',
    catList: [
      ListOfcat(name: 'اتبوس', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'قطار', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'آژانس', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'اسنپ', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'مترو', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'محل اقامت', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'سرگرمی',
    catList: [
      ListOfcat(name: 'بازی وشهر بازی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'فیلم', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'کتاب', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'کنسرت', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'خانه',
    catList: [
      ListOfcat(name: 'اجاره', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'قبض اب', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'قبض برق', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'قبض گاز', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'تلفن و وای فای', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'لوازم خانه', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'شارژ', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'موبایل و کامپیوتر',
    catList: [
      ListOfcat(name: 'تعمیر مبایل', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'تعمیر کامپیوتر', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'شارژ مبایل', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'قبض مبایل', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'لوازم جانبی', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'بانکی',
    catList: [
      ListOfcat(name: 'دیر کرد', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'سود', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'کارمزد', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'خودرو',
    catList: [
      ListOfcat(name: 'بنزین', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'بیمه', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'روغن موتور', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'عوارضی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'مکانیکی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'پارکینگ', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'پوشاک',
    catList: [
      ListOfcat(name: 'خرید پوشاک', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'خیاطی', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'آموزش',
    catList: [
      ListOfcat(name: 'کلاس آموزشی', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'دوره', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'باشگاه', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'وبینار', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'لوازم تحریر', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'کتاب', catIcon: Icons.account_tree_rounded),
      ListOfcat(name: 'لوازم ورزشی', catIcon: Icons.account_tree_rounded),
    ],
  ),
  CategoresPayMoney(
    name: 'غیره',
    catList: [],
  ),
];
// دسته بندی دریافتی ها
List<CategoresPayMoney> catGetData = <CategoresPayMoney>[
  CategoresPayMoney(name: 'درآمد', catList: <ListOfcat>[
    ListOfcat(name: 'حقوق', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'اجاره', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'از فروش', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'هدیه', catIcon: Icons.account_tree_rounded),
  ]),
  CategoresPayMoney(name: 'سرمایه', catList: <ListOfcat>[
    ListOfcat(name: 'ملک', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'ارز دیجیتال', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'طلا و جواهرات', catIcon: Icons.account_tree_rounded),
  ]),
  CategoresPayMoney(name: 'وام', catList: <ListOfcat>[
    ListOfcat(name: 'گرفتن وام', catIcon: Icons.account_tree_rounded),
    ListOfcat(name: 'گرفتن طلب', catIcon: Icons.account_tree_rounded),
  ]),
];
