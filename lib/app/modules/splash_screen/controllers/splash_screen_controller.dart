import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../../data/model/user_model.dart';
import '../../../data/services/auth_services.dart';
import '../../../global/controllers/app_controller.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  void checkLogin() async {
    try {
      if (auth.FirebaseAuth.instance.currentUser != null) {
        final result = await AuthServices.getUser(
            auth.FirebaseAuth.instance.currentUser!.uid);
        Get.find<AppController>().user = result.data;
        print('result.success: ${result.success}');

        if (result.success) {
          User user = Get.find<AppController>().user!;
          user.fcmToken = await AuthServices.firebaseMessaging.getToken() ?? '';
          Get.find<AppController>().user =
              await AuthServices.updateCurrentUser(user);
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.SIGN_IN);
        }
      } else {
        Get.offAllNamed(Routes.SIGN_IN);
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  @override
  void onInit() {
    print('MASUKPAK');
    Future.delayed(const Duration(seconds: 3)).then((value) {
      checkLogin();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
