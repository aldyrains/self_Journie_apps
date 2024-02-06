import 'package:get/get.dart';

class NoteItemController extends GetxController {
  late NoteItemArgs args;

  @override
  void onInit() {
    args = Get.arguments;
    super.onInit();
  }
}

class NoteItemArgs {
  final int index;
  final item;
  final bool isDismissable;
  void Function()? onTap;
  NoteItemArgs(
      { required this.index,required this.item, this.isDismissable = true, this.onTap});
}
