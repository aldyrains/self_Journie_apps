import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/user_model.dart';
import '../../../data/services/auth_services.dart';
import '../../../routes/app_pages.dart';

class SignUpController extends GetxController {
  Rx<bool> isPasswordVisible = Rx(false);
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  Rx<bool> passwordValidated = Rx(false);
  Rx<bool> isPasswordSame = Rx(false);

   @override
  void onInit() {
    passwordController.addListener(() {
      validateConfirmPassword();
    });
    confirmPasswordController.addListener(() {
      validateConfirmPassword();
    });
    // signUp();
    super.onInit();
  }

  void validateConfirmPassword() {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (confirmPasswordController.text == passwordController.text) {
        isPasswordSame.value = true;
      } else {
        isPasswordSame.value = false;
      }
    }
  }

  @override
  void onClose() {
    Get.back();
    super.onClose();
  }

  signUpWithEmailAndPassword() async {
    dynamic result =
        await AuthServices.firebaseSignUpWithEmailAndPassword(
      emailController.text.trim(),
      passwordController.text.trim(),
      userNameController.text,
    );
    if (result != null && result is User) {
      await AuthServices.updateCurrentUser(result);

      Get.toNamed(Routes.SIGN_IN);
    } else if (result != null && result is String) {
      Get.dialog(CupertinoAlertDialog(
        title: const Text('Failed'),
        content: Text(result),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('ok'))
        ],
      ));
    } else {
      Get.dialog(CupertinoAlertDialog(
        title: const Text('Failed'),
        content: const Text("Tidak bisa mendaftar"),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('ok'))
        ],
      ));
    }
  }
}
