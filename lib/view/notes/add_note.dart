import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/controller/note_controllers.dart/note_controller.dart';
import 'package:hesabdar/model/note_mode/note_model.dart';
import 'package:hive/hive.dart';

class AddNewNote extends StatelessWidget {
  AddNewNote({super.key});
  final NoteController noteController = Get.put(NoteController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Hive.box<NoteModel>('noteBox')
                              .add(NoteModel(
                                  title: noteController.noteTitle.text,
                                  contents: noteController.noteContent.text,
                                  category: 'category',
                                  date: '1402.3'))
                              .then((value) {
                            noteController.noteTitle.clear();
                            noteController.noteContent.clear();
                          });
                          noteController.allNotes.refresh();
                          Get.back();
                        },
                        icon: Icon(
                          Icons.check_outlined,
                          size: 30,
                        )),
                    Text('یادداشت جدید'),
                    SizedBox(
                      width: 60,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: noteController.noteTitle,
                  decoration: InputDecoration(
                      hintText: 'عنوان',
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(171, 158, 158, 158)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10)),
                ),
              ),
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
}
