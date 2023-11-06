import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddNewPeymentController extends GetxController {
  RxList addedPayData = <MoneyModell>[].obs; // List of amount spent
  RxList addGetMoney = <MoneyModell>[].obs; // List of received amount
  RxList addBudget = <MoneyModell>[].obs; // Registered budget list
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
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumersEnToFa(Jalali.now().year.toString())}/${replaseingNumersEnToFa(Jalali.now().month.toString())}/${replaseingNumersEnToFa(Jalali.now().day.toString())}';
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
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumersEnToFa(Jalali.now().year.toString())}/${replaseingNumersEnToFa(Jalali.now().month.toString())}/${replaseingNumersEnToFa(Jalali.now().day.toString())}'
          .obs;
  Rx<IconData?> selectedCategoryIcon = Rx<IconData?>(null);
  RxString selectedCategoryName = categoryNameTitle.obs;

  // select
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());

  RxBool isClearButtonPressed = true.obs;
  Rx selectedAssetsOfMoneyList = Rx([]);
  final List<String> assetsOfMoney = ['جیب', 'کیف پول', 'کارت سپه'];

  var selectedAssetsOfMoney = ''.obs;
  void upDateSelectedAssets(String value) {
    selectedAssetsOfMoney.value = value;
  }

  RxString dateToSave =
      '${getPersianWeekDay(Jalali.now())} __ ${replaseingNumersEnToFa(Jalali.now().year.toString())}/${replaseingNumersEnToFa(Jalali.now().month.toString())}/${replaseingNumersEnToFa(Jalali.now().day.toString())}'
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
        totalPay.add(int.parse(replaseingNumersFaToEn(element.price)));
      }
      if (totalPay.isNotEmpty) {
        sumPay = totalPay.reduce((a, b) => a + b).obs;
        sumPay.refresh();
      }
    });
    Hive.box<AddNewGet>('getBox').values.forEach((element) {
      if (element.date == dateToSave.value) {
        addGetMoney.add(element);
        totalGet.add(int.parse(replaseingNumersFaToEn(element.price)));
      }
      if (totalGet.isNotEmpty) {
        sumGet = totalGet.reduce((a, b) => a + b).obs;
      }
    });
    Hive.box<AddNewBudget>('budgetBox').values.forEach((element) {
      if (element.date == dateToSave.value) {
        addBudget.add(element);
        totalBudget.add(int.parse(replaseingNumersFaToEn(element.price)));
      }
      ;
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
