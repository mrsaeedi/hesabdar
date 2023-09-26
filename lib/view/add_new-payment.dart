import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number_separator%20.dart';
import 'package:hesabdar/controller/add_new_peyment_controller.dart';
import '../components/change_number_to_persion.dart';
import '../components/papular_components.dart';

class NewPaymentPage extends StatelessWidget {
  NewPaymentPage({super.key});
  final TextEditingController _controllerPrice = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
//! header and descriptions
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'خرج جدید',
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
                            controller:
                                _controllerPrice, // افزودن کنترلر به فیلد متنی

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
                                        _controllerPrice.clear();
                                        addNewPeymentController
                                            .isClearButtonPressed.value = true;
                                      },
                                    ),
                              labelText: 'مبلغ',
                              labelStyle: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 119, 119, 119)),
                              hintText: 'مبلغ',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 168, 168,
                                      168)), // متن نکته داخل فیلد
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Colors.grey), // رنگ بردر در حالت فوکوس
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // رنگ بردر در حالت غیر فوکوس
                              ),
                              border: const OutlineInputBorder(), // قسمت border
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
                            hint: Text('از...'),
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
                                .map<DropdownMenuItem<String>>((String value) {
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
                  ChooseDateAndTime(
                    lable: 'تاریخ',
                  ),
                  Obx(
                    () => ChooseDateAndTime(
                      lable: addNewPeymentController.selectedTime.value.minute <
                              10
                          ? '0${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}'
                          : '${addNewPeymentController.selectedTime.value.minute}: ${addNewPeymentController.selectedTime.value.hour}',
                    ),
                  )
                ],
              ),
            ),
//! choose category
            Container(
                margin: EdgeInsets.all(8),
                height: 80,
                width: double.infinity,
                child: ChooseDateAndTime(
                  lable: ' از بابت',
                )),
//! text fild for other Description
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: TextField(
                maxLines: 3,
                controller: _textFieldController,
                decoration: const InputDecoration(
                  labelText: 'توضیحات',
                  labelStyle: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 119, 119, 119)),
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
                      vertical: 20.0, horizontal: 20), // فاصله بین متن و border
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChooseDateAndTime extends StatelessWidget {
  String lable;
  ChooseDateAndTime({
    Key? key,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime:
                  Get.find<AddNewPeymentController>().selectedTime.value,
              initialEntryMode: TimePickerEntryMode.dial);
          if (timeOfDay != null) {
            Get.find<AddNewPeymentController>().selectedTime.value = timeOfDay;
          }
        },
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
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
