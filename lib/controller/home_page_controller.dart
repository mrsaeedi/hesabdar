import 'package:get/get.dart';

class HomePageController extends GetxController {
  final RxInt openIndex = RxInt(-1);

  void onTap(int index) {
    if (openIndex.value == index) {
      openIndex.value = -1;
    } else {
      openIndex.value = index;
    }
  }
}

class MyWidgetController extends GetxController {
  final RxInt openIndex = RxInt(-1);

  void onTap(int index) {
    if (openIndex.value == index) {
      openIndex.value = -1;
    } else {
      openIndex.value = index;
    }
  }
}
