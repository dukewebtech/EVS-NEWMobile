
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

PreferredSizeWidget evsPayCustomAppBar(BuildContext context, String title,
    {String iconName = AppImages.backIconPng,
      String? actionIcon,
      String? routeName,
      isCenterAlign = false,
      bool showLeading = true,
      bool isPng = false,
      VoidCallback? leadingTap,
    }) {
  return PreferredSize(
    preferredSize: Size.fromHeight(AppSize.s56.h),
    child: AppBar(
      backgroundColor: const Color.fromRGBO(248, 248, 248, 1),
      shadowColor: const Color.fromRGBO(0, 0, 0, 0.2),
      leading: showLeading ? GestureDetector(
          onTap: leadingTap,
          child: const Icon(Icons.arrow_back_ios, color: ColorManager.greyColor,)) : Container(),
      title: CustomText(
          text: title,
          fontWeight: FontWeightManager.bold,
          textColor: ColorManager.greyColor,
          fontSize: FontSize.s16),
      actions: [
        actionIcon == null
            ? Container()
            : Padding(
          padding: EdgeInsets.only(right: AppSize.s16.w),
          child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                if (routeName != null) {
                  // Navigator.pushNamed(context, Routes.settingsHome);
                }else{
                  // Navigator.pushNamed(context, Routes.settingsHome);
                }
              },
              child: isPng ? Image.asset(actionIcon) : SvgPicture.asset(actionIcon)),
        )
      ],
      centerTitle: isCenterAlign,
      elevation: 4.0,
    ),
  );
}
