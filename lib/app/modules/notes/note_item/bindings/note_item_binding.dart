import 'package:get/get.dart';

import '../controllers/note_item_controller.dart';

class NoteItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NoteItemController>(
      () => NoteItemController(),
    );
  }
}
