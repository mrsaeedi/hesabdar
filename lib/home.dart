import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:hesabdar/components/total_pay_get.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/financial/add_new_payment.dart';
import 'package:hesabdar/view/notes/add_note.dart';
import 'package:hesabdar/view/todos/add_todo.dart';
import 'package:hesabdar/view/todos/all_todos.dart';
import 'package:hesabdar/view/todos/test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
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

  final RxInt selectedItem = controller.value.index.obs;
  // Get.put(ResultPageController()).controller.value.index.obs;

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
          Obx(() => selectedIndexButtomNav.value == 3 ||
                  selectedIndexButtomNav.value == 0
              ? SizedBox()
              : FloatAddButton(
                  selectedItem: selectedItem,
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
  final RxInt selectedItem;
  final RxInt navIndex;
  const FloatAddButton({
    required this.selectedItem,
    required this.navIndex,
    super.key,
  });
  RxString getTitle() {
    selectedItem.refresh();
    if (navIndex.value == 1) {
      return 'کار جدید'.obs;
    } else if (navIndex.value == 2) {
      return 'یادداشت جدید'.obs;
    }
    return ''.obs;
  }

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
                Obx(() => Text(
                      getTitle().value,
                      style: TextStyle(fontSize: 16),
                    )),
                widthOf(6),
                Icon(
                  Icons.add,
                  color: Color.fromARGB(150, 255, 255, 255),
                )
              ],
            ),
          ),
          onPressed: () {
            if (navIndex.value == 1) {
              Get.to(AddTodo());
            } else if (navIndex.value == 2) {
              Get.to(AddNewNote());
            }
          },
        ));
  }
}
