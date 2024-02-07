import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/notes_controller.dart';

class NotesView extends GetView<NotesController> {
  const NotesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
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
                              buildNoteItem(
                                index: index,
                                item: item,
                                isDismissable: true,
                                onTap: () {
                                  Get.toNamed(Routes.ADD_NOTE);
                                }, 
                              );
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
                                  child: Icon(Icons.edit_note_outlined,
                                      size: 150.r, color: Colors.white),
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

  buildNoteItem(
      {required int index,
      final item,
      required bool isDismissable,
      void Function()? onTap}) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
      child: InkWell(
        focusColor: Colors.white,
        highlightColor: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Dismissible(
            direction: isDismissable
                ? DismissDirection.startToEnd
                : DismissDirection.none,
            key: UniqueKey(),
            onDismissed: (direction) {
              () {
                Get.find<NotesController>().noteLists.removeAt(index);
              };
            },
            background: Container(
              color: Colors.red,
              child: Icon(
                Icons.delete,
                size: 60.sp,
                color: Colors.white,
              ),
            ),
            child: Column(
              children: [
                Container(
                  color: item.color,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: FittedBox(
                                  child: Text(
                                    '${item.time}',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 0, 18.w, 4.w),
                          child: FittedBox(
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black54),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
