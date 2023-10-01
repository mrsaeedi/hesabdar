import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Rx<TabController> controller;

  final List<Tab> myTabs = <Tab>[
    Tab(
      child: TitleOfTabButtons(
        title: 'هزینه',
      ),
    ),
    Tab(
      child: TitleOfTabButtons(
        title: 'درآمد',
      ),
    ),
    Tab(
      child: TitleOfTabButtons(
        title: 'بودجه',
      ),
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

  void changeTabIndex(int index) {
    controller.value.animateTo(index);
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
  String? title;
  TitleOfTabButtons({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
