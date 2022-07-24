
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

PreferredSizeWidget evsTradeAppBar(BuildContext context, String title,
    {
      VoidCallback? onTap,
    }) {
  return PreferredSize(
    preferredSize: Size.fromHeight(AppSize.s40.h),
    child: AppBar(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
      title: CustomText(
          text: title,
          fontWeight: FontWeightManager.bold,
          textColor: const Color.fromRGBO(38, 38, 40, 1),
          fontSize: FontSize.s20),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: AppSize.s16.w),
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: onTap,
              child: SvgPicture.asset(AppImages.addTradeIcon)),
        )
      ],
      centerTitle: false,
      elevation: 4.0,
    ),
  );
}
