import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddNewPeymentController extends GetxController {
  RxList addedPayData = <MoneyModell>[].obs; // List of amount spent
  RxList addGetMoney = <MoneyModell>[].obs; // List of received amount
  RxList addBudget = <MoneyModell>[].obs; // Registered budget list
  var selectedAssetsOfMoney = ''.obs;
  RxString resultAsset = '0'.obs;
  final int selectedItem = controller.value.index;

  Future<void> assetsResult() async {
    resultAsset.value = '0';
    var assetsBox = Hive.box<MoneyAssets>('assetsBox');

    for (var element in assetsBox.values) {
      if (selectedAssetsOfMoney.value == element.name && selectedItem == 0) {
        resultAsset.value = (element.inventory -
                int.parse(replaseingNumbersFaToEn(controllerPrice.text)))
            .toString();
        element.inventory = int.parse(resultAsset.value);
        await assetsBox.put(element.name, element);
      }
      if (selectedAssetsOfMoney.value == element.name && selectedItem == 1) {
        resultAsset.value = (element.inventory +
                int.parse(replaseingNumbersFaToEn(controllerPrice.text)))
            .toString();
        element.inventory = int.parse(resultAsset.value);
        await assetsBox.put(element.name, element);
      }
    }
  }

  // Hive.box<AddNewPay>('payBox').values.forEach((element) {});
  // Hive.box<AddNewGet>('getBox').values.forEach((element) {});

  // open and close description part
  final RxInt openIndex = RxInt(-1);
  void onTap(int index) {
    if (openIndex.value == index) {
      openIndex.value = -1;
    } else {
      openIndex.value = index;
    }
  }

  String nowDate =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
// date picker part
  final Rx<Jalali> pickedDateSelected = Jalali.now().obs;
  final RxString weekDayString = ''.obs;
  final Rx<Jalali> pickedDateSelectedHome = Jalali.now().obs;
  final RxString weekDayStringHome = ''.obs;
  RxList<int> totalPay = <int>[].obs;
  RxList<int> totalGet = <int>[].obs;
  RxList<int> totalBudget = <int>[].obs;
  RxInt sumPay = 0.obs;
  RxInt sumGet = 0.obs;
  List myMapList = [];
// index for edit or delete
  int? editIndex;

  bool editMode = false;
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController describtionController = TextEditingController();
  RxString dateValue =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;
  // '${getPersianWeekDay(addNewPeymentController.pickedDateSelected.value)} __ ${replaseingNumersEnToFa(pickedDate.year.toString())}/${pickedDate.month < 10 ? replaseingNumersEnToFa('0${pickedDate.month.toString()}') : replaseingNumersEnToFa(pickedDate.month.toString())}/${pickedDate.day < 10 ? replaseingNumersEnToFa('0${pickedDate.day.toString()}') : replaseingNumersEnToFa(pickedDate.day.toString())}'

  Rx<IconData?> selectedCategoryIcon = Rx<IconData?>(null);
  RxString selectedCategoryName = categoryNameTitle.obs;

  // select
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());

  RxBool isClearButtonPressed = true.obs;
  Rx selectedAssetsOfMoneyList = Rx([]);

  void upDateSelectedAssets(String value) {
    selectedAssetsOfMoney.value = value;
  }

  RxString dateToSave =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;

  void addMoneyItemToRxLists() {
    addedPayData.clear();
    addGetMoney.clear();
    addBudget.clear();
    totalGet.clear();
    totalPay.clear();
    totalBudget.clear();
    sumGet.value = 0;
    sumPay.value = 0;
    sumGet.refresh();
    sumPay.refresh();
    Hive.box<AddNewPay>('payBox').values.forEach((element) {
      if (element.date == dateToSave.value) {
        addedPayData.add(element);
        totalPay.add(int.parse(replaseingNumbersFaToEn(element.price)));
      }
      if (totalPay.isNotEmpty) {
        sumPay = totalPay.reduce((a, b) => a + b).obs;
        sumPay.refresh();
      }
    });
    Hive.box<AddNewGet>('getBox').values.forEach((element) {
      if (element.date == dateToSave.value) {
        addGetMoney.add(element);
        totalGet.add(int.parse(replaseingNumbersFaToEn(element.price)));
      }
      if (totalGet.isNotEmpty) {
        sumGet = totalGet.reduce((a, b) => a + b).obs;
      }
    });
    Hive.box<AddNewBudget>('budgetBox').values.forEach((element) {
      if (element.date == dateToSave.value) {
        addBudget.add(element);
        totalBudget.add(int.parse(replaseingNumbersFaToEn(element.price)));
      }
    });
  }

  @override
  void onInit() {
    addMoneyItemToRxLists();
    Hive.box<AddNewPay>('payBox').watch().listen((event) {
      addMoneyItemToRxLists();
    });
    Hive.box<AddNewGet>('getBox').watch().listen((event) {
      addMoneyItemToRxLists();
    });
    Hive.box<AddNewBudget>('budgetBox').watch().listen((event) {
      addMoneyItemToRxLists();
    });
    super.onInit();
  }
}
