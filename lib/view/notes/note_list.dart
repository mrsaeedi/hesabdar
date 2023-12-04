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
  void initState() {
    noteController.selectedCategoryshow = '';
    noteController.readNotesFroemHive('');
    noteController.addToNoteCat();

    super.initState();
  }

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
                    child: Obx(() => ListView.builder(
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
                              margin:
                                  const EdgeInsets.fromLTRB(0, 6.0, 20.0, 6),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    //_catindex = index;
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
                                  Get.dialog(AlertDialog(
                                    content: Text(
                                        'تمام زیر دسته ها حذف خواهند، شد آیا مطئن هستید؟'),
                                    title: Text(
                                        noteController.noteCategory[index]),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('لغو')),
                                      TextButton(
                                          onPressed: () async {
                                            noteController
                                                .deleteNoteCatFromHive(
                                                    noteController
                                                        .noteCategory[index]);
                                            await Hive.box<String>('noteCatBox')
                                                .deleteAt(index);
                                            noteController.addToNoteCat();

                                            noteController
                                                .readNotesFroemHive('');

                                            Get.back();
                                          },
                                          child: Text('حذف')),
                                    ],
                                  ));
                                },
                              ),
                            );
                          },
                        )),
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
                        child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          const Color.fromARGB(255, 100, 100, 100)
                              .withOpacity(0.5), // شفافیت (opacity) یا رنگ جدید
                          BlendMode.srcATop, // حالت ترکیب رنگ
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 30),
                                height: 240,
                                child: Image.asset('assets/images/note.png')),
                            Text('یادداشتی نیست')
                          ],
                        ),
                      ))
                    : Obx(() => ListView.builder(
                          itemCount: noteController.showNotes.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0,
                              color: AllColors.kListItems,
                              child: ListTile(
                                subtitle: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  truncateText(
                                      noteController.showNotes[index].contents,
                                      50),
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                title: Text(
                                  noteController.showNotes[index].title,
                                  style: TextStyle(fontSize: 14),
                                ),
                                onLongPress: () {
                                  Get.defaultDialog(
                                    title: 'حذف شود؟',
                                    middleText: '',
                                    textCancel: 'لغو',
                                    textConfirm: 'حذف',
                                    onConfirm: () async {
                                      noteController.deleteFromeHive(
                                        noteController.showNotes[index].id,
                                      );
                                      noteController.readNotesFroemHive(
                                          noteController.selectedCategoryshow);

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
                        )))
          ],
        ),
      )),
    );
  }
}
