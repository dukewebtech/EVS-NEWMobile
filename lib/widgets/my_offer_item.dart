import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:evs_pay_mobile/view_models/my_ads_view_model.dart';
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
    final myAdsViewModel = context.watch<MyAdsViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s13.w),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s3.r),
            border: Border.all(color: ColorManager.inputFieldBorder)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: AppSize.s13.h,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 0,
                left: 0,
                right: 0,
              ),
              decoration: BoxDecoration(
                  // color: Colors.yellow,
                  // color: Color(0xfff6f6f6),
                  borderRadius: BorderRadius.circular(0)),
              height: 104,
              width: double.infinity,
              child: Stack(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Positioned(
                    left: 0,
                    top: 5,
                    child: Text(
                      myAd.paymentMethod.name!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Lexend',
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 5,
                      child: InkWell(
                          onTap: () {
                            print('tap');
                          },
                          child: const Icon(Icons.more_vert))),
                  Positioned(
                    right: 0,
                    bottom: 30,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.035,
                      width: MediaQuery.of(context).size.width * 0.18,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          backgroundColor: const Color(0xffF4B731),
                        ),
                        onPressed: () {
                          // openSellView(context);
                        },
                        child: const FittedBox(
                          child: Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff303030),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Positioned(
                    top: 30,
                    left: 0,
                    child: Text(
                      "NGN ${moneyFormat.format(myAd.minAmount)} - "
                      "${moneyFormat.format(myAd.maxAmount)} ",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lexend',
                        color: Color(0xff8e8e8e),
                      ),
                    ),
                  ),

                  Positioned(
                    left: 0,
                    top: 65,
                    child: Text(
                      Jiffy(myAd.createdAt).yMMMMEEEEdjm,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lexend',
                        color: Color(0xff8e8e8e),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Positioned(
                    bottom: 5,
                    left: -15,
                    right: -15,
                    child: Divider(
                      thickness: 1.5,
                    ),
                  ),

                  ///

                 
                ],
              ),
            ),

            /// this is his original widgets for this page
            CustomTextWithLineHeight(
              text: myAd.paymentMethod.name!,
              fontWeight: FontWeightManager.bold,
              textColor: ColorManager.blackTxtColor,
            ),
            CustomTextWithLineHeight(
              text: myAd.type,
              fontWeight: FontWeightManager.bold,
              textColor: myAd.type == "SELL"
                  ? ColorManager.primaryColor
                  : ColorManager.lemonGreen,
            ),
            SizedBox(
              height: AppSize.s8.h,
            ),
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
            SizedBox(
              height: AppSize.s12.h,
            ),
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
                  onTap: () {
                    evsPayProvider.setSelectedOffer(myAd);
                    show(context, evsPayProvider, myAdsViewModel);
                  },
                  child: SvgPicture.asset(AppImages.myAdsMoreIcon),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  // height: AppSize.s15.h,
                  // width: AppSize.s48.w,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s22.w, vertical: AppSize.s3.h),
                  decoration: BoxDecoration(
                      color: myAd.status == "ACTIVE"
                          ? ColorManager.deepGreenColor
                          : ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(AppSize.s2.r)),
                  alignment: Alignment.center,
                  child: CustomTextWithLineHeight(
                    text: myAd.status ?? "",
                    textColor: myAd.status == "ACTIVE"
                        ? ColorManager.whiteColor
                        : ColorManager.blckColor,
                    fontSize: FontSize.s6,
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppSize.s3.h,
            )
          ],
        ),
      ),
    );
  }

  void show(BuildContext ctx, EvsPayViewModel evsPayViewModel,
      MyAdsViewModel myAdsViewModel) {
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
                      borderRadius: BorderRadius.circular(AppSize.s15.r)),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          openEditOffer(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.editThisTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
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
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          await evsPayViewModel.enableOrDisableOffer(context);
                        },
                        child: CustomTextWithLineHeight(
                          text:
                              evsPayViewModel.selectedOffer.status == "INACTIVE"
                                  ? AppStrings.enableTrade
                                  : AppStrings.disableTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
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
                  )),
            ),
            SizedBox(
              height: AppSize.s13.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s31.w),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // height: AppSize.s60.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s5.r)),
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
