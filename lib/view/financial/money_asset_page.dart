import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/number/number_separator.dart';
import 'package:hesabdar/controller/financial_controllers/asset_controller.dart';
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
          Text('منابع مالی'),
          ListTile(
            title: Text('منبع جدید'),
            leading: Icon(Icons.add_circle_outline_outlined),
            onTap: () {
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
                              transactionList: []
                              // int.tryParse() ??
                              //     0,
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
          Expanded(
            child: Obx(() => ListView.builder(
                  itemCount: assetController.moneyAssetsList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
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
                        onLongPress: () {
                          Get.defaultDialog(
                            title: assetController.moneyAssetsList[index].name,
                            middleText: '',
                            textCancel: 'حذف',
                            textConfirm: 'ویرایش',
                            onCancel: () async {
                              // Get.back(); // حذف این خط
                              await Future.delayed(Duration(
                                  milliseconds: 2)); // تاخیر 500 میلی‌ثانیه
                              bool confirmDelete = await Get.dialog(
                                AlertDialog(
                                  title: Text(assetController
                                      .moneyAssetsList[index].name),
                                  content: Text('آیا از حذف آیتم مطمئن هستید؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context,
                                            false); // بستن دیالوگ تأیید حذف و ارسال مقدار false
                                      },
                                      child: Text('خیر'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context,
                                            true); // بستن دیالوگ تأیید حذف و ارسال مقدار true
                                      },
                                      child: Text('بله'),
                                    ),
                                  ],
                                ),
                              );

                              // اگر کاربر تأیید کرده باشد، اقدام به حذف کنید
                              if (confirmDelete == true) {
                                assetController.removeAssetToList(index);
                                assetController.addAssetToList();
                                assetController.moneyAssetsList.refresh();
                              }
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
