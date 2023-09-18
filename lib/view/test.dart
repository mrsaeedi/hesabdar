import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_page_controller.dart';

class MyWidgetGet extends StatelessWidget {
  final MyWidgetController controller = Get.put(MyWidgetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Obx(() => CardItemGet(
                index: index,
                isOpen: controller.openIndex.value == index,
                onTap: () => controller.onTap(index),
              ));
        },
      ),
    );
  }
}

class CardItemGet extends StatelessWidget {
  final int index;
  final bool isOpen;
  final VoidCallback onTap;

  const CardItemGet({
    Key? key,
    required this.index,
    required this.isOpen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 12, 0),
      child: Card(
        color: Color.fromARGB(255, 240, 240, 240),
        child: Column(
          children: [
            InkWell(
              onTap: onTap,
              splashColor: Colors.transparent,
              excludeFromSemantics: true,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '۷۸.۴۰۰',
                          style: TextStyle(fontSize: 16, color: Colors.red),
                        ),
                        Text(
                          'از کارت سپه',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Row(
                          children: [
                            Text(
                              '۱۸:۳۳',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Icon(
                              Icons.access_time,
                              color: Colors.grey,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'سوپر مارکت',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          '۶۵.۰۰۰ باقی مانده',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isOpen)
              // const Divider(
              //   endIndent: 15,
              //   indent: 15,
              //   height: 1,
              //   color: Color.fromARGB(143, 187, 187, 187),
              // ),
              AnimatedContainer(
                width: Get.width,
                duration: Duration(milliseconds: 200),
                height: isOpen ? 35.0 : 0.0,
                color: Color.fromARGB(255, 255, 255, 255),
                child: isOpen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: Row(
                              children: [
                                Text('ویرایش',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Icon(
                                  Icons.edit_note,
                                  color: Color.fromARGB(255, 27, 190, 169),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            color: Color.fromARGB(144, 175, 175, 175),
                            thickness: 1,
                            width: 10,
                          ),
                          GestureDetector(
                            child: Row(
                              children: [
                                Text('حذف',
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
                                Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
