import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';

class ThemedElevatedButton extends StatelessWidget {
  const ThemedElevatedButton({
    Key? key,
    this.onPressed,
    required this.buttonText,
    this.fullWidth = true,
    this.backgroundColor,
    this.icon,
    this.textColor,
    this.borderColor,
    this.isTransparent,
  }) : super(key: key);
  final Function()? onPressed;
  final String buttonText;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final String? icon;
  final Color? borderColor;
  final bool? isTransparent;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: fullWidth ? Size.fromHeight(48.h) : null,
        backgroundColor: isTransparent == true
            ? Colors.transparent
            : backgroundColor ?? ColorsApp.primary,
        elevation: isTransparent == true ? 0 : 1,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: onPressed == null
                    ? Colors.white
                    : borderColor ?? ColorsApp.primary),
            borderRadius: BorderRadius.circular(8.r)),
      ),
      child: icon != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  icon!,
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  buttonText,
                  style: TextStyle(
                      color: textColor ?? Colors.white, fontSize: 14.sp),
                ),
              ],
            )
          : Text(
              buttonText,
              style:
                  TextStyle(color: textColor ?? Colors.white, fontSize: 14.sp),
            ),
    );
  }
}
