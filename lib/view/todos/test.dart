import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/financial_controllers/assets_controller.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final AssetController assetController = Get.put(AssetController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(mainAxisSize: MainAxisSize.min, children: [
        ElevatedButton(
            onPressed: () {
              assetController.allResult();
              print(assetController.resultPayMap.values.elementAt(2));
            },
            child: Text('show'))
      ])),
    );
  }
}
