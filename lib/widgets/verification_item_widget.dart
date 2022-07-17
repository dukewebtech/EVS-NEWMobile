import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';

class VerificationItemWidget extends StatelessWidget {
  final String iconName;
  final String title;
  final String subTitle;
  final VoidCallback onTap;
  final bool isVerified;
  const VerificationItemWidget({Key? key, required this.iconName,
    required this.title, required this.subTitle, required this.onTap,
    this.isVerified = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.s62.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(247, 247, 252, 1),
        borderRadius: BorderRadius.circular(AppSize.s20.r),
      ),
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(iconName),
        title: CustomTextWithLineHeight(text: title,
          textColor: isVerified? ColorManager.lightTextColor : ColorManager.blackTextColor, fontSize: FontSize.s20,
          fontWeight: FontWeightManager.semiBold,),
        subtitle: CustomTextWithLineHeight(text: subTitle,
          textColor: ColorManager.lightTextColor,
          fontSize: FontSize.s12, fontWeight: FontWeightManager.medium,),
        trailing: SvgPicture.asset(isVerified? AppImages.verificationGoodIcon : AppImages.verificationForwardArrow),
      ),
    );
  }
}
