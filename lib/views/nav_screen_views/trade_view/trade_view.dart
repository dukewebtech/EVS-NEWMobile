import 'package:evs_pay_mobile/model/my_ads_model.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/my_ads.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/trandes_on_my_ads.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/my_offer_item.dart';
import 'package:evs_pay_mobile/widgets/trade_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TradeView extends StatefulWidget {
  const TradeView({Key? key}) : super(key: key);

  @override
  State<TradeView> createState() => _TradeViewState();
}

class _TradeViewState extends State<TradeView> {
  bool isMyAds = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsTradeAppBar(context, AppStrings.trades, onTap: (){
      //  Create a new trade or ads
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
                              child: const CustomTextWithLineHeight(text: AppStrings.myAds,
                              fontSize: FontSize.s15, fontWeight: FontWeightManager.medium,
                              textColor: ColorManager.blckColor,),
                            ),
                          ),
                          SizedBox(width: AppSize.s10.h,),
                          SvgPicture.asset(AppImages.dropDownIcon)
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
                              child: const CustomTextWithLineHeight(text: AppStrings.trades,
                                fontSize: FontSize.s15, fontWeight: FontWeightManager.medium,
                                textColor: ColorManager.blckColor,),
                            ),
                          ),
                          SizedBox(width: AppSize.s10.h,),
                          SvgPicture.asset(AppImages.dropDownIcon)
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
                const MyAdsWidget(),

              if(!isMyAds)
                const TradeOnMyAdsWidget(),

            ],
          )),
    );
  }
}
