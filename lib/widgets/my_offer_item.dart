import 'package:evs_pay_mobile/model/my_ads_model.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/strings_manager.dart';
import 'app_texts/custom_text.dart';

class MyAdsItem extends StatelessWidget {
  final MyAdsModel myAd;
  const MyAdsItem({Key? key, required this.myAd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
      child: Container(
        height: AppSize.s96.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s3.r),
          border: Border.all(
            color: ColorManager.inputFieldBorder
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWithLineHeight(
                    text: myAd.paymentMethod,
                  fontWeight: FontWeightManager.bold,
                  textColor: ColorManager.blackTxtColor,
                ),

                CustomTextWithLineHeight(
                  text: myAd.status == "active" ? 'Active' : 'Disabled',
                  fontWeight: FontWeightManager.bold,
                  textColor: myAd.status == "active" ? ColorManager.lemonGreen :
                  ColorManager.blackTxtColor,
                ),
              ],
            ),

            SizedBox(height: AppSize.s8.h,),
            Row(
              children: [
                const CustomTextWithLineHeight(
                  text: "Limit:",
                  fontWeight: FontWeightManager.regular,
                  textColor: ColorManager.blackTxtColor,
                  fontSize: FontSize.s10,
                ),

                CustomTextWithLineHeight(
                  text: myAd.transactionLimit,
                  fontWeight: FontWeightManager.regular,
                  textColor: ColorManager.arrowColor,
                  fontSize: FontSize.s10,
                ),
              ],
            ),

            SizedBox(height: AppSize.s12.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextWithLineHeight(
                  text: myAd.time,
                  fontWeight: FontWeightManager.regular,
                  textColor: ColorManager.arrowColor,
                ),

                InkWell(
                  onTap: (){
                    show(context);
                  },
                  child: SvgPicture.asset(AppImages.myAdsMoreIcon),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(AppSize.s16.r),
        height: AppSize.s397.h,
        decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s6.r),
              topRight: Radius.circular(AppSize.s6.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSize.s16.h),
            CustomText(
              text: AppStrings.paymentMethod,
              textColor: ColorManager.primaryColor,
              fontSize: FontSize.s16.sp,
              fontWeight: FontWeightManager.medium,
            ),
            SizedBox(
              height: AppSize.s18.h,
            ),

            SizedBox(
              height: AppSize.s4.h,
            )
          ],
        ),
      ),
    );
  }
}
