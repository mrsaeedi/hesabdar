import 'package:persian_datetime_picker/persian_datetime_picker.dart';

String year = Jalali.now().year.toString();
String month = Jalali.now().month.toString().length == 1
    ? '0${Jalali.now().month}'
    : '${Jalali.now().month}';
String day = Jalali.now().day.toString().length == 1
    ? '0${Jalali.now().day}'
    : '${Jalali.now().day}';

class DateModel {}

String today() {
  return '$year/$month/$day';
}
    //  int payToday(){
    //   int result=0;
    //   for (var vlue in ){
    //     if (value.date==today()&& value.isRec)
    //   }
    //   return result;
    // }