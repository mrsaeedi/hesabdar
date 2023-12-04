import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/number/change_number_to_persion.dart';
import 'package:hesabdar/controller/note_controllers.dart/note_controller.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hive/hive.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({super.key});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final NoteController noteController = Get.put(NoteController());

  final TextEditingController noteCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                  onPressed: () async {
                    if (noteController.noteTitle.text.isNotEmpty) {
                      noteController.noteEditMode
                          ? noteController.updateNoteInHive(
                              id: noteController
                                  .showNotes[noteController.selectedIndex].id,
                              title: noteController.noteTitle.text,
                              describtion: noteController.noteContent.text,
                              catNote: noteController.selectedCategory.value,
                              date: noteController.dateToSave.value)
                          : await addNoteToHive();
                      noteController.selectedCategoryshow = '';
                      noteController.addToNoteCat();
                      noteController.showNotes.refresh();
                      noteController.noteEditMode = false;
                      Get.back();
                      noteController.readNotesFroemHive('');
                      noteController.addToNoteCat();
                      noteController.noteCategory.refresh();
                    } else {
                      Get.snackbar('عنوان خالی است!', 'لطفاً عنوانی وارد کنید',
                          snackPosition: SnackPosition.TOP);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline_sharp,
                        color: Color.fromARGB(178, 60, 207, 252),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        noteController.noteEditMode ? 'ویرایش' : 'یادداشت جدید',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
//-----------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: TextField(
                                controller: noteController.noteTitle,
                                decoration: InputDecoration(
                                    hintText: 'عنوان',
                                    hintStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            171, 158, 158, 158)),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10)),
                              ),
                            ),
                            //----------------------------
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, top: 5),
                              child: Text(
                                noteController.noteEditMode
                                    ? noteController
                                        .showNotes[noteController.selectedIndex]
                                        .date
                                    : noteController.dateToSave.value,
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //---------------------------
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            width: 1, color: Color.fromARGB(87, 158, 158, 158)),
                      ),
                      child: Obx(() => DropdownButton(
                            padding: EdgeInsets.only(right: 5),
                            icon: SizedBox(),
                            underline: SizedBox(),
                            hint: Text(
                              'انتخاب دسته',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            value: noteController.selectedCategory.value == ""
                                ? null
                                : noteController.selectedCategory.value,
                            onChanged: (newvalue) {
                              noteController
                                  .upDateSelectedCategory(newvalue.toString());
                            },
                            items: [
                              ...noteController.noteCategory
                                  .map<DropdownMenuItem>((dynamic value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }).toList(),
                              // افزودن گزینه برای افزودن دسته جدید
                              DropdownMenuItem(
                                value: 'دسته جدید',
                                child: TextButton.icon(
                                  icon: Icon(
                                    Icons.add_circle_outline_outlined,
                                    size: 18,
                                    color: Color.fromARGB(174, 7, 247, 255),
                                  ),
                                  onPressed: () {
                                    noteCategoryController.clear();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('افزودن دسته جدید'),
                                          content: TextField(
                                              autofocus: true,
                                              controller:
                                                  noteCategoryController,
                                              decoration: InputDecoration(
                                                  labelText: 'عنوان')),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('لغو'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (noteCategoryController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    Hive.box<String>(
                                                            'noteCatBox')
                                                        .add(
                                                            noteCategoryController
                                                                .text);
                                                    noteController
                                                        .addToNoteCat();
                                                    Get.back();
                                                  });

                                                  Get.back();
                                                } else {
                                                  Get.snackbar('',
                                                      'لطفاً نام دسته را وارد کنید',
                                                      snackPosition:
                                                          SnackPosition.TOP);
                                                }
                                              },
                                              child: Text('تایید'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  label: Text(
                                    'دسته جدید',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 14, 219,
                                          247), // یا هر رنگ دیگری که می‌خواهید
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
//---------------------------------------------------------
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: null,
                  controller: noteController.noteContent,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'محتوا',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(171, 158, 158, 158)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addNoteToHive() {
    Hive.box<NoteModel>('noteBox').add(NoteModel(
        title: noteController.noteTitle.text,
        contents: noteController.noteContent.text,
        category: noteController.selectedCategory.value,
        date: noteController.dateToSave.value,
        id: generateUniqueId()));
  }
}
