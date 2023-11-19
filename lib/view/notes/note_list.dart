import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabdar/components/papular_components.dart' show truncateText;
import 'package:hesabdar/data/constants.dart';
import 'package:hesabdar/view/notes/add_note.dart';
import 'package:hive/hive.dart';
import '../../controller/note_controllers.dart/note_controller.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: noteController.selectedCategoryshow == ''
                          ? Color.fromARGB(199, 1, 187, 178)
                          : Color.fromARGB(120, 126, 126, 126),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25))),
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          noteController.selectedCategoryshow = '';
                          noteController.readNotesFroemHive('');
                        });
                      },
                      child: Text(
                        'همه',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Flexible(
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: noteController.noteCategory.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: noteController.selectedCategoryshow ==
                                      noteController.noteCategory[index]
                                  ? Color.fromARGB(199, 1, 187, 178)
                                  : Color.fromARGB(120, 126, 126, 126),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          margin: const EdgeInsets.fromLTRB(0, 6.0, 20.0, 6),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                noteController.selectedCategoryshow =
                                    noteController.noteCategory[index];
                                noteController.readNotesFroemHive(
                                    noteController.noteCategory[index]);
                              });
                              //print(noteController.selectedCategoryShow);
                            },
                            child: Text(
                              noteController.noteCategory[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            onLongPress: () {
                              setState(() {
                                Get.dialog(AlertDialog(
                                  title: Text('حذف شود؟'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('لغو')),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            Hive.box<String>('noteCatBox')
                                                .deleteAt(index);
                                            noteController.addToNoteCat();
                                            Get.back();
                                          });
                                        },
                                        child: Text('حذف')),
                                  ],
                                ));
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 3,
              color: Colors.white,
            ),
            Expanded(
                child: noteController.showNotes.isEmpty
                    ? Center(
                        child: Text('هنوز یادداشتی وجود ندارد'),
                      )
                    : ListView.builder(
                        itemCount: noteController.showNotes.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              subtitle: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                truncateText(
                                    noteController.showNotes[index].contents,
                                    50),
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              title: Text(
                                noteController.showNotes[index].title,
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
                                noteController.selectedCategory.value =
                                    noteController.showNotes[index].category;
                                noteController.selectedIndex = index;
                                noteController.noteEditMode = true;
                                Get.to(AddNewNote());
                                noteController.noteTitle.text =
                                    noteController.showNotes[index].title;
                                noteController.noteContent.text =
                                    noteController.showNotes[index].contents;
                              },
                            ),
                          );
                        },
                      ))
          ],
        ),
      )),
    );
  }
}