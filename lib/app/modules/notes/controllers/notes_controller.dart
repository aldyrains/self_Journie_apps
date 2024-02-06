import 'package:get/get.dart';

import '../../../data/model/note_model.dart';

class NotesController extends GetxController {
   RxList<Note> noteLists = <Note>[].obs;
  final note = Note().obs;

  updateTitle(String title) {
    note.update((val) {
      val?.title = title;
    });
  }

  updateDescription(String description) {
    note.update((val) {
      val?.description = description;
    });
  }

  addNoteToList(Note note) {
    noteLists.add(note);
  }

  updateNote(Note item, id) {
    Note updateNote = noteLists.firstWhere((element) => element.noteId == id);
    updateNote.time = item.time;
    updateNote.title = item.title;
    updateNote.description = item.description;
    noteLists.refresh();
  }

  updateTime(String time) {
    note.update((val) {
      val?.time = time;
    });
  }

  removeFromNoteList(int index) {
    noteLists.removeAt(index);
  }
}
