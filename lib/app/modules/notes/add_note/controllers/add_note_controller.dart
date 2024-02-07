import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;
import '../../../../data/model/note_model.dart';
import '../../../../data/services/note_services.dart';

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

  onSave() async {
    if (title.text.isNotEmpty && description.text.isNotEmpty) {
      var now = DateTime.now();
      var formatterDate = DateFormat(
        'yyyy-MM-dd',
      );
      String actualDate = formatterDate.format(now);
      if (navigationData != null) {
        final data = navigationData as Note;
        await NoteServices.updateMenu(notes: Note(
                color: data.color,
                description: description.text,
                title: title.text,
                time: actualDate),);
      } else {
        await NoteServices.firebaseAddNotes(
            title.text,
            description.text,
            Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0),
            actualDate);
      }
      Get.back(result: true);
    } else {
      showSnackBar('Error', 'Please enter title');
    }
  }
    showSnackBar(String title, String description) {
    Get.closeAllSnackbars();
    Get.snackbar(
      "Error",
      "Please add title",
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 30,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.yellow[800],
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    title.dispose();
    description.dispose();
  }
}
