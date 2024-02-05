import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../const/colors.dart';

class ThemedTextFormField extends StatelessWidget {
  const ThemedTextFormField(
      {Key? key,
      required this.controller,
      this.label,
      required this.hintText,
      this.focusNode,
      this.validatorString = 'required',
      this.obscure = false,
      this.readOnly = false,
      this.fullTap = false,
      this.suffixIcon,
      this.onTap,
      this.maxLines = 1,
      this.minLines = 1,
      this.keyboardType = TextInputType.text,
      this.enabled = true,
      this.prefixIcon,
      this.fontColor,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? label;
  final String hintText;
  final bool obscure;
  final bool readOnly;
  final bool fullTap;
  final Widget? suffixIcon;
  final Function()? onTap;
  final String? validatorString;
  final Color? fontColor;
  final int? maxLines;
  final int? minLines;
  final TextInputType keyboardType;
  final bool enabled;
  final Widget? prefixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      cursorColor: ColorsApp.primary,
      enabled: enabled,
      onTap: () {
        if (readOnly || fullTap) {
          onTap!();
        }
      },
      controller: controller,
      obscureText: obscure,
      textAlign: TextAlign.left,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      // 'required' for required and '' for not required
      // validator: (input) => inspection(input, validatorString, locale: 'en'),
      readOnly: readOnly,
      focusNode: focusNode,
      style: TextStyle(fontSize: 14.sp ,color: fontColor),
      decoration: InputDecoration(

          alignLabelWithHint: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(color: Colors.grey, width: 0.85.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.lightGreen, width: 0.9.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide:
                BorderSide(color: ColorsApp.disableColor, width: 0.85.r),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(color: Colors.redAccent, width: 0.9.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0.r),
            borderSide: BorderSide(color: Colors.redAccent, width: 1.1.r),
          ),
          label: label == null
              ? null
              : Text("$label ${validatorString == 'required' ? '*' : ''}"),
          labelStyle: TextStyle(fontSize: 12.sp),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12.sp , color:fontColor),
          filled: false,
          isDense: false,
          contentPadding: EdgeInsets.all(16.r),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon),
      onChanged: onChanged,
    );
  }
}
