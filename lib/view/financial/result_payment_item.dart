// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'add_new_payment.dart';

class CardItemGet extends StatelessWidget {
  final int selectedItem;
  CardItemGet({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
        child: Stack(
          children: [
            Obx(() => ListView.builder(
                  itemCount: (selectedItem == 0)
                      ? addNewPeymentController.addedPayData.length
                      : (selectedItem == 1)
                          ? addNewPeymentController.addGetMoney.length
                          : addNewPeymentController.addBudget.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Get.isDarkMode
                          ? Color.fromARGB(57, 197, 197, 197)
                          : Color.fromARGB(255, 240, 240, 240),
                      child: Column(
                        children: [
                          InkWell(
                            onLongPress: () {
                              Get.defaultDialog(
                                  title: '',
                                  middleText: '',
                                  onCancel: () async {
                                    await deleteMoneyItems(index);
                                    addNewPeymentController
                                        .addMoneyItemToRxLists();
                                  },
                                  textCancel: 'حذف',
                                  onConfirm: () async {
                                    await editMoneyItemsFillForms(index);
                                  },
                                  textConfirm: 'ویرایش');
                            },
                            onTap: () => addNewPeymentController.onTap(index),
                            splashColor: Colors.transparent,
                            excludeFromSemantics: true,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // pric or how mauch payed or get money
                                        (selectedItem == 0)
                                            ? '${addNewPeymentController.addedPayData[index].price}'
                                            : (selectedItem == 1)
                                                ? '${addNewPeymentController.addGetMoney[index].price}'
                                                : '${addNewPeymentController.addBudget[index].price}',

                                        style: TextStyle(
                                            fontSize: 17,
                                            color: (selectedItem == 0)
                                                ? Color.fromARGB(
                                                    255, 255, 110, 100)
                                                : (selectedItem == 1)
                                                    ? Colors.green
                                                    : (Get.isDarkMode)
                                                        ? Colors.white
                                                        : Color.fromARGB(
                                                            192, 0, 0, 0)),
                                      ),
                                      Text(
                                        // frome...
                                        (selectedItem == 0)
                                            ? '${addNewPeymentController.addedPayData[index].frome}'
                                            : (selectedItem == 1)
                                                ? '${addNewPeymentController.addGetMoney[index].frome}'
                                                : '${addNewPeymentController.addBudget[index].frome}',

                                        style: Get.textTheme.bodyMedium,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            // time...
                                            (selectedItem == 0)
                                                ? '${addNewPeymentController.addedPayData[index].time ?? ''}'
                                                : (selectedItem == 1)
                                                    ? '${addNewPeymentController.addGetMoney[index].time ?? ''}'
                                                    : '${addNewPeymentController.addBudget[index].time ?? ''}',

                                            style: Get.textTheme.bodySmall,
                                          ),
                                          Icon(
                                            //tiem icon
                                            Icons.access_time,
                                            color: Colors.grey,
                                            size: 16,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // frome...
                                        (selectedItem == 0)
                                            ? addNewPeymentController
                                                .addedPayData[index]
                                                .listOfcat
                                                .name
                                            : (selectedItem == 1)
                                                ? addNewPeymentController
                                                    .addGetMoney[index]
                                                    .listOfcat
                                                    .name
                                                : addNewPeymentController
                                                    .addBudget[index]
                                                    .listOfcat
                                                    .name,
                                        style: Get.textTheme.bodyMedium,
                                      ),
                                      Text(
                                        // result...
                                        (selectedItem == 0)
                                            ? '${addNewPeymentController.addedPayData[index].resultAsset ?? '0'}: باقی مانده '
                                            : (selectedItem == 1)
                                                ? '${addNewPeymentController.addGetMoney[index].resultAsset ?? '0'}: باقی مانده '
                                                : '',
                                        style: Get.textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          addNewPeymentController.openIndex.value == index
                              ? Obx(
                                  () => AnimatedContainer(
                                    width: Get.width,
                                    duration: Duration(milliseconds: 200),
                                    height: addNewPeymentController
                                                .openIndex.value ==
                                            index
                                        ? 35.0
                                        : 0.0,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    child: addNewPeymentController
                                                .openIndex.value ==
                                            index
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      // result...
                                                      (selectedItem == 0)
                                                          ? '${addNewPeymentController.addedPayData[index].describtion}: توضیحات'
                                                          : (selectedItem == 1)
                                                              ? '${addNewPeymentController.addGetMoney[index].describtion}: توضیحات '
                                                              : '${addNewPeymentController.addBudget[index].describtion}: توضیحات',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.red),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : null,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    );
                  },
                )),
            Positioned(
                bottom: 18,
                left: 16,
                child: ElevatedButton(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedItem == 0
                              ? 'هزینه جدید'
                              : (selectedItem == 1
                                  ? 'درآمد جدید'
                                  : 'بودجه جدید'),
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.add,
                          color: selectedItem == 0
                              ? Colors.red
                              : (selectedItem == 1
                                  ? Colors.green
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    addNewPeymentController.controllerPrice.clear();
                    addNewPeymentController.describtionController.clear();
                    addNewPeymentController.selectedCategoryName =
                        categoryNameTitle.obs;
                    addNewPeymentController.selectedAssetsOfMoney.value = '';
                    null.toString();
                    addNewPeymentController.editMode = false;
                    addNewPeymentController.dateValue.value =
                        '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
                    if (selectedItem == 0) {}
                    Get.to(() => NewPaymentPage());
                  },
                ))
          ],
        ));
  }

  deleteMoneyItems(index) async {
    if (selectedItem == 0) {
      await Hive.box<AddNewPay>('payBox').deleteAt(index);
      // await addNewPeymentController.addedPayData.removeAt(index);
    } else if (selectedItem == 1) {
      await Hive.box<AddNewGet>('getBox').deleteAt(index);
      // await addNewPeymentController.addGetMoney.removeAt(index);
    } else if (selectedItem == 2) {
      await Hive.box<AddNewBudget>('budgetBox').deleteAt(index);
      // await addNewPeymentController.addBudget.removeAt(index);
    }
  }

  editMoneyItemsFillForms(index) {
    if (selectedItem == 0) {
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addedPayData[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addedPayData[index].describtion;
      addNewPeymentController.selectedAssetsOfMoney.value =
          addNewPeymentController.addedPayData[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addedPayData[index].listOfcat.name;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addedPayData[index].listOfcat.catIcon;
    } else if (selectedItem == 1) {
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addGetMoney[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addGetMoney[index].describtion;
      addNewPeymentController.selectedAssetsOfMoney.value =
          addNewPeymentController.addGetMoney[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addGetMoney[index].listOfcat.name;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addGetMoney[index].listOfcat.catIcon;
    } else {
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addBudget[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addBudget[index].describtion;
      addNewPeymentController.selectedAssetsOfMoney.value =
          addNewPeymentController.addBudget[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addBudget[index].listOfcat.name;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addBudget[index].listOfcat.catIcon;
    }
    addNewPeymentController.dateValue.value =
        '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
    addNewPeymentController.editIndex = index;
    addNewPeymentController.editMode = true;
    Get.to(() => NewPaymentPage());
  }
}