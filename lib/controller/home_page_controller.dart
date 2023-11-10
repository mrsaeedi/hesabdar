import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/total_pay_get.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';

late Rx<TabController> controller;

class ResultPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(
      child: Obx(() => TitleOfTabButtons(
            isTrueLength:
                addNewPeymentController.addedPayData.isEmpty ? false : true,
            number: addNewPeymentController.totalPay.length.toString(),
            title: 'هزینه',
          )),
    ),
    Tab(
        child: Obx(
      () => TitleOfTabButtons(
        isTrueLength:
            addNewPeymentController.addGetMoney.isEmpty ? false : true,
        number: addNewPeymentController.totalGet.length.toString(),
        title: 'درآمد',
      ),
    )),
    Tab(
      child: Obx(() => TitleOfTabButtons(
            isTrueLength:
                addNewPeymentController.addBudget.isEmpty ? false : true,
            number: addNewPeymentController.totalBudget.length.toString(),
            title: 'بودجه',
          )),
    ),
  ];
  final RxInt openIndex = RxInt(-1);

  @override
  void onInit() {
    super.onInit();
    controller = Rx(TabController(
      vsync: this,
      length: myTabs.length,
    ));
  }

  @override
  void onClose() {
    controller.value.dispose();
    super.onClose();
  }

  void onTap(int index) {
    if (openIndex.value == index) {
      openIndex.value = -1;
    } else {
      openIndex.value = index;
    }
  }
}

class TitleOfTabButtons extends StatelessWidget {
  final bool isTrueLength;
  final String title;
  final String number;
  TitleOfTabButtons(
      {super.key,
      required this.title,
      required this.number,
      required this.isTrueLength});
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isTrueLength == true
            ? Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 102, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  height: 16,
                  width: 16,
                  child: Center(
                    child: Text(
                      // addNewPeymentController.sumGet.toString(),
                      replaseingNumbersEnToFa(number),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ))
            : SizedBox(),
        Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
