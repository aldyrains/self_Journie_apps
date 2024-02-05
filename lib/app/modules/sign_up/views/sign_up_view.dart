import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../global/widget/themed_elevated_button.dart';
import '../../../global/widget/themed_text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(fit: StackFit.expand, children: <Widget>[
      Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign Up',
                          style: Get.textTheme.titleLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      ThemedTextFormField(
                        controller: controller.userNameController,
                        validatorString: 'required',
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Username',
                        fontColor: Colors.white,
                      ),
                      SizedBox(height: 16.h),
                      ThemedTextFormField(
                        controller: controller.emailController,
                        validatorString: 'required',
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'Email',
                        fontColor: Colors.white,
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => ThemedTextFormField(
                          fontColor: Colors.white,
                          controller: controller.passwordController,
                          hintText: 'Password',
                          validatorString: 'required',
                          obscure: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => ThemedTextFormField(
                          fontColor: Colors.white,
                          controller: controller.confirmPasswordController,
                          hintText: 'Confirm Password',
                          validatorString: 'required',
                          obscure: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Obx(() => ThemedElevatedButton(
                            buttonText: 'Sign Up',
                            fullWidth: true,
                            onPressed: !controller.isPasswordSame.value
                                ? null
                                : () {
                                    controller.signUpWithEmailAndPassword();
                                  },
                          )),
                      SizedBox(height: 16.h),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Sudah mempunyai akun? ',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10.sp),
                              children: [
                                TextSpan(
                                    text: 'Masuk Sekarang ',
                                    style: Get.textTheme.labelSmall?.copyWith(
                                        color: const Color(0xFF2F80ED)),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.SIGN_IN);
                                      }),
                              ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]));
  }
}
