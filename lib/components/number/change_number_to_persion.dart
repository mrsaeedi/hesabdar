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
String replaseingNumersFaToEn(String input) {
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
