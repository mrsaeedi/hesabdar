import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AssetController extends GetxController {
  final List<String> assetsOfMoney = [
    'جیب',
  ];
  final RxList<AddNewPay> totalMonthPay = <AddNewPay>[].obs;
  final RxList<AddNewGet> totalMonthGet = <AddNewGet>[].obs;

  final List totalMonthPayPrice = [].obs;
  RxString dateToSave =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;
  String? dateElelemnt;
  Map resultPayMap = {};
  Map resultGetMap = {};
  void allResult() {
    Hive.box<AddNewPay>('payBox').values.forEach((element) {
      String resultPaySplit =
          element.date.split('').reversed.join().substring(2, 7);
      String resultdateToSave =
          dateToSave.split('').reversed.join().substring(2, 7);
      if (resultPaySplit == resultdateToSave) {
        totalMonthPay.add(element);
        totalMonthPayPrice.add(replaseingNumbersEnToFa(element.price));
        resultPayMap.(other)[element.listOfcat.name] = element.price;
      }
    });
    Hive.box<AddNewGet>('getBox').values.forEach((element) {
      String resultGetSplit =
          element.date.split('').reversed.join().substring(2, 7);
      String resultdateToSave =
          dateToSave.split('').reversed.join().substring(2, 7);
      if (resultGetSplit == resultdateToSave) {
        totalMonthGet.add(element);
      }
      resultGetMap[element.listOfcat.name] = element.price;
    });
  }

  final dateResult = Hive.box<AddNewPay>('payBox');
  static int payWeek() {
    return 0;
  }
}
