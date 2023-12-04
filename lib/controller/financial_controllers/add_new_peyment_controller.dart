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
  RxList<MoneyModell> addedPayData =
      <MoneyModell>[].obs; // List of amount spent
  RxList<MoneyModell> addGetMoney =
      <MoneyModell>[].obs; // List of received amount
  RxList<MoneyModell> addBudget = <MoneyModell>[].obs; // Registered budget list
  // RxString selectedAsset = ''.obs;
  RxInt selectedAssetIndex = 0.obs;
  RxString resultAsset = '0'.obs;

  RxString selectedAsset = ''.obs;

  Future<void> assetsResult1(int selectedItem, bool isEdit) async {
    resultAsset.value = '0';
    var assetsBox = Hive.box<MoneyAssets>('assetsBox');
    for (var element in assetsBox.values) {
      if (selectedAsset.value == element.name) {
        int price = int.parse(replaseingNumbersFaToEn(controllerPrice.text));
        if (isEdit) {
        } else {
          if (selectedItem == 0) {
            element.inventory -= price;
            resultAsset.value = element.inventory.toString();
          } else if (selectedItem == 1) {
            element.inventory += price;
            resultAsset.value = (element.inventory).toString();
          }
        }

        await assetsBox.putAt(selectedAssetIndex.value, element);
      }
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

  Rx<IconData?> selectedCategoryIcon = Rx<IconData?>(null);
  RxString selectedCategoryName = categoryNameTitle.obs;

  // select
  Rx<TimeOfDay> selectedTime = Rx<TimeOfDay>(TimeOfDay.now());

  RxBool isClearButtonPressed = true.obs;
  Rx selectedAssetsOfMoneyList = Rx([]);

  void upDateSelectedAssets(String value) {
    selectedAsset.value = value;
  }

  RxString dateToSave =
      '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}'
          .obs;

  void updatePayInHive(
      {selectedItem,
      id,
      price,
      describtion,
      date,
      resultAsset,
      listOfCat,
      from,
      time}) async {
    var boxPay = Hive.box<AddNewPay>('payBox');
    var boxGet = Hive.box<AddNewGet>('getBox');
    var boxBudget = Hive.box<AddNewBudget>('budgetBox');

    if (selectedItem == 0) {
      var itemToDeletePay = boxPay.values.firstWhere(
        (item) => item.id == id,
      );
      itemToDeletePay.listOfcat = listOfCat;
      itemToDeletePay.frome = from;
      itemToDeletePay.price = price;
      itemToDeletePay.describtion = describtion;
      itemToDeletePay.resultAsset = resultAsset;
      itemToDeletePay.time = time;
      itemToDeletePay.date = date;
      itemToDeletePay.id = id;
      await boxPay.put(itemToDeletePay.key, itemToDeletePay);
    } else if (selectedItem == 1) {
      var itemToDeleteGet = boxGet.values.firstWhere(
        (item) => item.id == id,
      );
      itemToDeleteGet.listOfcat = listOfCat;
      itemToDeleteGet.frome = from;
      itemToDeleteGet.price = price;
      itemToDeleteGet.describtion = describtion;
      itemToDeleteGet.resultAsset = resultAsset;
      itemToDeleteGet.date = time;
      itemToDeleteGet.date = date;
      itemToDeleteGet.id = id;
      await boxGet.put(itemToDeleteGet.key, itemToDeleteGet);
    } else {
      var itemToDeleteBudget = boxBudget.values.firstWhere(
        (item) => item.id == id,
      );
      itemToDeleteBudget.listOfcat = listOfCat;
      itemToDeleteBudget.frome = from;
      itemToDeleteBudget.price = price;
      itemToDeleteBudget.describtion = describtion;
      itemToDeleteBudget.resultAsset = resultAsset;
      itemToDeleteBudget.date = time;
      itemToDeleteBudget.date = date;
      itemToDeleteBudget.id = id;
      await boxBudget.put(itemToDeleteBudget.key, itemToDeleteBudget);
    }
  }

  void addMoneyItemToRxLists() {
    addedPayData.clear();
    addGetMoney.clear();
    totalBudget.clear();
    addBudget.clear();
    totalGet.clear();
    totalPay.clear();
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

  deleteMoneyItems(selectedItem, id) async {
    var boxPay = Hive.box<AddNewPay>('payBox');
    var boxGet = Hive.box<AddNewGet>('getBox');
    var boxBudget = Hive.box<AddNewBudget>('budgetBox');
    if (selectedItem == 0) {
      var itemToDeletePay = boxPay.values.firstWhere(
        (item) => item.id == id,
      );
      await boxPay.delete(itemToDeletePay.key);
    } else if (selectedItem == 1) {
      var itemToDeleteGet = boxGet.values.firstWhere(
        (item) => item.id == id,
      );
      await boxGet.delete(itemToDeleteGet.key);
    } else {
      var itemToDeleteBudget = boxBudget.values.firstWhere(
        (item) => item.id == id,
      );
      await boxBudget.delete(itemToDeleteBudget.key);
    }
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
