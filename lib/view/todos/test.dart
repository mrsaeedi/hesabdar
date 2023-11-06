import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hesabdar/model/financial_models/category_items_model.dart';

class TodoList extends StatefulWidget {
  TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  myMap.update('tow', (list) => list..add('Learn Dart'),
                      ifAbsent: () => ['Learn Dart']);
                });
              },
              child: Text('add')),
          Expanded(
            child: ListView.builder(
              itemCount: myMap.length,
              itemBuilder: (context, index) {
                var items = myMap.values.toList()[index];
                return ExpansionTile(
                  title: Text(myMap.keys.elementAt(index)),
                  children: [
                    ...items.map((e) {
                      return Column(mainAxisSize: MainAxisSize.min, children: [
                        ListView.builder(
                          itemCount: items.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Text(e);
                          },
                        ),
                      ]);
                    })
                  ],
                );
              },
            ),
          )
        ],
      )),
    );
  }
}

class AddTomap {}

RxMap<String, List<String>> myMap = {
  'one': <String>['1', '1'],
  'tow': <String>['ttt', 'news', 'terr'],
  'three': <String>[],
}.obs;
/////////////////////////
///
///

class TodoItem {
  String title;
  List<String> items;

  TodoItem(this.title, this.items);
}

class TodoList1 extends StatefulWidget {
  TodoList1({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoList1State extends State<TodoList> {
  List<TodoItem> todoItems = [];

  @override
  void initState() {
    super.initState();
    // اضافه کردن اطلاعات اولیه به todoItems
    todoItems.add(TodoItem('one', ['1', '1']));
    todoItems.add(TodoItem('tow', ['tfff', 'mmm']));
    todoItems.add(TodoItem('three', ['llll', 'nbvbv', 'sese']));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // اضافه کردن عنصر به todoItems
                  todoItems.add(TodoItem('new', ['News']));
                });
              },
              child: Text('add'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoItems.length,
                itemBuilder: (context, index) {
                  var item = todoItems[index];
                  return ExpansionTile(
                    title: Text(item.title),
                    children: [
                      ...item.items.map((e) {
                        return Text(e);
                      })
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
