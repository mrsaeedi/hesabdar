// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'add_new_payment.dart';

class CardItemGet extends StatefulWidget {
  final int selectedItem;

  const CardItemGet({
    Key? key,
    required this.selectedItem,
  }) : super(key: key);

  @override
  State<CardItemGet> createState() => _CardItemGetState();
}

class _CardItemGetState extends State<CardItemGet> {
  int selectedTile = -1;

  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(5, 0, 7, 0),
        child: Stack(
          children: [
            Obx(() => ListView.builder(
                  itemCount: (widget.selectedItem == 0)
                      ? addNewPeymentController.addedPayData.length
                      : (widget.selectedItem == 1)
                          ? addNewPeymentController.addGetMoney.length
                          : addNewPeymentController.addBudget.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Get.isDarkMode
                          ? Color.fromARGB(57, 197, 197, 197)
                          : Color.fromARGB(255, 240, 240, 240),
                      child: GestureDetector(
                        onLongPress: () {
                          Get.defaultDialog(
                              title: 'حذف شود؟',
                              middleText: '',
                              onCancel: () async {
                                await deleteMoneyItemsPage(index);
                                addNewPeymentController.addMoneyItemToRxLists();
                              },
                              textCancel: 'حذف',
                              onConfirm: () async {
                                await editMoneyItemsFillForms(index);
                              },
                              textConfirm: 'ویرایش');
                        },
                        child: Obx(() => ExpansionTile(
                              initiallyExpanded: index == selectedTile,
                              key: Key(selectedTile.toString()),
                              onExpansionChanged: (newState) {
                                setState(() {
                                  selectedTile = index;
                                });
                              },
                              // leading and price and category
                              leading: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // pric or how mauch payed or get money
                                    (widget.selectedItem == 0)
                                        ? addNewPeymentController
                                            .addedPayData[index].price
                                        : (widget.selectedItem == 1)
                                            ? addNewPeymentController
                                                .addGetMoney[index].price
                                            : addNewPeymentController
                                                .addBudget[index].price,
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: (widget.selectedItem == 0)
                                            ? Color.fromARGB(255, 255, 110, 100)
                                            : (widget.selectedItem == 1)
                                                ? Colors.green
                                                : (Get.isDarkMode)
                                                    ? Colors.white
                                                    : Color.fromARGB(
                                                        192, 0, 0, 0)),
                                  ),
                                  Text(
                                    // frome...
                                    (widget.selectedItem == 0)
                                        ? addNewPeymentController
                                            .addedPayData[index].listOfcat.name!
                                        : (widget.selectedItem == 1)
                                            ? addNewPeymentController
                                                .addGetMoney[index]
                                                .listOfcat
                                                .name!
                                            : addNewPeymentController
                                                .addBudget[index]
                                                .listOfcat
                                                .name!,
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              // from asset name
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    // frome...
                                    (widget.selectedItem == 0)
                                        ? addNewPeymentController
                                            .addedPayData[index].frome
                                        : (widget.selectedItem == 1)
                                            ? addNewPeymentController
                                                .addGetMoney[index].frome
                                            : addNewPeymentController
                                                .addBudget[index].frome,
                                    style: Get.textTheme.bodyMedium,
                                  ),
                                  SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                              // trailing and time and result
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        // time...
                                        (widget.selectedItem == 0)
                                            ? addNewPeymentController
                                                .addedPayData[index].time
                                            : (widget.selectedItem == 1)
                                                ? addNewPeymentController
                                                    .addGetMoney[index].time
                                                : addNewPeymentController
                                                    .addBudget[index].time,
                                        style: Get.textTheme.bodySmall,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        //tiem icon
                                        Icons.access_time,
                                        color: Colors.grey,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                  Text(
                                    // result...
                                    (widget.selectedItem == 0)
                                        ? '${replaseingNumbersEnToFa(addCommasToNumber(int.parse(addNewPeymentController.addedPayData[index].resultAsset)))} :باقی مانده '
                                        : (widget.selectedItem == 1)
                                            ? '${replaseingNumbersEnToFa(addCommasToNumber(int.parse(addNewPeymentController.addGetMoney[index].resultAsset)))} :باقی مانده '
                                            : '',
                                    style: Get.textTheme.bodySmall,
                                  ),
                                ],
                              ),
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(28, 146, 146, 146)),
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    // result...
                                    (widget.selectedItem == 0)
                                        ? 'توضیحات: ${addNewPeymentController.addedPayData[index].describtion}'
                                        : (widget.selectedItem == 1)
                                            ? 'توضیحات: ${addNewPeymentController.addGetMoney[index].describtion}'
                                            : 'توضیحات: ${addNewPeymentController.addBudget[index].describtion}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: const Color.fromARGB(
                                            255, 138, 138, 138)),
                                  ),
                                ),
                              ],
                            )),
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
                          widget.selectedItem == 0
                              ? 'هزینه جدید'
                              : (widget.selectedItem == 1
                                  ? 'درآمد جدید'
                                  : 'بودجه جدید'),
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Icon(
                          Icons.add,
                          color: widget.selectedItem == 0
                              ? Colors.red
                              : (widget.selectedItem == 1
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
                    addNewPeymentController.selectedAsset.value = '';
                    null.toString();
                    addNewPeymentController.editMode = false;
                    addNewPeymentController.dateValue.value =
                        '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
                    if (widget.selectedItem == 0) {}
                    Get.to(() => NewPaymentPage());
                  },
                ))
          ],
        ));
  }

  deleteMoneyItemsPage(index) async {
    if (widget.selectedItem == 0) {
      await addNewPeymentController.deleteMoneyItems(
          0, addNewPeymentController.addedPayData[index].id);
      // await .removeAt(index);
    } else if (widget.selectedItem == 1) {
      await addNewPeymentController.deleteMoneyItems(
          1, addNewPeymentController.addGetMoney[index].id);

      // await addNewPeymentController.addGetMoney.removeAt(index);
    } else if (widget.selectedItem == 2) {
      await addNewPeymentController.deleteMoneyItems(
          2, addNewPeymentController.addBudget[index].id);

      // await addNewPeymentController.addBudget.removeAt(index);
    }
  }

  editMoneyItemsFillForms(index) {
    if (widget.selectedItem == 0) {
      addNewPeymentController.dateValue.value =
          addNewPeymentController.addedPayData[index].date;
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addedPayData[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addedPayData[index].describtion;
      addNewPeymentController.selectedAsset.value =
          addNewPeymentController.addedPayData[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addedPayData[index].listOfcat.name!;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addedPayData[index].listOfcat.catIcon;
    } else if (widget.selectedItem == 1) {
      addNewPeymentController.dateValue.value =
          addNewPeymentController.addGetMoney[index].date;
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addGetMoney[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addGetMoney[index].describtion;
      addNewPeymentController.selectedAsset.value =
          addNewPeymentController.addGetMoney[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addGetMoney[index].listOfcat.name!;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addGetMoney[index].listOfcat.catIcon;
    } else {
      addNewPeymentController.dateValue.value =
          addNewPeymentController.addBudget[index].date;
      addNewPeymentController.controllerPrice.text =
          addNewPeymentController.addBudget[index].price;
      addNewPeymentController.describtionController.text =
          addNewPeymentController.addBudget[index].describtion;
      addNewPeymentController.selectedAsset.value =
          addNewPeymentController.addBudget[index].frome;
      addNewPeymentController.selectedCategoryName.value =
          addNewPeymentController.addBudget[index].listOfcat.name!;
      addNewPeymentController.selectedCategoryIcon.value =
          addNewPeymentController.addBudget[index].listOfcat.catIcon;
    }
    // addNewPeymentController.dateValue.value =
    //     '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
    addNewPeymentController.editIndex = index;
    addNewPeymentController.editMode = true;
    Get.to(() => NewPaymentPage());
  }
}
