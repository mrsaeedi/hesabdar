import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/components/total_pay_get.dart';
import 'package:hesabdar/controller/financial_controllers/asset_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/financial_models/money_assets.dart';
import 'package:hive/hive.dart';

class MoneyAssetPage extends StatelessWidget {
  MoneyAssetPage({super.key});
  final AssetController assetController = Get.put(AssetController());
  final TextEditingController assetTitleController = TextEditingController();
  final TextEditingController assetInventoryController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'منابع مالی',
                style: TextStyle(
                    fontSize: 16,
                    color: Get.isDarkMode ? Colors.white : Colors.black),
              )),
          Divider(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ElevatedButton.icon(
                icon: Icon(Icons.add_circle_outline_outlined),
                label: Text(
                  'منبع جدید',
                  style: TextStyle(color: Color.fromARGB(188, 105, 105, 105)),
                ),
                onPressed: () {
                  assetInventoryController.clear();
                  assetTitleController.clear();
                  Get.dialog(
                    AlertDialog(
                      title: Text('افزدن منبع جدید'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                              autofocus: true,
                              controller: assetTitleController,
                              decoration: InputDecoration(labelText: 'عنوان')),
                          TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                PersianNumberFormatter(),
                                PersianNumericTextInputFormatter(),
                                ThousandsSeparatorInputFormatter(),
                                LengthLimitingTextInputFormatter(11)
                              ],
                              controller: assetInventoryController,
                              decoration: InputDecoration(labelText: 'موجودی')),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Get.back(); // بستن دیالوگ
                          },
                          child: Text('لغو'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // بررسی خالی نبودن ورودی‌ها
                            if (assetTitleController.text.isEmpty ||
                                assetInventoryController.text.isEmpty) {
                              Get.snackbar('خطا', 'لطفاً هر دو فیلد را پر کنید',
                                  snackPosition: SnackPosition.TOP);
                              return;
                            }

                            // اضافه کردن به هایو
                            Hive.box<MoneyAssets>('assetsBox').add(
                              MoneyAssets(
                                name: assetTitleController.text,
                                inventory: int.parse(replaseingNumbersFaToEn(
                                    assetInventoryController.text)),
                              ),
                            );
                            assetController.addAssetToList();
                            Get.back(); // بستن دیالوگ
                          },
                          child: Text('ثبت'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: assetController.moneyAssetsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: AllColors.kListItems,
                          border: Border(
                            bottom: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Color.fromARGB(143, 158, 158, 158)),
                          )),
                      child: ListTile(
                        title:
                            Text(assetController.moneyAssetsList[index].name),
                        trailing: Text(replaseingNumbersEnToFa(
                            addCommasToNumber(assetController
                                .moneyAssetsList[index].inventory))),
                        onTap: () {
                          if (!assetController.isEditOrSelect) {
                            addNewPeymentController.selectedAssetIndex.value =
                                index;
                            addNewPeymentController.selectedAsset.value =
                                assetController.moneyAssetsList[index].name;
                            Get.back();
                          } else {}
                        },
                        onLongPress: () {
                          Get.defaultDialog(
                            title: assetController.moneyAssetsList[index].name,
                            middleText: '',
                            textCancel: 'حذف',
                            textConfirm: 'ویرایش',
                            onCancel: () async {
                              await Future.delayed(Duration(milliseconds: 2));
                              bool confirmDelete = await Get.dialog(
                                    AlertDialog(
                                      title: Text(assetController
                                          .moneyAssetsList[index].name),
                                      content:
                                          Text('آیا از حذف آیتم مطمئن هستید؟'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context,
                                                false); // بستن دیالوگ تأیید حذف و ارسال مقدار false
                                          },
                                          child: Text(
                                            'خیر',
                                            style: Get.textTheme.bodyMedium,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context,
                                                true); // بستن دیالوگ تأیید حذف و ارسال مقدار true
                                          },
                                          child: Text(
                                            'بله',
                                            style: Get.textTheme.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;

                              // اگر کاربر تأیید کرده باشد، اقدام به حذف کنید
                              if (confirmDelete == true) {
                                assetController.removeAssetToList(index);
                                assetController.addAssetToList();
                                assetController.moneyAssetsList.refresh();
                              }
                            },
                            onConfirm: () {
                              Get.back();
                              assetInventoryController.text = assetController
                                  .moneyAssetsList[index].inventory
                                  .toString();
                              assetTitleController.text =
                                  assetController.moneyAssetsList[index].name;
                              Get.dialog(
                                AlertDialog(
                                  title: Text('ویرایش'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                          autofocus: true,
                                          controller: assetTitleController,
                                          decoration: InputDecoration(
                                              labelText: 'عنوان')),
                                      TextField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            PersianNumberFormatter(),
                                            PersianNumericTextInputFormatter(),
                                            ThousandsSeparatorInputFormatter(),
                                            LengthLimitingTextInputFormatter(11)
                                          ],
                                          controller: assetInventoryController,
                                          decoration: InputDecoration(
                                              labelText: 'موجودی')),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back(); // بستن دیالوگ
                                      },
                                      child: Text('لغو'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // بررسی خالی نبودن ورودی‌ها
                                        if (assetTitleController.text.isEmpty ||
                                            assetInventoryController
                                                .text.isEmpty) {
                                          Get.snackbar('خطا',
                                              'لطفاً هر دو فیلد را پر کنید',
                                              snackPosition: SnackPosition.TOP);
                                          return;
                                        }
                                        assetController.updateAssetList(
                                            assetTitleController.text,
                                            assetInventoryController.text);
                                        assetController.addAssetToList();
                                        Get.back(); // بستن دیالوگ
                                      },
                                      child: Text('ثبت'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                )),
          )
        ],
      )),
    );
  }
}
