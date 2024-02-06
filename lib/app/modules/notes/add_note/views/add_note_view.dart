import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:self_journie_apps/app/global/widget/themed_text_form_field.dart';
import 'package:self_journie_apps/app/global/widget/widget_text_field.dart';
import 'package:self_journie_apps/app/modules/notes/controllers/notes_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/model/note_model.dart';
import '../controllers/add_note_controller.dart';

class AddNoteView extends GetView<AddNoteController> {
  const AddNoteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  // color: Colors.amberAccent,
                ),
                // height: 10.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                        color: Colors.white),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // MyModalBottomButton(
                          //   icon: Icons.visibility,
                          //   description: description.text,
                          //   title: title.text,
                          // ),
                          const SizedBox(
                            width: 12,
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.title.text.isNotEmpty &&
                                  controller.description.text.isNotEmpty) {
                                var now = DateTime.now();
                                var formatterDate = DateFormat(
                                  'yyyy-MM-dd',
                                );
                                String actualDate = formatterDate.format(now);
                                if (controller.navigationData != null) {
                                  final data =
                                      controller.navigationData as Note;

                                  Get.find<NotesController>().updateNote(
                                      Note(
                                          color: data.color,
                                          description:
                                              controller.description.text,
                                          title: controller.title.text,
                                          time: actualDate),
                                      data.noteId);
                                } else {
                                  Get.find<NotesController>().addNoteToList(
                                      Note(
                                          title: controller.title.text,
                                          description:
                                              controller.description.text,
                                          color: Color(
                                                  (math.Random().nextDouble() *
                                                          0xFFFFFF)
                                                      .toInt())
                                              .withOpacity(1.0),
                                          time: actualDate,
                                          noteId: Uuid().v4()));
                                }
                                Get.back(result: true);
                              } else {
                                showSnackBar('Error', 'Please enter title');
                              }
                            },
                            color: Colors.white,
                            icon: Icon(Icons.save),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
                  child: Column(
                    children: [
                      WidgetTextField(
                        anim: false,
                        controller: controller.title,
                        fontSize: 30.sp,
                        multiline: TextInputType.text,
                        icon: Icons.title,
                        max_line_number: 1,
                        hint_color: Colors.black54,
                        hint: 'Add your title',
                        setText: (p0) {},
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      WidgetTextField(
                        anim: false,
                        fontSize: 20.sp,
                        min_line_number: 1,
                        max_line_number: 8,
                        controller: controller.description,
                        multiline: TextInputType.multiline,
                        icon: Icons.description,
                        hint_color: Colors.black54,
                        hint: 'Add your description',
                        setText: (p0) {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
