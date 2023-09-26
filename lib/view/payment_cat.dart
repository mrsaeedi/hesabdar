import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hesabdar/controller/category_items_controller.dart';

import 'package:hesabdar/model/category_items_mode.dart';

class PaymentCat extends StatelessWidget {
  static CategoryItemsController catController = CategoryItemsController();
  TextEditingController addTextController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  RxBool _showClearIcon = false.obs;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('انتخاب دسته بندی'),
          backgroundColor: Color.fromARGB(255, 107, 146, 158),
          titleTextStyle: TextStyle(fontSize: 22),
          actions: [],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleTextContainer(context, 'آخرین اتخاب'),
//! Recently selected items
            Container(
              height: 80,
              child: ListView.builder(
                itemCount: catController.recentlyUsedCat.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(15),
                    height: 80,
                    child: Text(
                      'data',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                },
              ),
            ),
            titleTextContainer(context, 'دسته بندی'),
            Expanded(
//! list view of items
              child: Obx(() => ListView.builder(
                    itemCount: catController.myMap.length,
                    itemBuilder: (context, index) {
                      String categoryName =
                          catController.myMap.keys.toList()[index];
                      List<ListOfcat> categoryItems =
                          catController.myMap.values.toList()[index];

                      return ExpansionTile(
                          title: Text(categoryName),
                          children: [
//! add new item
                            ListTile(
                              onTap: () {
                                //add new item in dialog box
                                Get.defaultDialog(
                                  barrierDismissible: false,
                                  title: 'اضافه کن',
                                  textCancel: 'لغو', onCancel: () => Get.back(),
                                  textConfirm: 'ذخیره',
                                  onConfirm: () {
                                    if (addTextController.text.isNotEmpty &&
                                        catController.selectedIcon.value !=
                                            null) {
                                      catController.addTextToMap(
                                          addTextController.text, index);
                                      //show added result in snackBar
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            message: 'آیتم جدید اضافه شد',
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      });
                                      Get.back();
                                    } else {
                                      Get.showSnackbar(
                                        GetSnackBar(
                                          message:
                                              'لطفا متن و آیکون را انتخاب کنید',
                                          icon: const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                          duration: const Duration(
                                              milliseconds: 1500),
                                        ),
                                      );
                                    }
                                  },
                                  // get name and icon about new item
                                  content: Row(
                                    children: [
                                      Expanded(
                                        // get text for items title
                                        flex: 5,
                                        child: Obx(() => TextField(
                                              onChanged: (value) {
                                                _showClearIcon.value =
                                                    value.isEmpty;
                                              },
                                              controller: addTextController,
                                              decoration: InputDecoration(
                                                  suffixIcon: _showClearIcon
                                                          .value
                                                      ? null
                                                      : IconButton(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          onPressed: () {
                                                            addTextController
                                                                .clear();
                                                            _showClearIcon
                                                                .value = true;
                                                          },
                                                          icon: Icon(
                                                              Icons.clear))),
                                              autofocus: true,
                                            )),
                                      ),
                                      // choose icon for items
                                      Expanded(
                                        flex: 2,
                                        child: Obx(() => DropdownButton(
                                              hint: Text('آیکون'),
                                              underline: SizedBox(),
                                              elevation: 2,
                                              isExpanded: true,
                                              padding: EdgeInsets.all(10),
                                              value: catController
                                                  .selectedIcon.value,
                                              items: [
                                                ...catController.assetsOfIcons
                                                    .map<
                                                        DropdownMenuItem<Icon>>(
                                                  (Icon value) {
                                                    return DropdownMenuItem(
                                                      value: value,
                                                      child: value,
                                                    );
                                                  },
                                                )
                                              ],
                                              onChanged: (newvalue) {
                                                catController
                                                    .upDateSelectedIcon(
                                                        newvalue!);
                                              },
                                            )),
                                      )
                                    ],
                                  ),
                                  // add changes and show result
                                );

                                addTextController.clear();
                                catController.selectedIcon.value = null;
                              },
                              title: Text('افزودن جدید'),
                              leading: Icon(
                                Icons.add_circle_outline,
                                color: Colors.blue,
                              ),
                            ),
                            ...categoryItems.map<Widget>((item) {
                              return ListTile(
                                onLongPress: () {
                                  editingController.text = item.name!;
                                  Get.defaultDialog(
                                    title: item.name!,
                                    middleText: '',
                                    radius: 12,
                                    textConfirm: 'ویرایش',
                                    onConfirm: () {
                                      // _showClearIcon.value = true;
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Get.defaultDialog(
                                          title: 'ویرایش',
                                          middleText: '',
                                          textConfirm: 'ثبت',
                                          onConfirm: () {
                                            // _showClearIcon.value = false;
                                            item.name = editingController.text;
                                            item.catIcon = catController
                                                .selectedIcon.value;
                                            catController.myMap.refresh();
                                            Get.back();
                                          },
                                          content: Row(
                                            children: [
                                              //! edit text field
                                              Expanded(
                                                  flex: 5,
                                                  // get text for items title
                                                  child: Obx(() => TextField(
                                                        onChanged: (value) {
                                                          _showClearIcon.value =
                                                              value.isEmpty;
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                suffixIcon: _showClearIcon
                                                                        .value
                                                                    ? null
                                                                    : IconButton(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        onPressed:
                                                                            () {
                                                                          editingController
                                                                              .clear();
                                                                          _showClearIcon.value =
                                                                              true;
                                                                        },
                                                                        icon: Icon(
                                                                            Icons.clear))),
                                                        autofocus: true,
                                                        controller:
                                                            editingController,
                                                      ))),
                                              Expanded(
                                                flex: 2,
                                                // choose icon for items
                                                child: Obx(() => DropdownButton(
                                                      hint: Text('آیکون'),
                                                      underline: SizedBox(),
                                                      elevation: 1,
                                                      isExpanded: true,
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      value: catController
                                                          .selectedIcon.value,
                                                      items: [
                                                        ...catController
                                                            .assetsOfIcons
                                                            .map<
                                                                DropdownMenuItem<
                                                                    Icon>>(
                                                          (Icon value) {
                                                            return DropdownMenuItem(
                                                              value: value,
                                                              child: value,
                                                            );
                                                          },
                                                        )
                                                      ],
                                                      onChanged: (newvalue) {
                                                        catController
                                                            .upDateSelectedIcon(
                                                                newvalue!);
                                                      },
                                                    )),
                                              )
                                            ],
                                          ),
                                          // add changes and show result
                                        );
                                      });
                                      Get.back();
                                    },
                                    textCancel: 'حذف',
                                    onCancel: () {
                                      Future.delayed(
                                          const Duration(milliseconds: 100),
                                          () {
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            message: '${item.name} حذف شد',
                                            icon: const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            ),
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      });
                                      catController.removeTextMap(index, item);

                                      Get.back();
                                    },
                                  );
                                },
                                onTap: () {
                                  catController.recentlyUsedCat.add(item);
                                },
                                title: Text(item.name!),
                                leading: item.catIcon,
                              );
                            }).toList(),
                          ]);
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

  Container titleTextContainer(BuildContext context, String titleName) {
    return Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.centerRight,
      child: Text(
        titleName,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
