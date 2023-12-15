import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/date_picker.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/components/papular_components.dart';
import 'package:hesabdar/controller/home_page_controller.dart';
import 'package:hesabdar/controller/note_controllers.dart/note_controller.dart';
import 'package:hesabdar/controller/todo_controllers/add_todo_controller.dart';
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/notes/add_note.dart';
import 'package:hesabdar/view/todos/add_todo.dart';
import 'package:hesabdar/view/todos/all_todos.dart';
import 'package:hesabdar/view/profile/profile_screen.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'view/financial/result_page.dart';
import 'view/notes/note_list.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final RxInt selectedIndexButtomNav = 0.obs;
  final int indexof = 0;
  final List pages = [RsultPage(), ToDoPage(), NoteListPage(), ProfilePage()];
  void onSelectedPage(int index) {
    selectedIndexButtomNav.value = index;
  }

  final RxInt selectedItem = controller.value.index.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        left: 25,
        child: ElevatedButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Obx(() => Text(
                      getTitle().value,
                      style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255)),
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
              Get.put(AddTodoController()).dateValueTodo.value =
                  '${getPersianWeekDay(Jalali.now()).toString()} __ ${replaseingNumbersEnToFa(Jalali.now().year.toString())}/${Jalali.now().month < 10 ? replaseingNumbersEnToFa('0${Jalali.now().month.toString()}') : replaseingNumbersEnToFa(Jalali.now().month.toString())}/${Jalali.now().day < 10 ? replaseingNumbersEnToFa('0${Jalali.now().day.toString()}') : replaseingNumbersEnToFa(Jalali.now().day.toString())}';

              Get.to(AddTodo());
            } else if (navIndex.value == 2) {
              Get.put(NoteController()).selectedCategory.value = '';
              Get.put(NoteController()).noteTitle.clear();
              Get.put(NoteController()).noteContent.clear();
              Get.put(NoteController()).noteEditMode = false;
              Get.to(AddNewNote());
            }
          },
        ));
  }
}
