import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/my_ads.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/my_ads_future_builder_widget.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/trades_widget.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/trade_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../view_models/general_view_model.dart';
import '../../../view_models/trade_view_model.dart';


class TradeViewCopy extends StatefulWidget {
  const TradeViewCopy({Key? key}) : super(key: key);

  @override
  State<TradeViewCopy> createState() => _TradeViewCopyState();
}

class _TradeViewCopyState extends State<TradeViewCopy> {
  bool isMyAds = true;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final evsPayViewModel = context.watch<EvsPayViewModel>();
    return Scaffold(
      appBar: evsTradeAppBar(context, AppStrings.trades, onTap: ()async{
        evsPayViewModel.getPaymentMethods(context: context);
        openCreateOfferScreen(context);
      }),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppSize.s18.h,),
              Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: AppSize.s54.w),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  isMyAds = true;
                                });
                              },
                              child: const CustomTextWithLineHeight(
                                text: AppStrings.myAds,
                                fontSize: FontSize.s15,
                                fontWeight: FontWeightManager.medium,
                                textColor: ColorManager.blckColor,),
                            ),
                          ),
                          SizedBox(width: AppSize.s10.h,),
                          InkWell(
                              onTap: (){
                                if(isMyAds){
                                  show(context);
                                }
                              },
                              child: Container(
                                  width: AppSize.s30.w,
                                  height: AppSize.s10.h,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppImages.dropDownIcon)))
                        ],
                      ),
                      SizedBox(height: AppSize.s8.h,),
                      if(isMyAds)
                        Container(
                          height: AppSize.s5.h,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryColor
                          ),
                        )
                    ],
                  )),

                  Expanded(child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: AppSize.s54.w),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  isMyAds = false;
                                });
                              },
                              child: const CustomTextWithLineHeight(
                                text: AppStrings.trades,
                                fontSize: FontSize.s15,
                                fontWeight: FontWeightManager.medium,
                                textColor: ColorManager.blckColor,),
                            ),
                          ),
                          SizedBox(width: AppSize.s10.h,),
                          InkWell(
                              onTap: (){
                                if(!isMyAds){
                                  showTradeDialog(context);
                                }
                              },
                              child: Container(
                                  width: AppSize.s30.w,
                                  height: AppSize.s10.h,
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(AppImages.dropDownIcon)))
                        ],
                      ),
                      SizedBox(height: AppSize.s8.h,),
                      if(!isMyAds)
                        Container(
                          height: AppSize.s5.h,
                          decoration: const BoxDecoration(
                              color: ColorManager.primaryColor
                          ),
                        )
                    ],
                  )),
                ],
              ),

              if(isMyAds)
                evsPayViewModel.isLoading? Container() : const MyAdsFutureBuilderWidget(),
                // evsPayViewModel.isLoading ? Container() : const MyAdsWidget(),

              if(!isMyAds)
                evsPayViewModel.isLoading ? Container() : const TradesWidget(),

            ],
          )),
    );
  }
  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: AppSize.s350.h,
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
                          text: AppStrings.disableTrade,
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

  void showTradeDialog(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: AppSize.s510.h,
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
                          text: AppStrings.active,
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
                          text: AppStrings.completed,
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
                          text: AppStrings.confirmed,
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
                          text: AppStrings.disputed,
                          textColor: ColorManager.redColor,
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
                          text: AppStrings.cancelled,
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
