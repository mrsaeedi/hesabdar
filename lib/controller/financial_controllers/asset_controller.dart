import 'package:get/get.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AssetController extends GetxController {
  RxList<MoneyAssets> moneyAssetsList = <MoneyAssets>[].obs;

  void assetsResult1() {
    Hive.box<MoneyAssets>('assetsBox').values.forEach((element) {});
    // Hive.box<AddNewPay>('payBox').values.forEach((element) {});
    // Hive.box<AddNewGet>('getBox').values.forEach((element) {});
  }

  void addAssetToList() {
    moneyAssetsList.clear();
    Get.put(ReportController()).assetsOfMoney.clear();
    Hive.box<MoneyAssets>('assetsBox').values.forEach((element) {
      moneyAssetsList.add(element);
      Get.put(ReportController()).assetsOfMoney.add(element.name);
    });
  }

  void removeAssetToList(index) {
    Hive.box<MoneyAssets>('assetsBox').deleteAt(index);
  }

  @override
  void onInit() {
    addAssetToList();
    super.onInit();
  }
}
