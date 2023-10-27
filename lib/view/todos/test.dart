import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Test> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  List<String> firstList = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  List<String> secondList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Builder Example'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return index == 0
                  ? ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return Text('first');
                      },
                    )
                  : ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 40,
                      itemBuilder: (context, index) {
                        return Text('secconde');
                      },
                    );
            },
          )),
        ],
      ),
    );
  }
}

class Todo {
  final String title;
  bool isDone;
  Todo({
    required this.title,
    this.isDone = false,
  });
}

int falsecunter = 0;

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  List<Todo> todosDone = [];

  void addTodo(String title) {
    setState(() {
      todos.add(Todo(title: title, isDone: false));
    });
  }

  void toggleTodoState(int index) {
    setState(() {
      // دریافت تسک از لیست مربوطه
      var todo = todos[index].isDone || todosDone[index].isDone
          ? todosDone.removeAt(index)
          : todos.removeAt(index);

      // تغییر وضعیت isDone تسک
      todo.isDone = !todo.isDone;
      // اضافه کردن تسک به لیست مناسب بر اساس وضعیت
      if (todo.isDone) {
        todosDone.add(todo);
      } else {
        todos.add(todo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return index == 0
                    //! first list view builder
                    ? ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: todos.length,
                        itemBuilder: (context, index) {
                          return Container(
                              // padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Get.isDarkMode
                                      ? Color.fromARGB(134, 83, 83, 83)
                                      : Color.fromARGB(255, 228, 228, 228)),
                              child: ListTile(
                                onLongPress: () {},
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  todos[index].title,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                leading: Checkbox(
                                  value: todos[index].isDone,
                                  onChanged: (value) {
                                    setState(() {
                                      toggleTodoState(index);
                                    });
                                  },
                                ),
                              ));
                        },
                      )
                    : (index == 1)
                        ? Divider(
                            height: 5,
                            color: Colors.white,
                          )
                        //! seccond list view builder
                        : ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: todosDone.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  // padding: EdgeInsets.all(4),
                                  margin: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Get.isDarkMode
                                          ? Color.fromARGB(134, 83, 83, 83)
                                          : Color.fromARGB(255, 228, 228, 228)),
                                  child: ListTile(
                                    onLongPress: () {},
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      todosDone[index].title,
                                      style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    leading: Checkbox(
                                      value: todosDone[index].isDone,
                                      onChanged: (value) {
                                        setState(() {
                                          toggleTodoState(index);
                                        });
                                      },
                                    ),
                                  ));
                            },
                          );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final textController = TextEditingController();
              return AlertDialog(
                title: Text('Add Todo'),
                content: TextField(
                  controller: textController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final title = textController.text;
                      if (title.isNotEmpty) {
                        addTodo(title);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
/////////////////////////////////////////////

// class TodoList extends StatefulWidget {
//   @override
//   _TodoListState createState() => _TodoListState();
// }

// class _TodoListState extends State<TodoList> {
//   List<Todo> todos = [];

//   List<Todo> doneTodos = [];
//   List<Todo> notDoneTodos = [];

//   void addTodo(String title) {
//     setState(() {
//       todos.add(Todo(title: title));
//       notDoneTodos.add(Todo(title: title));
//     });
//   }

//   void toggleTodoState(int index) {
//     setState(() {
//       todos[index].isDone = !todos[index].isDone;
//       if (todos[index].isDone) {
//         final todo = notDoneTodos.removeAt(index);
//         doneTodos.add(todo);
//       } else {
//         final todo = doneTodos.removeAt(index);
//         notDoneTodos.add(todo);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: doneTodos.length + notDoneTodos.length,
//               itemBuilder: (context, index) {
//                 if (index < notDoneTodos.length) {
//                   final todo = notDoneTodos[index];
//                   return ListTile(
//                     title: Text(todo.title),
//                     leading: Checkbox(
//                       value: todo.isDone,
//                       onChanged: (bool? value) {
//                         toggleTodoState(index);
//                       },
//                     ),
//                   );
//                 } else if (index < doneTodos.length) {
//                   final todo = notDoneTodos[index];
//                   return ListTile(
//                     title: Text(todo.title),
//                     leading: Checkbox(
//                       value: todo.isDone,
//                       onChanged: (bool? value) {
//                         toggleTodoState(index);
//                       },
//                     ),
//                   );
//                   // Divider between done and not done todos
//                   return Divider();
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               final textController = TextEditingController();
//               return AlertDialog(
//                 title: Text('Add Todo'),
//                 content: TextField(
//                   controller: textController,
//                   decoration: InputDecoration(labelText: 'Title'),
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       final title = textController.text;
//                       if (title.isNotEmpty) {
//                         addTodo(title);
//                       }
//                       Navigator.of(context).pop();
//                     },
//                     child: Text('Add'),
//                   ),
//                 ],
//               );
//             },
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class TodoListState extends State {
//   List<Todo> todos = [];

//   List<Todo> doneTodos = [];
//   List<Todo> notDoneTodos = [];

//   bool isLastDoneTask = false;

//   void addTodo(String title) {
//     setState(() {
//       todos.add(Todo(title: title));
//       notDoneTodos.add(Todo(title: title));
//     });
//   }

//   void toggleTodoState(int index) {
//     setState(() {
//       todos[index].isDone = !todos[index].isDone;
//       if (todos[index].isDone) {
//         final todo = notDoneTodos.removeAt(index);
//         doneTodos.add(todo);
//       } else {
//         final todo = doneTodos.removeAt(index);
//         notDoneTodos.add(todo);
//       }
//       isLastDoneTask = doneTodos.isNotEmpty && doneTodos.length == todos.length;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Todo List'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: todos.length + (isLastDoneTask ? 1 : 0),
//               itemBuilder: (context, index) {
//                 if (index < doneTodos.length) {
//                   final todo = doneTodos[index];
//                   return ListTile(
//                     title: Text(todo.title),
//                     leading: Checkbox(
//                       value: todo.isDone,
//                       onChanged: (bool? value) {
//                         toggleTodoState(index);
//                       },
//                     ),
//                   );
//                 } else if (isLastDoneTask) {
//                   // Divider after last done task
//                   return Divider();
//                 } else {
//                   final todo = notDoneTodos[index - doneTodos.length];
//                   return ListTile(
//                     title: Text(todo.title),
//                     leading: Checkbox(
//                       value: todo.isDone,
//                       onChanged: (bool? value) {
//                         toggleTodoState(index - doneTodos.length);
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       // Rest of your code...
//     );
//   }
// }
