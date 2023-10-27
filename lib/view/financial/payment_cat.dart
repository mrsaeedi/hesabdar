import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/financial_controllers/category_items_controller.dart';

import '../../model/financial_models/category_items_model.dart';

class PaymentCat extends StatelessWidget {
  static CategoryItemsController catController = CategoryItemsController();
  TextEditingController addTextController = TextEditingController();
  TextEditingController editingController = TextEditingController();
  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  final RxBool _showClearIcon = false.obs;

  PaymentCat({super.key});
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
            titleTextContainer(context, 'آخرین انتخاب'),
//! Recently selected items
            RecentlyAddedItem(
                catController: catController,
                addNewPeymentController: addNewPeymentController),
            titleTextContainer(context, 'دسته بندی'),
            Expanded(
//! sub lists in list view
              child: Obx(() => ListView.builder(
                    itemCount: catController.myMap.length,
                    itemBuilder: (context, index) {
                      String categoryName =
                          catController.myMap.keys.toList()[index];
                      List<ListOfcat> categoryItems =
                          catController.myMap.values.toList()[index];
                      return Card(
                        child:
                            ExpansionTile(title: Text(categoryName), children: [
                          //! add new item
                          AddNewItemToCatList(
                              index: index,
                              addTextController: addTextController,
                              catController: catController,
                              showClearIcon: _showClearIcon),
                          ...categoryItems.map<Widget>((item) {
                            //!  list view of items
                            return LIstOfCatItems(
                                index: index,
                                item: item,
                                editingController: editingController,
                                catController: catController,
                                showClearIcon: _showClearIcon,
                                addNewPeymentController:
                                    addNewPeymentController);
                          }).toList(),
                        ]),
                      );
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }

//! title text
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

//! list of category item for select
class LIstOfCatItems extends StatelessWidget {
  LIstOfCatItems({
    super.key,
    required this.item,
    required this.index,
    required this.editingController,
    required this.catController,
    required RxBool showClearIcon,
    required this.addNewPeymentController,
  }) : _showClearIcon = showClearIcon;

  final TextEditingController editingController;
  final CategoryItemsController catController;
  final RxBool _showClearIcon;
  final AddNewPeymentController addNewPeymentController;
  ListOfcat item;
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: 1, color: Color.fromARGB(104, 201, 201, 201)))),
      child: ListTile(
        onLongPress: () {
          editingController.text = item.name!;
          Get.defaultDialog(
            title: item.name!,
            middleText: '',
            radius: 12,
            textConfirm: 'ویرایش',
            onConfirm: () {
              // _showClearIcon.value = true;
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.defaultDialog(
                  title: 'ویرایش',
                  middleText: '',
                  textConfirm: 'ثبت',
                  onConfirm: () {
                    // _showClearIcon.value = false;
                    item.name = editingController.text;
                    item.catIcon = catController.selectedIcon.value;
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
                                  _showClearIcon.value = value.isEmpty;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: _showClearIcon.value
                                        ? null
                                        : IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              editingController.clear();
                                              _showClearIcon.value = true;
                                            },
                                            icon: Icon(Icons.clear))),
                                autofocus: true,
                                controller: editingController,
                              ))),
                      Expanded(
                        flex: 2,
                        // choose icon for items
                        child: Obx(() => DropdownButton(
                              hint: Text('آیکون'),
                              underline: SizedBox(),
                              elevation: 1,
                              isExpanded: true,
                              padding: EdgeInsets.all(10),
                              value: catController.selectedIcon.value,
                              items: [
                                ...catController.assetsOfIcons
                                    .map<DropdownMenuItem<IconData>>(
                                  (IconData value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Icon(value),
                                    );
                                  },
                                )
                              ],
                              onChanged: (newvalue) {
                                catController.upDateSelectedIcon(newvalue!);
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
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.showSnackbar(
                  GetSnackBar(
                    message: '${item.name} حذف شد',
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
              catController.removeTextMap(index, item);
            },
          );
        },
        onTap: () {
          addNewPeymentController.selectedCategoryName.value = item.name!;
          addNewPeymentController.selectedCategoryIcon.value = item.catIcon;
          catController.addItem(item);
          Get.back();
        },
        title: Text(item.name!),
        leading: Icon(item.catIcon),
      ),
    );
  }
}

//! add now item to category list
class AddNewItemToCatList extends StatelessWidget {
  AddNewItemToCatList({
    super.key,
    required this.addTextController,
    required this.index,
    required this.catController,
    required RxBool showClearIcon,
  }) : _showClearIcon = showClearIcon;
  final TextEditingController addTextController;
  final CategoryItemsController catController;
  final RxBool _showClearIcon;
  int? index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        //add new item in dialog box
        Get.defaultDialog(
          barrierDismissible: false,
          title: 'اضافه کن',
          textCancel: 'لغو',
          textConfirm: 'ذخیره',
          onConfirm: () {
            if (addTextController.text.isNotEmpty &&
                catController.selectedIcon.value != null) {
              catController.addTextToMap(addTextController.text, index!);
              //show added result in snackBar
              Future.delayed(const Duration(milliseconds: 100), () {
                Get.showSnackbar(
                  GetSnackBar(
                    message: 'آیتم جدید اضافه شد',
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
              Get.back();
            } else {
              Get.showSnackbar(
                GetSnackBar(
                  message: 'لطفا متن و آیکون را انتخاب کنید',
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  duration: const Duration(milliseconds: 1500),
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
                        _showClearIcon.value = value.isEmpty;
                      },
                      controller: addTextController,
                      decoration: InputDecoration(
                          suffixIcon: _showClearIcon.value
                              ? null
                              : IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    addTextController.clear();
                                    _showClearIcon.value = true;
                                  },
                                  icon: Icon(Icons.clear))),
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
                      value: catController.selectedIcon.value,
                      items: [
                        ...catController.assetsOfIcons
                            .map<DropdownMenuItem<IconData>>(
                          (IconData value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Icon(value),
                            );
                          },
                        )
                      ],
                      onChanged: (newvalue) {
                        catController.upDateSelectedIcon(newvalue!);
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
    );
  }
}

//! recently added item
class RecentlyAddedItem extends StatelessWidget {
  const RecentlyAddedItem({
    super.key,
    required this.catController,
    required this.addNewPeymentController,
  });

  final CategoryItemsController catController;
  final AddNewPeymentController addNewPeymentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: catController.recentlyUsedCat.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          List<ListOfcat> categoryItems =
              catController.myMap.values.toList()[index];
          return InkWell(
            onTap: () {
              addNewPeymentController.selectedCategoryName.value = catController
                  .recentlyUsedCat.value.reversed
                  .toList()[index]
                  .name!;
              addNewPeymentController.selectedCategoryIcon.value = catController
                  .recentlyUsedCat.value.reversed
                  .toList()[index]
                  .catIcon!;

              Get.back();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              height: 80,
              child: Container(
                padding: EdgeInsets.all(8),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 138, 138, 138),
                        style: BorderStyle.solid)),
                child: Row(
                  children: [
                    Icon(
                      catController.recentlyUsedCat.reversed
                          .toList()[index]
                          .catIcon!,
                    ),
                    Text(
                      catController.recentlyUsedCat.reversed
                          .toList()[index]
                          .name!,
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}