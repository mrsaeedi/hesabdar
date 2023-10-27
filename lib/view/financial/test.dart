// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hive/hive.dart';
import 'package:hive/hive.dart';

import 'add_new-payment.dart';

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
        child: Obx(() => ListView.builder(
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
                              onCancel: () {
                                deleteMoneyItems(index);
                              },
                              textCancel: 'حذف',
                              onConfirm: () {
                                editMoneyItems(index);
                              },
                              textConfirm: 'ویرایش');
                        },
                        onTap: () => addNewPeymentController.onTap(index),
                        splashColor: Colors.transparent,
                        excludeFromSemantics: true,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                            ? Color.fromARGB(255, 255, 110, 100)
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
                                            .addedPayData[index].listOfcat.name
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
                                        ? '${addNewPeymentController.addedPayData[index].price ?? '0'}: باقی مانده '
                                        : (selectedItem == 1)
                                            ? '${addNewPeymentController.addGetMoney[index].price ?? '0'}: باقی مانده '
                                            : '${addNewPeymentController.addBudget[index].price ?? '0'}: باقی مانده ',
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
                                height:
                                    addNewPeymentController.openIndex.value ==
                                            index
                                        ? 35.0
                                        : 0.0,
                                color: Color.fromARGB(255, 255, 255, 255),
                                child:
                                    addNewPeymentController.openIndex.value ==
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
            )));
  }

  deleteMoneyItems(index) {
    if (selectedItem == 0) {
      Hive.box<AddNewPay>('payBox').deleteAt(index);
      addNewPeymentController.addedPayData.removeAt(index);
    } else if (selectedItem == 1) {
      Hive.box<AddNewGet>('getBox').deleteAt(index);

      addNewPeymentController.addGetMoney.removeAt(index);
    } else if (selectedItem == 2) {
      Hive.box<AddNewBudget>('budgetBox').deleteAt(index);

      addNewPeymentController.addBudget.removeAt(index);
    }
  }

  editMoneyItems(index) {
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
    addNewPeymentController.editIndex = index;
    addNewPeymentController.editMode = true;
    Get.to(() => NewPaymentPage());
  }
}
