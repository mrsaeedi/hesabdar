import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number_separator%20.dart';
import 'package:hesabdar/controller/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/category_items_mode.dart';
import 'package:hesabdar/view/payment_cat.dart';
import 'package:hesabdar/view/result_page.dart';
import '../components/change_number_to_persion.dart';
import '../components/papular_components.dart';

class NewPaymentPage extends StatelessWidget {
  NewPaymentPage({super.key});

  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  // String _weekDay = '';
  Text star = Text(
    '*',
    style: TextStyle(color: Colors.red),
  );
  int selectedItem = Get.put(ResultPageController()).controller.value.index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //! header and descriptions
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        addNewPeymentController.editMode
                            ? 'ویرایش'
                            : (selectedItem == 0)
                                ? 'خرج جدید'
                                : (selectedItem == 1)
                                    ? 'درآمد جدید'
                                    : 'بودجه جدید',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //! textformefild for price
                    Expanded(
                      child: Container(
                        width: Get.width,
                        //!
                        child: Obx(() => TextFormField(
                              controller: addNewPeymentController
                                  .controllerPrice, // افزودن کنترلر به فیلد متنی

                              inputFormatters: [
                                PersianNumberFormatter(),
                                ThousandsSeparatorInputFormatter(),
                                PersianNumericTextInputFormatter(),
                                LengthLimitingTextInputFormatter(11),
                              ],
                              onChanged: (value) {
                                addNewPeymentController
                                    .isClearButtonPressed.value = value.isEmpty;
                              },
                              keyboardType: TextInputType
                                  .number, // تنظیم نوع کیبورد به عددی
                              //! stile of field
                              decoration: InputDecoration(
                                suffixIcon: addNewPeymentController
                                        .isClearButtonPressed.value
                                    ? null
                                    : IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          addNewPeymentController
                                              .controllerPrice
                                              .clear();
                                          addNewPeymentController
                                              .isClearButtonPressed
                                              .value = true;
                                        },
                                      ),
                                labelText: 'مبلغ *',
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 119, 119)),
                                hintText: 'مبلغ ',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 168, 168,
                                        168)), // متن نکته داخل فیلد
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // رنگ بردر در حالت فوکوس
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors
                                          .grey), // رنگ بردر در حالت غیر فوکوس
                                ),
                                border:
                                    const OutlineInputBorder(), // قسمت border
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 10), // فاصله بین متن و border
                              ),
                              //
                            )),
                      ),
                    ),

                    widthOf(16),
                    //! dropdownButton for choose asset
                    Container(
                        height: 65,
                        width: Get.width / 3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 138, 138, 138),
                                style: BorderStyle.solid)),
                        child: Obx(() => DropdownButton(
                              hint: Row(
                                children: [
                                  Text('از...'),
                                  Text(
                                    '*',
                                  ),
                                ],
                              ),
                              underline: SizedBox(),
                              elevation: 1,
                              isExpanded: true,
                              padding: EdgeInsets.all(10),
                              value: addNewPeymentController
                                          .selectedAssetsOfMoney.value ==
                                      ""
                                  ? null
                                  : addNewPeymentController
                                      .selectedAssetsOfMoney.value,
                              onChanged: (newvalue) {
                                addNewPeymentController
                                    .upDateSelectedAssets(newvalue.toString());
                              },
                              items: addNewPeymentController.assetsOfMoney
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text('از ${value}'),
                                );
                              }).toList(),
                            ))),
                  ],
                ),
              ),
              //! choose time and date row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 138, 138, 138),
                                style: BorderStyle.solid)),
                        child: Center(
                          child: CustomDatePicker(
                            seletedAction: 0,
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => ChooseDateAndTime(
                        lable: addNewPeymentController
                                    .selectedTime.value.minute <
                                10
                            ? '0${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}'
                            : '${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}',
                        ontap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: Get.find<AddNewPeymentController>()
                                  .selectedTime
                                  .value,
                              initialEntryMode: TimePickerEntryMode.dial);
                          if (timeOfDay != null) {
                            Get.find<AddNewPeymentController>()
                                .selectedTime
                                .value = timeOfDay;
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              //! choose category
              InkWell(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(8),
                  height: 65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 138, 138, 138),
                          style: BorderStyle.solid)),
                  child: Center(
                      child: Obx(
                    () => Text(
                      addNewPeymentController.selectedCategoryName.value,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  )),
                ),
                onTap: () => Get.to(PaymentCat()),
              ),
              //! text fild for other Description
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(
                  maxLines: 3,
                  controller: addNewPeymentController.describtionController,
                  decoration: const InputDecoration(
                    labelText: 'توضیحات',
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 119, 119, 119)),
                    hintText: 'سایر توضیحات',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(
                            255, 168, 168, 168)), // متن نکته داخل فیلد
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // رنگ بردر در حالت فوکوس
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // رنگ بردر در حالت غیر فوکوس
                    ),
                    border: OutlineInputBorder(), // قسمت border
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20), // فاصله بین متن و border
                  ),
                ),
              ),
              heightOf(100),
              InkWell(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  padding: EdgeInsets.all(8),
                  height: 65,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 32, 228, 211),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 182, 182, 182),
                          style: BorderStyle.solid)),
                  child: Center(
                    child: Text(
                      'ثبت',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                onTap: () {
                  if (addNewPeymentController.controllerPrice != null &&
                      addNewPeymentController.selectedCategoryName !=
                          categoryNameTitle &&
                      addNewPeymentController.selectedAssetsOfMoney.value !=
                          null) {
                    addNewPeymentController.editMode
                        ? editMoneyPaymentItem(
                            addNewPeymentController.editIndex)
                        : addNewMoneyItem();
                    Get.offAll(RsuletPage());
                  } else {
                    Get.showSnackbar(
                      GetSnackBar(
                        message: 'آیتم های ستاره دار را تکمیل کنید',
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  editMoneyPaymentItem(index) {
    if (selectedItem == 0) {
      addNewPeymentController.addedPayData[index].price =
          addNewPeymentController.controllerPrice.text;
      addNewPeymentController.addedPayData[index].time = addNewPeymentController
                  .selectedTime.value.minute <
              10
          ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
          : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}';
      addNewPeymentController.addedPayData[index].date = 'newdate';
      addNewPeymentController.addedPayData[index].describtion =
          addNewPeymentController.describtionController.text;
      addNewPeymentController.addedPayData[index].listOfcat.name =
          addNewPeymentController.selectedCategoryName.value;
      addNewPeymentController.addedPayData[index].listOfcat.catIcon =
          Icon(Icons.new_label);
    }
    // add to get money data
    else if (selectedItem == 1) {
      addNewPeymentController.addGetMoney[index].price =
          addNewPeymentController.controllerPrice.text;
      addNewPeymentController.addGetMoney[index].time = addNewPeymentController
                  .selectedTime.value.minute <
              10
          ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
          : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}';
      addNewPeymentController.addGetMoney[index].date = 'newdate';
      addNewPeymentController.addGetMoney[index].describtion =
          addNewPeymentController.describtionController.text;
      addNewPeymentController.addGetMoney[index].listOfcat.name =
          addNewPeymentController.selectedCategoryName.value;
      addNewPeymentController.addGetMoney[index].listOfcat.catIcon =
          Icon(Icons.new_label);
    }
    // add to budget
    else {
      addNewPeymentController.addBudget[index].price =
          addNewPeymentController.controllerPrice.text;
      addNewPeymentController.addBudget[index].time = addNewPeymentController
                  .selectedTime.value.minute <
              10
          ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
          : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}';
      addNewPeymentController.addBudget[index].date = 'newdate';
      addNewPeymentController.addBudget[index].describtion =
          addNewPeymentController.describtionController.text;
      addNewPeymentController.addBudget[index].listOfcat.name =
          addNewPeymentController.selectedCategoryName.value;
      addNewPeymentController.addBudget[index].listOfcat.catIcon =
          Icon(Icons.new_label);
    }
    Get.back();
  }

  addNewMoneyItem() {
    // add to payed data
    if (selectedItem == 0) {
      addNewPeymentController.addedPayData.add(MoneyModell(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: 'date',
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icon(Icons.new_label))));
    }
    // add to get money data
    else if (selectedItem == 1) {
      addNewPeymentController.addGetMoney.add(MoneyModell(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: 'date',
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icon(Icons.new_label))));
    }
    // add to budget
    else {
      addNewPeymentController.addBudget.add(MoneyModell(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: 'date',
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icon(Icons.new_label))));
    }
    Get.to(RsuletPage());
  }
}

class ChooseDateAndTime extends StatelessWidget {
  String lable;
  VoidCallback ontap;
  // Widget? child;
  ChooseDateAndTime({
    Key? key,
    required this.lable,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: InkWell(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 138, 138, 138),
                  style: BorderStyle.solid)),
          child: Center(
            child: Text(
              lable,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
