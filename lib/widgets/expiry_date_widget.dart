import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

class ExpiryDateWidget extends StatelessWidget {
  final String item;
  const ExpiryDateWidget({Key? key,
  required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s24.w,
      height: AppSize.s21.h,
      decoration: BoxDecoration(
          color: ColorManager.primaryColor,
          borderRadius: BorderRadius.circular(AppSize.s2.r)
      ),
      alignment: Alignment.center,
      child: CustomText(
        text: item,
        fontSize: FontSize.s16,
        textColor: ColorManager.blckColor,
        fontWeight: FontWeightManager.semiBold,
      ),
    );
  }
}
