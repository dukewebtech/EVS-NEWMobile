import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';

class EvsPayHeaderWidget extends StatelessWidget {
  final String leftIcon;
  final String title;
  final String rightIcon;
  final bool isWallet;
  final bool showLeftIcon;
  const EvsPayHeaderWidget({Key? key,
    this.leftIcon = AppImages.activeNotificationIcon,
    this.title = "", this.rightIcon = AppImages.dummyGuy,
    this.isWallet = false,
    this.showLeftIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(showLeftIcon)
        InkWell(
          onTap: (){
            openNotificationsScreen(context);
          },
            child: SvgPicture.asset(leftIcon)),
        CustomTextWithLineHeight(text: title,
          textColor: ColorManager.lightTextColor,
          fontWeight: FontWeightManager.bold, fontSize: FontSize.s16,),
         if(isWallet)
           Container(
             height:
             AppSize.s40.h,
             width: AppSize.s40.h,
             decoration: BoxDecoration(
                 color: ColorManager.blueColor,
                 borderRadius: BorderRadius.circular(AppSize.s3.r),

             ),
             child: SvgPicture.asset(AppImages.qrCode),
           ),
         if(!isWallet)
         Container(
          height:
          AppSize.s40.h,
          width: AppSize.s40.h,
          decoration: BoxDecoration(
              color: ColorManager.errorColor,
              borderRadius: BorderRadius.circular(AppSize.s100.r),
              image: DecorationImage(image: AssetImage(rightIcon), fit: BoxFit.cover)
          ),
        )
      ],
    );
  }
}
