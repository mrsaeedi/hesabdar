import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AssetController extends GetxController {
  bool isEditOrSelect = false;
  RxList<MoneyAssets> moneyAssetsList = <MoneyAssets>[].obs;

  void addAssetToList() {
    moneyAssetsList.clear();
    Get.put(ReportController()).assetsOfMoney.clear();
    Hive.box<MoneyAssets>('assetsBox').values.forEach((element) {
      moneyAssetsList.add(element);
      Get.put(ReportController()).assetsOfMoney.add(element.name);
    });
  }

  void updateAssetList(name, inventory) {
    var assetBox = Hive.box<MoneyAssets>('assetsBox');
    var itemUpdateAsset = assetBox.values.firstWhere(
      (item) => item.name == name,
    );
    assetBox.put(
        itemUpdateAsset.key,
        MoneyAssets(
            name: name,
            inventory: int.parse(replaseingNumbersFaToEn(inventory))));
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
