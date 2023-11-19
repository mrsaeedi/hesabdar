import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

getPersianWeekDay(Jalali pickedDate) {
  switch (pickedDate.weekDay) {
    case 1:
      return 'شنبه';
    case 2:
      return 'یکشنبه';
    case 3:
      return 'دوشنبه';
    case 4:
      return 'سه شنبه';
    case 5:
      return 'چهارشنبه';
    case 6:
      return 'پنجشنبه';
    case 7:
      return 'جمعه';
    default:
      return '';
  }
}

class MyDatePicker extends StatelessWidget {
  const MyDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
