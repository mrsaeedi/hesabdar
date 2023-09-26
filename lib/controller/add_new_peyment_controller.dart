import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewPeymentController extends GetxController {
  // select
  final Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());

//clear textFormField button controller

  RxBool isClearButtonPressed = true.obs;
  Rx selectedAssetsOfMoneyList = Rx([]);
  final List<String> assetsOfMoney = ['جیب', 'کیف پول', 'کارت سپه'];

  var selectedAssetsOfMoney = ''.obs;
  void upDateSelectedAssets(String value) {
    selectedAssetsOfMoney.value = value;
  }
}
