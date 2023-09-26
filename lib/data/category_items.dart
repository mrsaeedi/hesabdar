import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/model/category_items_mode.dart';

final RxMap catData = {
  'بهداشت و درمان': [
    'آزمایشگاه',
    'جراحی',
    'دارو',
    'دندانپزشکی',
    'لوازم آرایشی',
    'ویزیت پزشک'
  ],
  'تغذیه': ['تنقلات', 'شام', 'رستوران', 'میوه', 'ناهار', 'نوشیدنی'],
  'آموزش': [
    'شهریه دانشگاه',
    'لوازم تحریر',
    'وبینار',
    'باشگاه',
    'وبینار',
    'کلاس اموزشی'
  ],
  'فرهنی و سرگرمی': [
    'اینترنت',
    'بازی و سرگرمی',
    'سینما',
    'کنسرت',
    'فیلم',
    'کتاب'
  ],
  'منزل': ['اجار', 'لوازم منزل', 'شارژساختمان', 'تلفن', 'برق', 'قبض آب'],
}.obs;
