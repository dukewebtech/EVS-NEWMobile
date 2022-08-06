import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../model/offers_model_api.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/strings_manager.dart';
import 'app_texts/custom_text.dart';

class MyAdsItem extends StatelessWidget {
  final OfferData myAd;
  const MyAdsItem({Key? key, required this.myAd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final evsPayProvider = context.watch<EvsPayViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s13.w),
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
                    text: myAd.paymentMethod.name!,
                  fontWeight: FontWeightManager.bold,
                  textColor: ColorManager.blackTxtColor,
                ),

                CustomTextWithLineHeight(
                  text: myAd.status == "ACTIVE" ? 'Active' : 'Disabled',
                  fontWeight: FontWeightManager.bold,
                  textColor: myAd.status == "ACTIVE" ? ColorManager.lemonGreen :
                  ColorManager.arrowColor,
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
                  text: "${moneyFormat.format(myAd.minAmount)} - "
                      "${moneyFormat.format(myAd.maxAmount)} "
                      "${myAd.currency!.code}",
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
                  text: Jiffy(myAd.createdAt).yMMMMEEEEdjm,
                  fontWeight: FontWeightManager.regular,
                  textColor: ColorManager.arrowColor,
                  fontSize: FontSize.s10,
                ),

                InkWell(
                  onTap: (){
                    evsPayProvider.setSelectedOffer(myAd);
                    show(context, evsPayProvider);
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

  void show(BuildContext ctx, EvsPayViewModel evsPayViewModel) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: ctx,
      builder: (context) => Container(
        height: AppSize.s430.h,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s6.r),
              topRight: Radius.circular(AppSize.s6.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppSize.s16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s31.w),
              child: Container(
                // height: AppSize.s117.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s15.r)
                  ),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.editThisTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),

                      SizedBox(height: AppSize.s20.h,),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),

                      SizedBox(height: AppSize.s22.h,),

                      InkWell(
                        onTap: (){
                          evsPayViewModel.getTradesOnOffer(
                              context: ctx,
                              offerId: evsPayViewModel.selectedOffer.reference);
                          Navigator.pop(context);

                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.viewTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),

                      SizedBox(height: AppSize.s20.h,),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),

                      SizedBox(height: AppSize.s22.h,),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.enableTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),

                      SizedBox(height: AppSize.s20.h,),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),

                      SizedBox(height: AppSize.s22.h,),

                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.deleteTrade,
                          textColor: ColorManager.redColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ],
                  )
              ),
            ),

            SizedBox(
              height: AppSize.s13.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s31.w),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  // height: AppSize.s60.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s5.r)
                  ),
                  alignment: Alignment.center,
                  child: CustomTextWithLineHeight(
                    text: AppStrings.cancel,
                    textColor: ColorManager.blckColor,
                    fontSize: FontSize.s16.sp,
                    fontWeight: FontWeightManager.medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
