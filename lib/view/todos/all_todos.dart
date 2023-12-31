import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controller/todo_controllers/add_todo_controller.dart';

class ToDoPage extends StatelessWidget {
  final int vlue = 0;
  final AddTodoController addTodoController = Get.put(AddTodoController());
  final ReportController reportController = Get.put(ReportController());
  final RxInt _selctedOpenValue = RxInt(-1);
  ToDoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: CustomDatePicker(
              seletedAction: 1,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                      child: Text('کارهای امروز: '),
                    ),
                    //

                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                              width: 1,
                              style: BorderStyle.solid,
                              color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اضطراری',
                            style: Get.textTheme.bodyMedium,
                          ),
                          Icon(
                            Icons.flag,
                            color: Color.fromARGB(255, 253, 19, 19),
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'مهم',
                            style: Get.textTheme.bodyMedium,
                          ),
                          Icon(
                            Icons.flag,
                            color: Colors.blue,
                            size: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('معمولی', style: Get.textTheme.bodyMedium),
                          Icon(
                            Icons.flag,
                            color: const Color.fromARGB(255, 51, 243, 33),
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                    //
                    SizedBox(
                      height: 80,
                      child: Obx(() => CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 6,
                            percent: addTodoController.getProsess().value,
                            progressColor: Color.fromARGB(255, 5, 165, 170),
                            backgroundColor: Get.isDarkMode
                                ? Colors.white
                                : Color.fromARGB(255, 194, 244, 253),
                            circularStrokeCap: CircularStrokeCap.square,
                            center: Text(
                              '${addTodoController.getProsessPir().value}%',
                              style: TextStyle(fontSize: 12),
                            ),
                            animation: false,
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return index == 0
//! first list view builder
                      ? Obx(() => ListView.builder(
                            key: Key(_selctedOpenValue.toString()),
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addTodoController.notDoneList.isEmpty
                                ? 1
                                : addTodoController.notDoneList.length,
                            itemBuilder: (context, index) {
                              return addTodoController.notDoneList.isEmpty
                                  ? Center(
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                          const Color.fromARGB(
                                                  255, 100, 100, 100)
                                              .withOpacity(
                                                  0.5), // شفافیت (opacity) یا رنگ جدید
                                          BlendMode.srcATop, // حالت ترکیب رنگ
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 100),
                                                height: 200,
                                                child: Image.asset(
                                                    'assets/images/todo.png')),
                                            Text('کاری برای امروز ندارید')
                                          ],
                                        ),
                                      ),
                                    )
                                  : Card(
                                      elevation: 0,
                                      color: AllColors.kListItems,
                                      child: Obx(
                                        () => GestureDetector(
                                          onLongPress: () {
                                            Get.defaultDialog(
                                              title: 'حذف شود؟',
                                              textCancel: 'لغو',
                                              textConfirm: 'حذف',
                                              middleText: '',
                                              onConfirm: () {
                                                // addTodoController.deleteFromeHive(
                                                //     index, false);
                                                addTodoController
                                                    .deleteFromeHiveTodo(
                                                        addTodoController
                                                            .notDoneList[index]
                                                            .id,
                                                        1);
                                                addTodoController
                                                    .addTodosToRxListForShow();
                                                Get.back();
                                              },
                                            );
                                          },
                                          child: ExpansionTile(
                                              key: Key(index.toString()),
                                              initiallyExpanded: index ==
                                                  _selctedOpenValue.value,
                                              onExpansionChanged: (newState) {
                                                // setState(() {
                                                if (newState) {
                                                  _selctedOpenValue.value =
                                                      index;
                                                } else {
                                                  _selctedOpenValue.value = -1;
                                                }

                                                // });
                                              },
                                              trailing: Icon(Icons.flag,
                                                  color: (addTodoController
                                                              .notDoneList[
                                                                  index]
                                                              .importance ==
                                                          3)
                                                      ? Colors.green
                                                      : (addTodoController
                                                                  .notDoneList[
                                                                      index]
                                                                  .importance ==
                                                              2)
                                                          ? Colors.blue
                                                          : Colors.red),
                                              title: Text(
                                                addTodoController
                                                    .notDoneList[index].title,
                                                style: TextStyle(),
                                              ),
                                              leading: Checkbox(
                                                value: false,
                                                onChanged: (value) async {
                                                  addTodoController
                                                      .updateItemInHive(
                                                          addTodoController
                                                              .notDoneList[
                                                                  index]
                                                              .id,
                                                          1);
                                                  addTodoController
                                                      .addTodosToRxListForShow();
                                                  // addTodoController.notDoneList
                                                  //     .refresh();
                                                  // addTodoController.doneList
                                                  //     .refresh();

                                                  await reportController
                                                      .allResultTodo();
                                                },
                                              ),
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                  ),
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        addTodoController
                                                            .notDoneList[index]
                                                            .time,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          addTodoController
                                                              .notDoneList[
                                                                  index]
                                                              .describtion,
                                                          style: TextStyle(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ));
                            },
                          ))
                      : (index == 1)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Obx(
                                () => addTodoController.doneList.isEmpty
                                    ? SizedBox()
                                    : Row(
                                        children: const [
                                          Text('کارهای انجام شده: ')
                                        ],
                                      ),
                              ))
//! seccond list view builder
                          : Obx(() => ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: addTodoController.doneList.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                      elevation: 0,
                                      color: AllColors.kListItems,
                                      margin: EdgeInsets.all(4),
                                      child: ListTile(
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            title: 'حذف شود؟',
                                            textCancel: 'لغو',
                                            textConfirm: 'حذف',
                                            middleText: '',
                                            onConfirm: () {
                                              addTodoController
                                                  .deleteFromeHiveTodo(
                                                      addTodoController
                                                          .doneList[index].id,
                                                      2);
                                              // addTodoController.deleteFromeHive(
                                              //     index, true);
                                              addTodoController
                                                  .addTodosToRxListForShow();
                                              Get.back();
                                            },
                                          );
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        subtitle: Text(
                                          addTodoController
                                              .doneList[index].describtion,
                                          maxLines: 1,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        title: Text(
                                          addTodoController
                                              .doneList[index].title,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        leading: Checkbox(
                                          activeColor:
                                              Color.fromARGB(255, 5, 161, 154),
                                          value: true,
                                          onChanged: (value) {
                                            addTodoController.updateItemInHive(
                                                addTodoController
                                                    .doneList[index].id,
                                                2);
                                            addTodoController
                                                .addTodosToRxListForShow();
                                            reportController.allResultTodo();
                                            addTodoController.doneList
                                                .refresh();
                                          },
                                        ),
                                      ));
                                },
                              ));
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
