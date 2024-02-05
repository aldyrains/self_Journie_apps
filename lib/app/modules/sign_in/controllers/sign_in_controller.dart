import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';
import '../../../data/services/auth_services.dart';
import '../../../global/controllers/app_controller.dart';
import '../../../routes/app_pages.dart';

class SignInController extends GetxController {
 final formKey = GlobalKey<FormState>();
  Rx<bool> isPasswordVisible = Rx(false);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> onLogin() async {
    final result = await AuthServices.loginWithEmailAndPassword(
        email: emailController.text, password: passwordController.text); 
    // LoadingDialog.close();
    if (result.success) {
      User user = result.data!;
      Get.find<AppController>().user =
          await AuthServices.updateCurrentUser(user);
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Gagal masuk', result.message);
    }
  }
}
