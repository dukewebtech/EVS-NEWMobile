import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';


class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  const CustomElevatedButton({Key? key, required this.onTap,
    required this.backgroundColor, required this.textColor,
    required this.title, this.borderColor = Colors.transparent,
    this.height = AppSize.s50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: AppSize.s315.w,
      child: ElevatedButton(
        onPressed: onTap,
        child: CustomTextWithLineHeight(
          text: title,
          fontSize: FontSize.s14,
          fontWeight: FontWeightManager.bold,
          lineHeight: 1.57,
          textColor: const Color.fromRGBO(81, 81, 81, 1),
        ),
        style: ButtonStyle(
          overlayColor:
          MaterialStateProperty.all<Color>(ColorManager.buttonSplashColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s6.r))),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all(
              BorderSide(width: AppSize.s1, color: borderColor)),
        ),
      ),
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  final String iconName;
  const CustomButtonIcon({Key? key, required this.onTap,
    required this.backgroundColor, required this.textColor,
    required this.title, this.borderColor = Colors.transparent,
    this.height = AppSize.s50, required this.iconName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton.icon(
          onPressed: onTap,
          icon: SvgPicture.asset(iconName),
          label: CustomTextWithLineHeight(
            text: title,
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.bold,
            lineHeight: 1.57,
            textColor: textColor,
          ),
        style: ButtonStyle(
          overlayColor:
          MaterialStateProperty.all<Color>(ColorManager.buttonSplashColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s6.r))),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          side: MaterialStateProperty.all(
              BorderSide(width: AppSize.s1, color: borderColor)),
        ),),
    );
  }
}









