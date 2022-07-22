import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';


class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double height;
  final bool isIconButton;
  final double fontSize;
  final double width;
  FontWeight fontWeight;
  CustomElevatedButton({Key? key, required this.onTap,
    required this.backgroundColor, required this.textColor,
    required this.title, this.borderColor = Colors.transparent,
    this.height = AppSize.s50,
    this.isIconButton = false,
    this.fontSize = 14,
    this.width = 315,
    this.fontWeight = FontWeightManager.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        onPressed: onTap,
        child: isIconButton ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppImages.qrCodeScannerIcon),
            SizedBox(width: AppSize.s5.w,),
            CustomTextWithLineHeight(
              text: title,
              fontSize: fontSize,
              fontWeight: fontWeight,
              textColor: textColor,
            ),
          ],
        ) : CustomTextWithLineHeight(
          text: title,
          fontSize: fontSize,
          fontWeight: fontWeight,
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









