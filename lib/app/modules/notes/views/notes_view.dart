import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:self_journie_apps/app/modules/notes/note_item/controllers/note_item_controller.dart';

import '../../../routes/app_pages.dart';
import '../controllers/notes_controller.dart';

class NotesView extends GetView<NotesController> {
  const NotesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: Colors.blue,
              ),
              // height: 10.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  UnconstrainedBox(
                    child: FittedBox(
                      child: Text(
                        'Notes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 34.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        UnconstrainedBox(
                          child: SizedBox(
                            width: 60.sp,
                            height: 60.sp,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(52, 58, 64, 0.5),
                                primary: Colors.white,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                // Get.toNamed(page);
                              },
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => Container(
                    child: controller.noteLists.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            addRepaintBoundaries: true,
                            itemCount: controller.noteLists.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = controller.noteLists[index];
                              Get.toNamed(Routes.NOTE_ITEM,
                                  arguments: NoteItemArgs(
                                    index: index,
                                    item: item,
                                    onTap: () {
                                      Get.toNamed(Routes.ADD_NOTE);
                                    },
                                  ));
                            },
                          )
                        : SizedBox(
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedContainer(
                                  width: 150.w,
                                  height: 150.w,
                                  curve: Curves.slowMiddle,
                                  duration: const Duration(milliseconds: 500),
                                  margin: EdgeInsets.only(bottom: 12.w),
                                  child: 
                                  Icon(Icons.edit_note_outlined,size: 150.r,
                                      color: Colors.white),
                                ),
                                Text(
                                  'Create your first Note!',
                                  style: TextStyle(
                                      fontSize: 24.sp, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 60.sp,
        height: 60.sp,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.ADD_NOTE);
          },
          // tooltip: 'Increment',
          child: Icon(
            Icons.add,
            size: 32.sp,
          ),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromRGBO(52, 58, 64, 0.5),
        ),
      ),
    );
  }
}
