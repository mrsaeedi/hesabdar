import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/number_separator%20.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/financial_controllers/category_items_controller.dart';
import 'package:hesabdar/controller/financial_controllers/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/home.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';
import 'package:hesabdar/model/financial_models/money.dart';
import 'package:hesabdar/view/financial/payment_cat.dart';
import 'package:hive/hive.dart';
import '../../components/number/change_number_to_persion.dart';
import '../../components/papular_components.dart';

class NewPaymentPage extends StatelessWidget {
  NewPaymentPage({super.key});

  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());

  final int selectedItem =
      Get.put(ResultPageController()).controller.value.index;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              //! header and descriptions
              HeaderAndDescrieption(
                  addNewPeymentController: addNewPeymentController,
                  selectedItem: selectedItem),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //! textformefild for price
                    GetPriceWidget(
                        addNewPeymentController: addNewPeymentController),

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
                              hint: const Row(
                                children: [
                                  Text('از...*'),
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
              ElevatedButton(
                  onPressed: () {
                    Get.isDarkMode
                        ? Get.changeThemeMode(ThemeMode.light)
                        : Get.changeThemeMode(ThemeMode.dark);
                  },
                  child: Icon(
                      Get.isDarkMode ? Icons.light_mode : Icons.dark_mode)),
              //! choose time and date row
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DatePickerChoseWidget(),
                    //
                    TimePicerChoose(
                        addNewPeymentController: addNewPeymentController)
                  ],
                ),
              ),
              //! choose category
              ChoosePayCat(addNewPeymentController: addNewPeymentController),
              //! text fild for other Description
              OtherDerscriptionWidget(
                  addNewPeymentController: addNewPeymentController),
              heightOf(100),
              //! submit button
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
                onTap: () async {
                  if (addNewPeymentController.controllerPrice != null &&
                      addNewPeymentController.selectedCategoryName !=
                          categoryNameTitle &&
                      addNewPeymentController.selectedAssetsOfMoney.value !=
                          null) {
                    addNewPeymentController.editMode
                        ? await editMoneyPaymentItem(
                            addNewPeymentController.editIndex)
                        : addNewMoneyItem();
                    Get.offAll(HomePage());
                    addNewPeymentController.addBudget.refresh();
                    addNewPeymentController.totalGet.refresh();
                    addNewPeymentController.totalPay.refresh();
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

  editMoneyPaymentItem(index) async {
    if (selectedItem == 0) {
      await Hive.box<AddNewPay>('payBox').putAt(
          index,
          AddNewPay(
              price: addNewPeymentController.controllerPrice.text,
              time: addNewPeymentController.selectedTime.value.minute < 10
                  ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
                  : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
              date: addNewPeymentController.dateValue.value,
              describtion: addNewPeymentController.describtionController.text,
              frome: addNewPeymentController.addedPayData[index].frome,
              listOfcat: ListOfcat(
                  catIcon: Icons.new_label,
                  name: addNewPeymentController.selectedCategoryName.value)));
    } else if (selectedItem == 1) {
      await Hive.box<AddNewGet>('getBox').putAt(
          index,
          AddNewGet(
              price: addNewPeymentController.controllerPrice.text,
              time: addNewPeymentController.selectedTime.value.minute < 10
                  ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
                  : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
              date: addNewPeymentController.dateValue.value,
              describtion: addNewPeymentController.describtionController.text,
              frome: addNewPeymentController.addedPayData[index].frome,
              listOfcat: ListOfcat(
                  catIcon: Icons.new_label,
                  name: addNewPeymentController.selectedCategoryName.value)));
    } else {
      await Hive.box<AddNewBudget>('budgetBox').putAt(
          index,
          AddNewBudget(
              price: addNewPeymentController.controllerPrice.text,
              time: addNewPeymentController.selectedTime.value.minute < 10
                  ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
                  : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
              date: addNewPeymentController.dateValue.value,
              describtion: addNewPeymentController.describtionController.text,
              frome: addNewPeymentController.addedPayData[index].frome,
              listOfcat: ListOfcat(
                  catIcon: Icons.new_label,
                  name: addNewPeymentController.selectedCategoryName.value)));
    }
    addNewPeymentController.editIndex = index;
    addNewPeymentController.editMode = true;
    Get.to(() => NewPaymentPage());
  }

  addNewMoneyItem() async {
    // add to payed data
    if (selectedItem == 0) {
      await Hive.box<AddNewPay>('payBox').add(AddNewPay(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: addNewPeymentController.dateValue.value,
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icons.new_label)));
    }
    // add to get money data
    else if (selectedItem == 1) {
      await Hive.box<AddNewGet>('getBox').add(AddNewGet(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: addNewPeymentController.dateValue.value,
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icons.new_label)));
    }
    // add to budget
    else {
      await Hive.box<AddNewBudget>('budgetBox').add(AddNewBudget(
          price: addNewPeymentController.controllerPrice.text,
          time: addNewPeymentController.selectedTime.value.minute < 10
              ? '۰${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
              : '${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',
          date: addNewPeymentController.dateValue.value,
          describtion: addNewPeymentController.describtionController.text,
          frome: addNewPeymentController.selectedAssetsOfMoney.value,
          listOfcat: ListOfcat(
              name: addNewPeymentController.selectedCategoryName.value,
              catIcon: Icons.new_label)));
    }
    addNewPeymentController.addMoneyItemToRxLists();
    // addNewPeymentController.addedPayData.clear();
    // addNewPeymentController.addGetMoney.clear();
    // addNewPeymentController.addBudget.clear();
    // addNewPeymentController.totalGet.clear();
    // addNewPeymentController.totalPay.clear();
    // addNewPeymentController.sumGet = 0;
    // addNewPeymentController.sumPay = 0;
  }
}

class OtherDerscriptionWidget extends StatelessWidget {
  const OtherDerscriptionWidget({
    super.key,
    required this.addNewPeymentController,
  });

  final AddNewPeymentController addNewPeymentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: TextField(
        maxLines: 3,
        controller: addNewPeymentController.describtionController,
        decoration: const InputDecoration(
          labelText: 'توضیحات',
          labelStyle: TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 119, 119, 119)),
          hintText: 'سایر توضیحات',
          hintStyle: TextStyle(
              color: Color.fromARGB(255, 168, 168, 168)), // متن نکته داخل فیلد
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey), // رنگ بردر در حالت فوکوس
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey), // رنگ بردر در حالت غیر فوکوس
          ),
          border: OutlineInputBorder(), // قسمت border
          contentPadding: EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 20), // فاصله بین متن و border
        ),
      ),
    );
  }
}

class ChoosePayCat extends StatelessWidget {
  const ChoosePayCat({
    super.key,
    required this.addNewPeymentController,
  });
  static CategoryItemsController catController = CategoryItemsController();

  final AddNewPeymentController addNewPeymentController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              style: Get.textTheme.bodyLarge,
            ),
          )),
        ),
        onTap: () async {
          recentlyUsedCatShow.clear();
          for (final element in catController.listBox.values) {
            for (final ListOfcat i in element) {
              recentlyUsedCatShow.add(i);
            }
          }
          Get.to(PaymentCat());
        });
  }
}

class TimePicerChoose extends StatelessWidget {
  const TimePicerChoose({
    super.key,
    required this.addNewPeymentController,
  });

  final AddNewPeymentController addNewPeymentController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ChooseDateAndTime(
        lable: addNewPeymentController.selectedTime.value.minute < 10
            ? '0${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}'
            : '${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}',
        ontap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime:
                  Get.find<AddNewPeymentController>().selectedTime.value,
              initialEntryMode: TimePickerEntryMode.dial);
          if (timeOfDay != null) {
            Get.find<AddNewPeymentController>().selectedTime.value = timeOfDay;
          }
        },
      ),
    );
  }
}

class DatePickerChoseWidget extends StatelessWidget {
  const DatePickerChoseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
    );
  }
}

class GetPriceWidget extends StatelessWidget {
  const GetPriceWidget({
    super.key,
    required this.addNewPeymentController,
  });

  final AddNewPeymentController addNewPeymentController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
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
                addNewPeymentController.isClearButtonPressed.value =
                    value.isEmpty;
              },
              keyboardType: TextInputType.number, // تنظیم نوع کیبورد به عددی
              //! stile of field
              decoration: InputDecoration(
                suffixIcon: addNewPeymentController.isClearButtonPressed.value
                    ? null
                    : IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          addNewPeymentController.controllerPrice.clear();
                          addNewPeymentController.isClearButtonPressed.value =
                              true;
                        },
                      ),
                labelText: 'مبلغ *',
                labelStyle: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 119, 119, 119)),
                hintText: 'مبلغ ',
                hintStyle: const TextStyle(
                    color: Color.fromARGB(
                        255, 168, 168, 168)), // متن نکته داخل فیلد
                focusedBorder: const OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey), // رنگ بردر در حالت فوکوس
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey), // رنگ بردر در حالت غیر فوکوس
                ),
                border: const OutlineInputBorder(), // قسمت border
                contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10), // فاصله بین متن و border
              ),
              //
            )),
      ),
    );
  }
}

class HeaderAndDescrieption extends StatelessWidget {
  const HeaderAndDescrieption({
    super.key,
    required this.addNewPeymentController,
    required this.selectedItem,
  });

  final AddNewPeymentController addNewPeymentController;
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

class ChooseDateAndTime extends StatelessWidget {
  final String lable;
  final VoidCallback ontap;
  // Widget? child;
  const ChooseDateAndTime({
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
              style: Get.textTheme.bodyLarge,
            ),
          ),
        ),
      ),
    );
  }
}