import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number_separator%20.dart';
import 'package:hesabdar/controller/add_new_peyment_controller.dart';
import 'package:persian_tools/persian_tools.dart';
import 'package:flutter/services.dart';
import '../components/change_number_to_persion.dart';
import '../components/papular_components.dart';

class NewPaymentPage extends StatelessWidget {
  NewPaymentPage({super.key});
  final TextEditingController _controllerPrice = TextEditingController();
  final AddNewPeymentController controller = Get.put(AddNewPeymentController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
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
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.width / 2,
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
                            Get.find<AddNewPeymentController>()
                                .isClearButtonPressed
                                .value = value.isEmpty;
                          },
                          keyboardType:
                              TextInputType.number, // تنظیم نوع کیبورد به عددی
                          //! stile of field
                          decoration: InputDecoration(
                            suffixIcon: Get.find<AddNewPeymentController>()
                                    .isClearButtonPressed
                                    .value
                                ? null
                                : IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _controllerPrice.clear();
                                      Get.find<AddNewPeymentController>()
                                          .isClearButtonPressed
                                          .value = true;
                                    },
                                  ),
                            labelText: 'مبلغ',
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 119, 119, 119)),
                            hintText: 'مبلغ',
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(
                                    255, 168, 168, 168)), // متن نکته داخل فیلد
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey), // رنگ بردر در حالت فوکوس
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
                  Container(
                    width: Get.width / 3,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
