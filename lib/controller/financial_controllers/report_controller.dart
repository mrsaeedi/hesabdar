import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ReportController extends GetxController {
  // list of money assets
  final List assetsOfMoney = ['جیب'];

  //--------------------------------------------

  final List totalMonthPayPrice = [].obs;
  final List totalMonthGetPrice = [].obs;
// result of month payment
  RxDouble totalMonthPayPriceInt = 0.0.obs;
  RxDouble totalMonthGetPriceInt = 0.0.obs;
  // Monthly savings
  RxString monthTurnover = '۰'.obs;
// rsult month paymet to persion for show
  RxString totalMonthPayPriceShow = '۰'.obs;
  RxString totalMonthGetPriceShow = '۰'.obs;
  // date for save
  RxString dateToSave =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;

  Map<String, List> resultPayMap = {};
  RxMap<RxString, int> resultPayMapshow = <RxString, int>{}.obs;
  Map<String, List> resultGetMap = {};
  RxMap<String, int> resultGetMapShow = <String, int>{}.obs;
  int sumPay = 0;
  int sumGet = 0;
  RxDouble monthTurnoverPir = 0.0.obs;

  addAssetToList() {
    assetsOfMoney.clear();
    Hive.box<MoneyAssets>('assetsBox').values.forEach((element) {
      assetsOfMoney.add(element.name);
    });
  }

  final Rx<Jalali> chosseDate = Jalali.now().obs;

  RxString resultdateToSave =
      '${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${(Jalali.now().month).toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;

  RxDouble? maxTotal;
  RxDouble? minTotal;
  RxDouble? resultTotal;

  RxDouble showMonthMaxPir = 0.0.obs;
  double showMonthMinPir = 0;
//--------------------------------------------------------------
  List monthlyCompletTodos = [];
  List monthlyNotDownTodos = [];
  //
  List monthlyEmergencyTodos = [];
  List monthlyImportantTodos = [];
  List monthlyNormalTodos = [];
  List monthlyEmergencyTodosDown = [];
  List monthlyImportantTodosDown = [];
  List monthlyNormalTodosDown = [];

  changeResultDateAdd(int number) {
    chosseDate.value = chosseDate.value.addMonths(number);
    dateToSave.value =
        '${replaseingNumbersEnToFa(chosseDate.value.year.toString())}/${chosseDate.value.month < 10 ? replaseingNumbersEnToFa('0${(chosseDate.value.month).toString()}') : replaseingNumbersEnToFa(chosseDate.value.month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
  }

//
  RxString monthlyImportanchEmergency() {
    if (monthlyEmergencyTodos.isEmpty) {
      return '100'.obs;
    } else if (monthlyEmergencyTodosDown.isEmpty) {
      return '0'.obs;
    }
    double resultPirE = monthlyEmergencyTodosDown.length /
        (monthlyEmergencyTodos.length + monthlyEmergencyTodosDown.length) *
        100;

    return resultPirE.toStringAsFixed(0).obs;
  }

//
  RxString monthlyImportanchImportant() {
    if (monthlyImportantTodos.isEmpty) {
      return '100'.obs;
    } else if (monthlyImportantTodosDown.isEmpty) {
      return '0'.obs;
    }

    double resultPirI = monthlyImportantTodosDown.length /
        (monthlyImportantTodos.length + monthlyImportantTodosDown.length) *
        100;

    return resultPirI.toStringAsFixed(0).obs;
  }

//
  RxString monthlyImportanchNormal() {
    if (monthlyNormalTodos.isEmpty) {
      return '100'.obs;
    } else if (monthlyNormalTodosDown.isEmpty) {
      return '0'.obs;
    }

    double resultPirN = monthlyNormalTodosDown.length /
        (monthlyNormalTodos.length + monthlyNormalTodosDown.length) *
        100;
    return resultPirN.toStringAsFixed(0).obs;
  }

//
  RxDouble monthlyImportanchEmergencyProsess() {
    if (monthlyEmergencyTodos.isEmpty) {
      return 1.0.obs;
    } else if (monthlyEmergencyTodosDown.isEmpty) {
      return 0.0.obs;
    }
    double resultPirE = monthlyEmergencyTodosDown.length /
        (monthlyEmergencyTodos.length + monthlyEmergencyTodosDown.length);

    return resultPirE.obs;
  }

//
  RxDouble monthlyImportanchImportantProsess() {
    if (monthlyImportantTodos.isEmpty) {
      return 1.0.obs;
    } else if (monthlyImportantTodosDown.isEmpty) {
      return 0.0.obs;
    }

    double resultPirI = monthlyImportantTodosDown.length /
        (monthlyImportantTodos.length + monthlyImportantTodosDown.length);

    return resultPirI.obs;
  }

//
  RxDouble monthlyImportanchNormalProsess() {
    if (monthlyNormalTodos.isEmpty) {
      return 1.0.obs;
    } else if (monthlyNormalTodosDown.isEmpty) {
      return 0.0.obs;
    }

    double resultPirN = monthlyNormalTodosDown.length /
        (monthlyNormalTodos.length + monthlyNormalTodosDown.length);
    return resultPirN.obs;
  }

//
  RxString todoMonthlyResult() {
    if (monthlyNotDownTodos.isEmpty) {
      return '100'.obs;
    } else if (monthlyCompletTodos.isEmpty) {
      return '0'.obs;
    } else {
      double returnTodo = monthlyCompletTodos.length /
          (monthlyNotDownTodos.length + monthlyCompletTodos.length) *
          100;

      return returnTodo.toStringAsFixed(0).obs;
    }
  }

//
  RxDouble todoMonthlyResultProsess() {
    if (monthlyNotDownTodos.isEmpty) {
      return 1.0.obs;
    } else if (monthlyCompletTodos.isEmpty) {
      return 0.0.obs;
    } else {
      double returnTodo = monthlyCompletTodos.length /
          (monthlyNotDownTodos.length + monthlyCompletTodos.length);
      return returnTodo.obs;
    }
  }

  //
  allResultTodo() {
    monthlyNotDownTodos.clear();
    monthlyCompletTodos.clear();
    monthlyEmergencyTodos.clear();
    monthlyImportantTodos.clear();
    monthlyNormalTodos.clear();
    monthlyEmergencyTodosDown.clear();
    monthlyImportantTodosDown.clear();
    monthlyNormalTodosDown.clear();
    Hive.box<AddTodoModel>('todoBox').values.forEach((element) {
      String resultTimeSplit =
          element.date.split('').reversed.join().substring(2, 7);
      resultdateToSave.value =
          dateToSave.split('').reversed.join().substring(2, 7);

      if (resultTimeSplit == resultdateToSave.value) {
        monthlyNotDownTodos.add(element);

        //
        if (element.importance == 1) {
          monthlyEmergencyTodos.add(element);
        }
        //
        else if (element.importance == 2) {
          monthlyImportantTodos.add(element);
        }
        //
        else if (element.importance == 3) {
          monthlyNormalTodos.add(element);
        }
      }
    });

    Hive.box<AddTodoModel>('todoDoneBox').values.forEach((element) {
      String resultTimeSplit =
          element.date.split('').reversed.join().substring(2, 7);
      resultdateToSave.value =
          dateToSave.split('').reversed.join().substring(2, 7);

      if (resultTimeSplit == resultdateToSave.value) {
        monthlyCompletTodos.add(element);
        //
        if (element.importance == 1) {
          monthlyEmergencyTodosDown.add(element);
        }
        //
        else if (element.importance == 2) {
          monthlyImportantTodosDown.add(element);
        }
        //
        else if (element.importance == 3) {
          monthlyNormalTodosDown.add(element);
        }
      }
    });
  }

  var themBox = Hive.box<bool>('themeBox');

  RxBool isdarkLight = true.obs;

  void toggleTheme(bool isTrue) async {
    final bool isDarkTheme = themBox.get('isDarkTheme') ?? false;

    if (isTrue) {
      bool currentTheme = themBox.get('isDarkTheme') ?? false;
      themBox.put('isDarkTheme', !currentTheme);
    }
    isdarkLight.value = isDarkTheme;
  }

// show monthly payment result's for report
  allPaymentResult() {
    // clear variables for add new value
    resultGetMap.clear();
    resultPayMap.clear();
    totalMonthPayPrice.clear();
    totalMonthGetPrice.clear();
    totalMonthPayPriceInt = 0.0.obs;
    totalMonthGetPriceInt = 0.0.obs;
    totalMonthPayPriceShow.value = '۰';
    totalMonthGetPriceShow.value = '۰';
    monthTurnover.value = '۰';
    resultPayMapshow.clear();
    resultGetMapShow.clear();
    //
    Hive.box<AddNewPay>('payBox').values.forEach((element) {
      String resultPaySplit =
          element.date.split('').reversed.join().substring(2, 7);
      String resultdateToSave =
          dateToSave.split('').reversed.join().substring(2, 7);
      if (resultPaySplit == resultdateToSave) {
        totalMonthPayPrice
            .add(int.parse(replaseingNumbersFaToEn(element.price)));
        if (resultPayMap.containsKey(element.listOfcat.name!)) {
          // اگر کلید موجود بود، مقدار جدید به لیست مربوط به آن افزوده شود
          List sumpay = [int.parse(replaseingNumbersFaToEn(element.price))];
          resultPayMap[element.listOfcat.name]!
              .add(sumpay.reduce((a, b) => a + b));
        } else {
          // اگر کلید وجود نداشت، یک کلید جدید با لیست مقدار ایجاد شود
          resultPayMap[element.listOfcat.name!] = [
            int.parse(replaseingNumbersFaToEn(element.price))
          ];
        }
        int intSave = totalMonthPayPrice.isNotEmpty
            ? (totalMonthPayPrice.reduce((a, b) => a + b))
            : 0;
        totalMonthPayPriceInt.value = intSave.toDouble();

        totalMonthPayPriceShow.value = replaseingNumbersEnToFa(
            addCommasToNumber((totalMonthPayPriceInt.value.toInt())));
      }
      resultPayMap.forEach((key, value) {
        int sum = value.reduce((a, b) => a + b);
        resultPayMapshow[key.obs] = sum;
      });
    });

    //!------------------------------------------------------

// show pay result's for report
    Hive.box<AddNewGet>('getBox').values.forEach((element) {
      String resultGetSplit =
          element.date.split('').reversed.join().substring(2, 7);
      String resultdateToSave =
          dateToSave.split('').reversed.join().substring(2, 7);
      if (resultGetSplit == resultdateToSave) {
        // totalMonthGet.add(element);
        totalMonthGetPrice
            .add(int.parse(replaseingNumbersFaToEn(element.price)));
        if (resultGetMap.containsKey(element.listOfcat.name!)) {
          // اگر کلید موجود بود، مقدار جدید به لیست مربوط به آن افزوده شود
          resultGetMap[element.listOfcat.name!]!
              .add(int.parse(replaseingNumbersFaToEn(element.price)));
        } else {
          // اگر کلید وجود نداشت، یک کلید جدید با لیست مقدار ایجاد شود
          resultGetMap[element.listOfcat.name!] = [
            int.parse(replaseingNumbersFaToEn(element.price))
          ];
        }
        // مجوع لیست
        int saveInt = totalMonthGetPrice.isNotEmpty
            ? totalMonthGetPrice.reduce((a, b) => a + b)
            : 0;
        totalMonthGetPriceInt.value = saveInt.toDouble();
        // تبدیل به فارسی و فاصله
        totalMonthGetPriceShow.value = replaseingNumbersEnToFa(
            addCommasToNumber((totalMonthGetPriceInt.value.toInt())));
      }
      resultGetMap.forEach((key, value) {
        int sum = value.reduce((a, b) => a + b);
        resultGetMapShow[key] = sum;
      });
    });

    //  گردش مالی ماهانه
    monthTurnover = replaseingNumbersEnToFa(addCommasToNumber(
            totalMonthGetPriceInt.value.toInt() -
                totalMonthPayPriceInt.value.toInt()))
        .obs;

    maxTotal = totalMonthPayPriceInt.value < totalMonthGetPriceInt.value
        ? totalMonthGetPriceInt
        : totalMonthPayPriceInt;
    minTotal = totalMonthPayPriceInt.value < totalMonthGetPriceInt.value
        ? totalMonthPayPriceInt
        : totalMonthGetPriceInt;

    showMonthMaxPir.value =
        calculatePercentage(minTotal!.value, maxTotal!.value);
    showMonthMinPir = calculatePercentage(minTotal!.value, maxTotal!.value);

    monthTurnoverPir.value =
        ((totalMonthGetPriceInt.value - totalMonthPayPriceInt.value) /
                totalMonthGetPriceInt.value) *
            10;
  }

  double calculatePercentage(double value, double total) {
    if (total == 0) {
      // جلوگیری از تقسیم بر صفر
      return 0.0;
    }

    // محاسبه درصد
    double percentage = ((value / total) * 10.0);
    return percentage;
  }

  @override
  void onInit() async {
    toggleTheme(false);
    await allPaymentResult();
    await addAssetToList();
    await allResultTodo();
    super.onInit();
  }
}
