import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';

class CustomTextField extends StatelessWidget {
      final bool autoFocus;
   final bool obSecureText;
      final int? maxLines;
      final double contentPadding;
  final String hint;
      final TextEditingController controller;
        const CustomTextField({Key? key, this.autoFocus = false,
    this.obSecureText = false,
    this.hint = "",
          this.maxLines = 1,
          required this.controller,
           this.contentPadding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: ColorManager.whiteColor,
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              cursorColor: ColorManager.textFieldColor,
              autofocus: autoFocus,
              maxLines: maxLines,
              obscureText:  obSecureText,
              style: const TextStyle(
                color: ColorManager.textFieldColor,
                  fontSize: FontSize.s16
              ),
              decoration: InputDecoration(
                filled: false,
                fillColor: ColorManager.whiteColor,
                contentPadding: EdgeInsets.all(contentPadding),
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                      width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0.0,
                  borderRadius: BorderRadius.circular(5.r),
                  borderSide: const BorderSide(color: ColorManager.textFieldColor,
                      width: 1),
                ),
                hintStyle: const TextStyle(
                  color: ColorManager.labelTextColor,
                  fontSize: FontSize.s16
                ),
                  labelStyle: const TextStyle(
                    color: ColorManager.labelTextColor,
                      fontSize: FontSize.s16
                  )
              ),
            )
        ),
      ],
    );
  }
}
