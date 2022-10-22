import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/navigation_utils.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/app_texts/custom_text.dart';

class VerifyAccountToTradeScreen extends StatelessWidget {
  const VerifyAccountToTradeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(child: InkWell(
        onTap: (){
          openVerificationHomeView(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s100.h,
                width: AppSize.s100.h,
                child: SvgPicture.asset(AppImages.verifyIconYellow)),

            Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s12.w),
              child: Container(
                  height: AppSize.s49.h,
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            CustomTextWithLineHeight(
                              text: AppStrings.verifyAccount,
                              fontWeight: FontWeightManager.bold,
                              textColor: ColorManager.blckColor,
                              fontSize: FontSize.s28,),
                          ],
                        ),
                      ),
                    ],
                  )
              ),),


            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const CustomTextWithLineHeight(
                text: AppStrings.youHaveNotComplete,
                alignCenter: true,
                textColor: ColorManager.blckColor,
                fontSize: FontSize.s18,),
            ),


            SizedBox(height: AppSize.s16.h,),
            CustomElevatedButton(onTap: (){
              openVerificationHomeView(context);
            },
                backgroundColor: ColorManager.primaryColor,
                textColor: ColorManager.blackTextColor,
                title: "Verify Now")
          ],
        ),
      )),
    );
  }
}
