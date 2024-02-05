import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../global/const/colors.dart';
import '../../../global/widget/themed_elevated_button.dart';
import '../../../global/widget/themed_text_form_field.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignInView'),
        centerTitle: true,
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In',
                          style: Get.textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      ThemedTextFormField(
                          controller: controller.emailController,
                          validatorString: 'required',
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Email Address',
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
                                  color: Colors.white,
                            ),
                            onPressed: () {
                              controller.isPasswordVisible.value =
                                  !controller.isPasswordVisible.value;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: (){},
                          child: Text(
                            'Lupa kata sandi?',
                            style: Get.textTheme.bodySmall
                                ?.copyWith(color: ColorsApp.blue),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ThemedElevatedButton(
                        buttonText: 'Masuk',
                        fullWidth: true,
                        onPressed: () async {
                          controller.onLogin();
                        },
                      ),
                      SizedBox(height: 16.h),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Belum mempunyai akun? ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10.sp),
                              children: [
                                TextSpan(
                                    text: 'Daftar Sekarang ',
                                    style: TextStyle(
                                        color: const Color(0xFF2F80ED),
                                        fontSize: 12.sp),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(Routes.SIGN_UP);
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
    );
  }
}
