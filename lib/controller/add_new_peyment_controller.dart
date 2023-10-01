import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/category_items_mode.dart';

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

  int? editIndex;

  bool editMode = false;
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController describtionController = TextEditingController();
  RxString dateValue = 'تاریخ'.obs;

  Rx<Icon?> selectedCategoryIcon = Rx<Icon?>(null);
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
}
