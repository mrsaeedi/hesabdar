import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:hesabdar/controller/todo_controllers/add_todo_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

getPersianWeekDay(Jalali pickedDate) {
  switch (pickedDate.weekDay) {
    case 1:
      return 'شنبه';
    case 2:
      return 'یکشنبه';
    case 3:
      return 'دوشنبه';
    case 4:
      return 'سه شنبه';
    case 5:
      return 'چهارشنبه';
    case 6:
      return 'پنجشنبه';
    case 7:
      return 'جمعه';
    default:
      return '';
  }
}

class CustomDatePicker extends StatelessWidget {
  final int seletedAction;
  final AddTodoController addTodoController = Get.put(AddTodoController());

  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  CustomDatePicker({
    Key? key,
    required this.seletedAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxString dateValue = 'تاریخ'.obs;

    return seletedAction == 0
        ?
//! choose date for add new item
        InkWell(
            onTap: () async {
              var pickedDate = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1402),
                  lastDate: Jalali(1406));

              if (pickedDate != null) {
                addNewPeymentController.pickedDateSelected.value = pickedDate;
                addNewPeymentController.weekDayString.value =
                    await getPersianWeekDay(
                        addNewPeymentController.pickedDateSelected.value);
              }
              pickedDate != null
                  ? dateValue.value = addNewPeymentController
                      .dateValue.value = addTodoController
                          .dateValueTodo.value =
                      '${getPersianWeekDay(addNewPeymentController.pickedDateSelected.value)} __ ${replaseingNumbersEnToFa(pickedDate.year.toString())}/${pickedDate.month < 10 ? replaseingNumbersEnToFa('0${pickedDate.month.toString()}') : replaseingNumbersEnToFa(pickedDate.month.toString())}/${pickedDate.day < 10 ? replaseingNumbersEnToFa('0${pickedDate.day.toString()}') : replaseingNumbersEnToFa(pickedDate.day.toString())}'
                  : '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';
            },
            child: Obx(() => Text(
                  dateValue.value,
                  style: Get.textTheme.titleLarge,
                )))
//! choose date for show items in home
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    addNewPeymentController.pickedDateSelectedHome.value =
                        addNewPeymentController.pickedDateSelectedHome.value
                            .addDays(1);
                    addNewPeymentController.weekDayStringHome.value =
                        await getPersianWeekDay(addNewPeymentController
                            .pickedDateSelectedHome.value);
                    addNewPeymentController.dateToSave.value = addTodoController
                            .dateToSaveTodo.value =
                        '${getPersianWeekDay(addNewPeymentController.pickedDateSelectedHome.value)} __ ${replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.year.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.month < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.month.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.month.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.day < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.day.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.day.toString())}';
                    addNewPeymentController.addMoneyItemToRxLists();
                    await addTodoController.addTodosToRxListForShow();
                    // await addTodoController.addItemToRxLists();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  )),
//
              IconButton(
                onPressed: () async {
                  var pickedDateHome = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1402),
                      lastDate: Jalali(1405));
                  if (pickedDateHome != null) {
                    addNewPeymentController.pickedDateSelectedHome.value =
                        pickedDateHome;
                    addNewPeymentController.weekDayStringHome.value =
                        await getPersianWeekDay(addNewPeymentController
                            .pickedDateSelectedHome.value);
                    addNewPeymentController.dateToSave.value = addTodoController
                            .dateToSaveTodo.value =
                        '${getPersianWeekDay(addNewPeymentController.pickedDateSelectedHome.value)} __ ${replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.year.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.month < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.month.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.month.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.day < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.day.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.day.toString())}';
                    addNewPeymentController.addMoneyItemToRxLists();
                    //await addTodoController.addItemToRxLists();
                    await addTodoController.addTodosToRxListForShow();
                  } else {
                    addNewPeymentController.dateToSave.value = addTodoController
                            .dateToSaveTodo.value =
                        '${getPersianWeekDay(addNewPeymentController.pickedDateSelectedHome.value)} __ ${replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.year.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.month < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.month.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.month.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.day < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.day.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.day.toString())}';
                    addNewPeymentController.addMoneyItemToRxLists();
                    await addTodoController.addTodosToRxListForShow();
                    // await addTodoController.addItemToRxLists();
                  }
                },
                icon: Icon(
                  Icons.edit_calendar_outlined,
                  size: 22,
                  color: Color.fromARGB(255, 45, 201, 201),
                ),
              ),
//
              Obx(() => Text(
                    '${getPersianWeekDay(addNewPeymentController.pickedDateSelectedHome.value)} __ ${replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.year.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.month < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.month.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.month.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.day < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.day.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.day.toString())}',
                    style: Get.textTheme.titleLarge,
                  )),
              widthOf(20),
//
              IconButton(
                  onPressed: () async {
                    addNewPeymentController.pickedDateSelectedHome.value =
                        addNewPeymentController.pickedDateSelectedHome.value
                            .addDays(-1);
                    addNewPeymentController.weekDayStringHome.value =
                        await getPersianWeekDay(addNewPeymentController
                            .pickedDateSelectedHome.value);
                    addNewPeymentController.dateToSave.value = addTodoController
                            .dateToSaveTodo.value =
                        '${getPersianWeekDay(addNewPeymentController.pickedDateSelectedHome.value)} __ ${replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.year.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.month < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.month.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.month.toString())}/${addNewPeymentController.pickedDateSelectedHome.value.day < 10 ? replaseingNumbersEnToFa('0${addNewPeymentController.pickedDateSelectedHome.value.day.toString()}') : replaseingNumbersEnToFa(addNewPeymentController.pickedDateSelectedHome.value.day.toString())}';
                    addNewPeymentController.addMoneyItemToRxLists();
                    await addTodoController.addTodosToRxListForShow();
                    // await addTodoController.addItemToRxLists();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )),
            ],
          );
  }
}
