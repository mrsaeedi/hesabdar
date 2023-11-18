import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/view/notes/add_note.dart';

import '../../controller/note_controllers.dart/note_controller.dart';

class NoteListPage extends StatelessWidget {
  NoteListPage({super.key});
  NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Obx(() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: noteController.noteCategory.length,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              height: 16,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(174, 126, 126, 126),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              margin: EdgeInsets.only(bottom: 18),
                              padding: EdgeInsets.all(8.0),
                              child: Text('دسته بندی'),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(noteController.noteCategory[index]),
                            );
                    },
                  )),
            ),
            Divider(
              height: 3,
              color: Colors.white,
            ),
            Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: noteController.allNotes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              noteController.allNotes[index].title,
                            ),
                            onLongPress: () {
                              Get.defaultDialog(
                                title: 'حذف شود؟',
                                middleText: '',
                                textCancel: 'لغو',
                                textConfirm: 'حذف',
                                onConfirm: () {
                                  noteController.deleteFromeHive(index);
                                  Get.back();
                                },
                              );
                            },
                            onTap: () {
                              noteController.noteEditMode = true;
                              Get.to(AddNewNote());
                              noteController.noteTitle.text =
                                  noteController.allNotes[index].title;
                              noteController.noteContent.text =
                                  noteController.allNotes[index].contents;
                            },
                          ),
                        );
                      },
                    )))
          ],
        ),
      )),
    );
  }
}
