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
  final bool showRightIcon;
  const EvsPayHeaderWidget({Key? key,
    this.leftIcon = AppImages.activeNotificationIcon,
    this.title = "", this.rightIcon = AppImages.dummyUserIcon,
    this.isWallet = false,
    this.showLeftIcon = true,
    this.showRightIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if(!isWallet && showRightIcon)
          InkWell(
            onTap: (){
              openSettingScreen(context);
            },
            child: Container(
              height:
              AppSize.s40.h,
              width: AppSize.s40.h,
              decoration: BoxDecoration(
                  // color: ColorManager.errorColor,
                  borderRadius: BorderRadius.circular(AppSize.s100.r),
                  image: DecorationImage(image: AssetImage(rightIcon), fit: BoxFit.cover)
              ),
            ),
          ),

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
             child: Image.asset(AppImages.qrCode),
           ),

        if(showLeftIcon)
          InkWell(
              onTap: (){
                openNotificationsScreen(context);
              },
              child: const Icon(Icons.notifications, color: ColorManager.greyColor,)
              // SvgPicture.asset(leftIcon),
          ),

      ],
    );
  }
}
