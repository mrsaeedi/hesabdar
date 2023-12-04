import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

// تبدیل اعداد انگلیسی به فارسی

class PersianNumberConverter {
  static String toPersian(String input) {
    String result = '';
    for (int i = 0; i < input.length; i++) {
      switch (input[i]) {
        case '0':
          result += '۰';
          break;
        case '1':
          result += '۱';
          break;
        case '2':
          result += '۲';
          break;
        case '3':
          result += '۳';
          break;
        case '4':
          result += '۴';
          break;
        case '5':
          result += '۵';
          break;
        case '6':
          result += '۶';
          break;
        case '7':
          result += '۷';
          break;
        case '8':
          result += '۸';
          break;
        case '9':
          result += '۹';
          break;
        default:
          result += input[i];
      }
    }
    return result;
  }
}

class PersianNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    String formattedText = PersianNumberConverter.toPersian(newText);
    return TextEditingValue(
      text: formattedText,
      selection: newValue.selection,
    );
  }
}

// یک متد برای تکست ها که تغییر میده شماره را به فارسی
String replaseingNumbersFaToEn(String input) {
  const enList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', ''];
  const faList = ['۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '۰', '،'];
  for (int i = 0; i < enList.length; i++) {
    input = input.replaceAll(faList[i], enList[i]);
  }
  return input;
}

String replaseingNumbersEnToFa(String input) {
  const enList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', '،'];
  const faList = ['۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', '۰', ''];
  for (int i = 0; i < enList.length; i++) {
    input = input.replaceAll(enList[i], faList[i]);
  }
  return input;
}

// با این کد اعداد فارسی و ویرگول قابل پدیرش خواهند بود
class PersianNumericTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final RegExp numericRegExp = RegExp(r'^[0-9۰-۹،]*$');
    if (!numericRegExp.hasMatch(newValue.text)) {
      // اگر ورودی شامل کاراکترهای غیرعددی و ویرگول باشد، اجازه ورود ندهید
      return oldValue;
    }
    return newValue;
  }
}

// یک متد برای تکست ها که تغییر میده شماره را به ماهString replaceNumbersToMonth(String input) {
String replaceNumbersToMonth(String input) {
  const enList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  const faList = [
    'فروردین',
    'اردیبهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند'
  ];

  for (int i = 0; i < enList.length; i++) {
    input = input.replaceAllMapped(
        RegExp('\\b${enList[i]}\\b'), (match) => faList[i]);
  }

  return input;
}

// macke unic id
//todo change characters
String generateUniqueId() {
  DateTime now = DateTime.now();
  int minute = now.minute;
  int second = now.second;
  int milliseconds = now.millisecondsSinceEpoch;
  int random = Random().nextInt(10000); // یک عدد تصادفی
  String randomLetter =
      String.fromCharCode(Random().nextInt(26) + 97); // یک حرف لاتین تصادفی

  String uniqueId = base64
      .encode(utf8.encode('$minute$second$milliseconds$random$randomLetter'));
  return uniqueId;
}
