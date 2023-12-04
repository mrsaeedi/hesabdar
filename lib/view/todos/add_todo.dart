// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/total_pay_get.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/controller/todo_controllers/add_todo_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hesabdar/view/financial/add_new_payment.dart';
import 'package:hive/hive.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../components/date_picker.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController discreptionController = TextEditingController();
  final AddTodoController addTodoController = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'کار جدید',
                  style: Get.textTheme.titleLarge,
                ),
              ),
              AddToDoWidget(
                titleController: titleController,
                lable: 'عنوان',
                hint: 'عنوان',
                maxLine: 1,
              ),
              Row(
                children: [
                  DateAndImportance(
                    action: 0,
                    flex: 2,
                    title: 'تاریخ',
                  ),
                  TimeTodoChoose()
                ],
              ),
              Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RadioMenuButton(
                              style: ButtonStyle(
                                iconColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                        (Set<MaterialState> states) {
                                  return Colors
                                      .red; // رنگ برای وضعیت انتخاب شده
                                }),
                              ),
                              value: 1,
                              groupValue: addTodoController.selectedValue.value,
                              onChanged: (value) {
                                addTodoController.handleRadioValueChange(value);
                              },
                              child: Text(
                                'اضطراری',
                                style: Get.textTheme.bodyMedium,
                              )),
                          Icon(
                            Icons.flag,
                            color: Colors.blue,
                            size: 16,
                          ),
                          RadioMenuButton(
                              value: 2,
                              groupValue: addTodoController.selectedValue.value,
                              onChanged: (value) {
                                addTodoController.handleRadioValueChange(value);
                              },
                              child: Text(
                                'مهم',
                                style: Get.textTheme.bodyMedium,
                              )),
                          Icon(
                            Icons.flag,
                            color: Colors.blue,
                            size: 16,
                          ),
                          RadioMenuButton(
                              value: 3,
                              groupValue: addTodoController.selectedValue.value,
                              onChanged: (value) {
                                addTodoController.handleRadioValueChange(value);
                              },
                              child: Text('معمولی',
                                  style: Get.textTheme.bodyMedium)),
                          Icon(
                            Icons.flag,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  )),
              Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: TextField(
                    maxLines: 3,
                    onChanged: (value) {
                      addTodoController.isClearButtonPressedDis.value =
                          value.isEmpty;
                    },
                    decoration: InputDecoration(
                      suffixIcon:
                          addTodoController.isClearButtonPressedDis.value
                              ? null
                              : IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    discreptionController.clear();
                                    addTodoController
                                        .isClearButtonPressedDis.value = true;
                                  },
                                  icon: Icon(Icons.clear),
                                  color: AllColors.primaryColor,
                                ),
                      hintText: 'توضیحات',
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 119, 119, 119)),
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 168, 168, 168)),
                      label: Text('توضیحات'),
                      border: const OutlineInputBorder(), // قسمت border
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // رنگ بردر در حالت غیر فوکوس
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey), // رنگ بردر در حالت فوکوس
                      ),
                    ),
                    controller: discreptionController,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty) {
                      Hive.box<AddTodoModel>('todoBox').add(AddTodoModel(
                          title: titleController.text,
                          describtion: discreptionController.text,
                          isDone: false,
                          date: addTodoController.dateValueTodo.value,
                          time: addTodoController.selectedTime.value.minute < 10
                              ? '۰${replaseingNumbersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumbersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}'
                              : '${replaseingNumbersEnToFa(addNewPeymentController.selectedTime.value.minute.toString())}: ${replaseingNumbersEnToFa(addNewPeymentController.selectedTime.value.hour.toString())}',

                          //  category: category,
                          importance: addTodoController.selectedValue.value,
                          id: generateUniqueId()));
                      Get.back();
                      await Get.put(ReportController()).allResultTodo();
                      addTodoController.addTodosToRxListForShow();
                    } else {
                      Get.snackbar('عنوان خالی است!', 'لطفاً عنوانی وارد کنید',
                          snackPosition: SnackPosition.TOP);
                    }
                  },
                  child: SizedBox(
                      width: Get.width / 1.5,
                      height: 60,
                      child: Center(child: Text('اضافه کن'))))
            ],
          ),
        ),
      ),
    );
  }
}

class DateAndImportance extends StatelessWidget {
  final String title;
  final int action;
  final int flex;
  String? label;
  DateAndImportance(
      {Key? key, required this.title, required this.action, required this.flex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Container(
            padding: EdgeInsets.all(18),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border.all(
                    width: 1, style: BorderStyle.solid, color: Colors.grey)),
            child: CustomDatePicker(seletedAction: 0)));
  }
}

class AddToDoWidget extends StatelessWidget {
  final String lable;
  final String hint;
  final int maxLine;
  final AddTodoController addTodoController = Get.put(AddTodoController());

  final TextEditingController titleController;
  AddToDoWidget({
    Key? key,
    required this.maxLine,
    required this.lable,
    required this.hint,
    required this.titleController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      padding: EdgeInsets.all(4),
      child: Obx(
        () => TextField(
          maxLines: maxLine,
          onChanged: (value) {
            addTodoController.isClearButtonPressedTitle.value = value.isEmpty;
          },
          decoration: InputDecoration(
            prefixIcon: addTodoController.isClearButtonPressedTitle.value
                ? null
                : IconButton(
                    onPressed: () {
                      titleController.clear();
                      addTodoController.isClearButtonPressedTitle.value = true;
                    },
                    icon: Icon(Icons.clear),
                    color: AllColors.primaryColor,
                  ),
            hintText: hint,
            labelStyle: const TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 119, 119, 119)),
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 168, 168, 168)),
            label: Text(lable),
            border: const OutlineInputBorder(), // قسمت border
            contentPadding:
                EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey), // رنگ بردر در حالت غیر فوکوس
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey), // رنگ بردر در حالت فوکوس
            ),
          ),
          controller: titleController,
        ),
      ),
    );
  }
}

class TimeTodoChoose extends StatelessWidget {
  TimeTodoChoose({
    super.key,
  });

  final AddTodoController addTodoController = Get.put(AddTodoController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ChooseDateAndTime(
        lable: addTodoController.selectedTime.value.minute < 10
            ? '0${addTodoController.selectedTime.value.minute}: ${addTodoController.selectedTime.value.hour}'
            : '${addTodoController.selectedTime.value.minute}: ${addTodoController.selectedTime.value.hour}',
        ontap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
              initialTime: addTodoController.selectedTime.value,
              initialEntryMode: TimePickerEntryMode.dial);
          // var picked = await showPersianTimePicker(
          //   context: context,
          //   initialTime: TimeOfDay.now(),
          //   builder: (BuildContext context, Widget? child) {
          //     return Directionality(
          //       textDirection: TextDirection.rtl,
          //       child: child!,
          //     );
          //   },
          // );
          if (timeOfDay != null) {
            addTodoController.selectedTime.value = timeOfDay;
          } else {
            addTodoController.selectedTime.value = TimeOfDay.now();
          }
        },
      ),
    );
  }
}
