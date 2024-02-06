import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../controllers/notes_controller.dart';
import '../controllers/note_item_controller.dart';

class NoteItemView extends GetView<NoteItemController> {
  const NoteItemView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.w, 12.w, 12.w, 0),
      child: InkWell(
        focusColor: Colors.white,
        highlightColor: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        onTap: controller.args.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Dismissible(
            direction: controller.args.isDismissable
                ? DismissDirection.startToEnd
                : DismissDirection.none,
            key: UniqueKey(),
            onDismissed: (direction) {
            () {
                Get.find<NotesController>().noteLists.removeAt(controller.args.index);
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
                  color: controller.args.item.color,
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
                                  controller.args.item.title,
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
                                    '${controller.args.item.time}',
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
                              controller.args.item.description,
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

