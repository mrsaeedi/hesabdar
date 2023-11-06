import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/notes/add_note.dart';
import 'package:hesabdar/view/todos/add_todo.dart';
import 'package:hesabdar/view/todos/all_todos.dart';
import 'package:hesabdar/view/todos/test.dart';
import 'view/financial/result_page.dart';
import 'view/notes/noteList.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final RxInt selectedIndexButtomNav = 0.obs;
  final int indexof = 0;
  final List pages = [RsultPage(), ToDoPage(), NoteListPage(), TodoList()];
  void onSelectedPage(int index) {
    selectedIndexButtomNav.value = index;
  }

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
      body: Stack(
        children: [
          Obx(() =>
              Container(child: pages.elementAt(selectedIndexButtomNav.value))),
          Obx(() => selectedIndexButtomNav.value == 0 ||
                  selectedIndexButtomNav.value == 3
              ? SizedBox()
              : FloatAddButton(
                  navIndex: selectedIndexButtomNav,
                ))
        ],
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.add_card),
                label: 'مالی',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_alt_rounded,
                  ),
                  label: 'کارها'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.note_alt), label: 'یادداشت'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'پروفایل')
            ],
            unselectedItemColor: Colors.grey,
            selectedItemColor: AllColors.primaryColor,
            showUnselectedLabels: true,
            currentIndex: selectedIndexButtomNav.value,
            type: BottomNavigationBarType.fixed,
            onTap: ((value) {
              onSelectedPage(value);
            }),
          )),
    ));
  }
}

class FloatAddButton extends StatelessWidget {
  RxInt navIndex;
  FloatAddButton({
    required this.navIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 18,
        right: 25,
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Text(
                  navIndex.value == 1 ? 'کار جدید' : 'یادداشت جدید',
                  style: TextStyle(fontSize: 16),
                ),
                widthOf(6),
                Icon(
                  Icons.add,
                  color: Color.fromARGB(150, 255, 255, 255),
                )
              ],
            ),
          ),
          onPressed: () {
            navIndex.value == 1 ? Get.to(AddTodo()) : Get.to(AddNewNote());
          },
        ));
  }
}
