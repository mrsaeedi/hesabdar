import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/financial_controllers/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/financial/add_new-payment.dart';
import 'package:hesabdar/view/financial/test.dart';

class RsultPage extends StatelessWidget {
  final ResultPageController resultPageController =
      Get.put(ResultPageController());
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
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
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
              elevation: 0,
              backgroundColor: AllColors.primaryColor,
              onPressed: () {
                addNewPeymentController.controllerPrice.clear();
                addNewPeymentController.describtionController.clear();
                addNewPeymentController.selectedCategoryName =
                    categoryNameTitle.obs;
                addNewPeymentController.selectedAssetsOfMoney.value = '';
                null.toString();
                addNewPeymentController.editMode = false;
                // addNewPeymentController.selectedCategoryIcon.value = null;
                Get.to(() => NewPaymentPage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Obx(() => Text(
                  //       resultPageController.controller.value.index == 0
                  //           ? 'خرج جدید'
                  //           : (resultPageController.controller.value.index == 1)
                  //               ? 'درآمد جدید'
                  //               : 'بودجه جدید',
                  //     )),
                  Icon(Icons.add),
                ],
              )),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //! header part
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       vertical: 10.0, horizontal: 20.0),
              //   child: Container(
              //     child: CustomDatePicker(
              //       seletedAction: 1,
              //     ),
              //   ),
              // ),

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
                        Text(
                          '۲۵.۱۷۳.۰۰۰',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 3, 202, 9)),
                        ),
                        Text(
                          'هزینه روز :',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '۳۴۳.۰۰۰',
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
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
                  controller: resultPageController.controller.value,
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
                    controller: resultPageController.controller.value,
                    children: tabContents,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
