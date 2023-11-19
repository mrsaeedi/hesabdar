import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/controller/financial_controllers/report_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../controller/todo_controllers/add_todo_controller.dart';

class ToDoPage extends StatelessWidget {
  final int vlue = 0;
  final AddTodoController addTodoController = Get.put(AddTodoController());
  final ReportController reportController = Get.put(ReportController());

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
              ElevatedButton.icon(
                  onPressed: () {}, icon: Icon(Icons.nat), label: Text('data')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                    child: Text('کارهای امروز: '),
                  ),
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
              Expanded(
                  child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return index == 0
//! first list view builder
                      ? Obx(() => ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addTodoController.notDoneList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: Color.fromARGB(
                                                104, 53, 49, 49))),
                                    color: Color.fromARGB(52, 158, 158, 158)),
                                child: ExpansionTile(
                                    trailing: Icon(Icons.flag,
                                        color: (addTodoController
                                                    .notDoneList[index]
                                                    .importance ==
                                                3)
                                            ? Colors.green
                                            : (addTodoController
                                                        .notDoneList[index]
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
                                      value: addTodoController
                                          .notDoneList[index].isDone,
                                      onChanged: (value) async {
                                        addTodoController.updateItemInHive(
                                            index, value!);

                                        // addTodoController.updateItemInHive(
                                        //     index,
                                        //     addTodoController
                                        //         .notDoneList[index].isDone);
                                        addTodoController
                                                .notDoneList[index].isDone
                                            ? addTodoController
                                                .notDoneList[index]
                                                .isDone = false
                                            : addTodoController
                                                .notDoneList[index]
                                                .isDone = true;
                                        addTodoController.notDoneList.refresh();
                                        addTodoController.doneList.refresh();
                                        addTodoController
                                            .toggleTodoState(index);
                                        await reportController.allResultTodo();
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
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              addTodoController
                                                  .notDoneList[index].time,
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                addTodoController
                                                    .notDoneList[index]
                                                    .describtion,
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              );
                            },
                          ))
                      : (index == 1)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Row(
                                children: const [Text('کارهای انجام شده: ')],
                              ),
                            )
//! seccond list view builder
                          : Obx(() => ListView.builder(
                                physics: ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: addTodoController.doneList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      // padding: EdgeInsets.all(4),
                                      margin: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: Get.isDarkMode
                                              ? Color.fromARGB(134, 83, 83, 83)
                                              : Color.fromARGB(
                                                  255, 228, 228, 228)),
                                      child: ListTile(
                                        onLongPress: () {
                                          Get.defaultDialog(
                                            title: 'حذف شود؟',
                                            textCancel: 'لغو',
                                            textConfirm: 'حذف',
                                            middleText: '',
                                            onConfirm: () {
                                              addTodoController
                                                  .deleteFromeHive(index);
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
                                          value: addTodoController
                                              .doneList[index].isDone,
                                          onChanged: (value) {
                                            Future.delayed(
                                                Duration(milliseconds: 50), () {
                                              addTodoController
                                                  .updateItemInHive(
                                                      index, value!);
                                            });

                                            // addTodoController.updateItemInHive(
                                            //     index,
                                            //     addTodoController
                                            //         .doneList[index].isDone);
                                            addTodoController
                                                    .doneList[index].isDone
                                                ? addTodoController
                                                    .doneList[index]
                                                    .isDone = false
                                                : addTodoController
                                                    .doneList[index]
                                                    .isDone = true;
                                            addTodoController.doneList
                                                .refresh();
                                            addTodoController
                                                .toggleTodoStateDone(index);
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
