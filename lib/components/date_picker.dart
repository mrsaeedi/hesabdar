import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:hesabdar/controller/financial_controllers/add_new_peyment_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class CustomDatePicker extends StatelessWidget {
  final int seletedAction;
  final Rx<Jalali> _pickedDate = Jalali.now().obs;
  final RxString _weekDayStr = ''.obs;

  final AddNewPeymentController addNewPeymentController =
      Get.put(AddNewPeymentController());
  CustomDatePicker({
    Key? key,
    required this.seletedAction,
  }) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    RxString dateValue = 'تاریخ'.obs;

    var weekDayStr = getPersianWeekDay(Jalali.now());

    return seletedAction == 0
        ? InkWell(
            onTap: () async {
              var pickedDate = await showPersianDatePicker(
                  context: context,
                  initialDate: Jalali.now(),
                  firstDate: Jalali(1402),
                  lastDate: Jalali(1405));
              if (pickedDate != null) {
                _pickedDate.value = pickedDate;
                _weekDayStr.value = getPersianWeekDay(_pickedDate.value);
              } else {
                weekDayStr = 'تاریخ';
              }

              pickedDate != null
                  ? dateValue.value =
                      '${weekDayStr.toString()} __ ${replaseingNumersEnToFa(pickedDate.year.toString())}/${replaseingNumersEnToFa(pickedDate.month.toString())}/${replaseingNumersEnToFa(pickedDate.day.toString())}'
                  : '${weekDayStr.toString()} __ ${replaseingNumersEnToFa(Jalali.now().year.toString())}/${replaseingNumersEnToFa(Jalali.now().month.toString())}/${replaseingNumersEnToFa(Jalali.now().day.toString())}';
            },
            child: Obx(() => Container(
                  child: Text(
                    dateValue.value,
                    style: Get.textTheme.titleLarge,
                  ),
                )))

        // قسمت دارای ایکون برای جلو عقب بردن تاریخ
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    _pickedDate.value = _pickedDate.value.addDays(1);
                    _weekDayStr.value = getPersianWeekDay(_pickedDate.value);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  )),
              IconButton(
                onPressed: () async {
                  var pickedDate = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1402),
                      lastDate: Jalali(1405));
                  if (pickedDate != null) {
                    _pickedDate.value = pickedDate;
                    _weekDayStr.value = getPersianWeekDay(_pickedDate.value);
                  } else {
                    weekDayStr = 'تاریخ';
                  }
                },
                icon: Icon(
                  Icons.edit_calendar_outlined,
                  size: 22,
                  color: Color.fromARGB(255, 45, 201, 201),
                ),
              ),
              Obx(() => Text(
                    '${getPersianWeekDay(_pickedDate.value)} __ ${replaseingNumersEnToFa(_pickedDate.value.year.toString())}/${replaseingNumersEnToFa(_pickedDate.value.month.toString())}/${replaseingNumersEnToFa(_pickedDate.value.day.toString())}',
                    style: Get.textTheme.titleLarge,
                  )),
              widthOf(20),
              IconButton(
                  onPressed: () {
                    _pickedDate.value = _pickedDate.value.addDays(-1);
                    _weekDayStr.value = getPersianWeekDay(_pickedDate.value);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                  )),
            ],
          );
  }
}
