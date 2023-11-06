import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/total_pay_get.dart';
import 'package:hesabdar/model/todo_models/add_todo_model.dart';
import 'package:hive/hive.dart';

import '../../controller/todo_controllers/add_todo_controller.dart';

class ToDoPage extends StatelessWidget {
  int vlue = 0;
  final AddTodoController addTodoController = Get.put(AddTodoController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(6),
          child: Column(
            children: [
              ElevatedButton(onPressed: () {}, child: Text('show')),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                child: Text('کارهای امروز: '),
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
                              return ExpansionTile(
                                  title: Text(
                                    addTodoController.notDoneList[index].title,
                                    style: TextStyle(),
                                  ),
                                  leading: Checkbox(
                                    value: addTodoController
                                        .notDoneList[index].isDone,
                                    onChanged: (value) {
                                      addTodoController.updateItemInHive(
                                          index, value!);

                                      // addTodoController.updateItemInHive(
                                      //     index,
                                      //     addTodoController
                                      //         .notDoneList[index].isDone);
                                      addTodoController
                                              .notDoneList[index].isDone
                                          ? addTodoController
                                              .notDoneList[index].isDone = false
                                          : addTodoController
                                              .notDoneList[index].isDone = true;
                                      addTodoController.notDoneList.refresh();
                                      addTodoController.doneList.refresh();
                                      addTodoController.toggleTodoState(index);
                                    },
                                  ),
                                  children: [
                                    Text(
                                      addTodoController.notDoneList[index].time,
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      addTodoController
                                          .notDoneList[index].describtion,
                                      style: TextStyle(),
                                    ),
                                    Container(
                                        // padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Get.isDarkMode
                                                ? Color.fromARGB(
                                                    134, 83, 83, 83)
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
                                                .notDoneList[index].describtion,
                                            style: TextStyle(),
                                          ),
                                          title: Text(
                                            addTodoController
                                                .notDoneList[index].title,
                                            style: TextStyle(),
                                          ),
                                          leading: Checkbox(
                                            value: addTodoController
                                                .notDoneList[index].isDone,
                                            onChanged: (value) {
                                              addTodoController
                                                  .updateItemInHive(
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
                                              addTodoController.notDoneList
                                                  .refresh();
                                              addTodoController.doneList
                                                  .refresh();
                                              addTodoController
                                                  .toggleTodoState(index);
                                            },
                                          ),
                                        )),
                                  ]);
                            },
                          ))
                      : (index == 1)
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              child: Row(
                                children: [Text('کارهای انجام شده: ')],
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
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        title: Text(
                                          addTodoController
                                              .doneList[index].title,
                                          style: TextStyle(
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
