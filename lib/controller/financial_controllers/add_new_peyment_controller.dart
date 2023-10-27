import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hive/hive.dart';

import '../../model/financial_models/category_items_model.dart';

class AddNewPeymentController extends GetxController {
  RxList addedPayData = <MoneyModell>[].obs; // List of amount spent
  RxList addGetMoney = <MoneyModell>[].obs; // List of received amount
  RxList addBudget = <MoneyModell>[].obs; // Registered budget list
  final RxInt openIndex = RxInt(-1);
  void onTap(int index) {
    if (openIndex.value == index) {
      openIndex.value = -1;
    } else {
      openIndex.value = index;
    }
  }

  List myMapList = [];

  int? editIndex;

  bool editMode = false;
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController describtionController = TextEditingController();
  RxString dateValue = 'تاریخ'.obs;

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

  void addMoneyItemToRxLists() {
    final payItems = Hive.box<AddNewPay>('payBox').values.toList();
    final getItems = Hive.box<AddNewGet>('getBox').values.toList();
    final budgetItems = Hive.box<AddNewBudget>('budgetBox').values.toList();
    addedPayData.clear();
    addGetMoney.clear();
    addBudget.clear();
    addedPayData.value = payItems;
    addGetMoney.value = getItems;
    addBudget.value = budgetItems;
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
