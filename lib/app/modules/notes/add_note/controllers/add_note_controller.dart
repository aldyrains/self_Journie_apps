import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/note_model.dart';

class AddNoteController extends GetxController {
   TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  var navigationData;

  @override
  void onInit() {
    super.onInit();
      var data = Get.arguments;
      if (data != null && data[0] == false) {
        final note = data[1] as Note;
        navigationData = note;
        title.text = note.title;
        description.text = note.description;
      }
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    description.dispose();
  }
}
