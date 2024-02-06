import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notes/add_note/bindings/add_note_binding.dart';
import '../modules/notes/add_note/views/add_note_view.dart';
import '../modules/notes/bindings/notes_binding.dart';
import '../modules/notes/note_item/bindings/note_item_binding.dart';
import '../modules/notes/note_item/views/note_item_view.dart';
import '../modules/notes/views/notes_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.NOTES;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.NOTES,
      page: () => const NotesView(),
      binding: NotesBinding(),
      children: [
        GetPage(
          name: _Paths.NOTE_ITEM,
          page: () => const NoteItemView(),
          binding: NoteItemBinding(),
        ),
        GetPage(
          name: _Paths.ADD_NOTE,
          page: () => const AddNoteView(),
          binding: AddNoteBinding(),
        ),
      ],
    ),
  ];
}
