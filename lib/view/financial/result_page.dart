import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/financial/result_payment_item.dart';

class RsultPage extends StatelessWidget {
  final ResultPageController resultPageController =
      Get.put(ResultPageController());
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());

  RsultPage({super.key});
  @override
  Widget build(BuildContext context) {
//! محتوای تب ها
    final List<Widget> tabContents = <Widget>[
      CardItemGet(
        selectedItem: 0,
      ),
      CardItemGet(selectedItem: 1),
      CardItemGet(selectedItem: 2),
    ];

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: CustomDatePicker(
                seletedAction: 1,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //! total part
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Color.fromARGB(144, 192, 192, 192),
                          style: BorderStyle.solid),
                      color: Get.isDarkMode
                          ? Color.fromARGB(101, 0, 0, 0)
                          : AllColors.kWhite,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'درآمد روز :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Obx(() => Text(
                              // addNewPeymentController.sumGet.toString(),
                              replaseingNumbersEnToFa(addCommasToNumber(
                                  addNewPeymentController.sumGet.value)),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 3, 202, 9)),
                            )),
                        Text(
                          'هزینه روز :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Obx(() => Text(
                              replaseingNumbersEnToFa(addCommasToNumber(
                                  addNewPeymentController.sumPay.value)),
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            )),
                      ],
                    ),
                  ),
                ),
              ),

              //! nav
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(0, 255, 255, 255),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(255, 212, 212, 212), // رنگ border
                      width: 1.0, // ضخامت border
                    ),
                  ),
                ),
                child: TabBar(
                  onTap: (value) {
                    controller.refresh();
                  },
                  controller: controller.value,
                  indicator: const UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 45, 201, 201),
                      width: 4,
                    ),
                    insets: EdgeInsets.fromLTRB(5, 0, 5, 0), // پدینگ گوشه‌ها
                  ),
                  tabs: resultPageController.myTabs,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TabBarView(
                    controller: controller.value,
                    children: tabContents,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
