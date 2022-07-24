import 'package:evs_pay_mobile/model/my_ads_model.dart';
import 'package:evs_pay_mobile/model/trade_model.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/trade_app_bar.dart';
import 'package:evs_pay_mobile/widgets/trade_on_my_ad_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';


class ViewTradeView extends StatefulWidget {
  const ViewTradeView({Key? key}) : super(key: key);

  @override
  State<ViewTradeView> createState() => _ViewTradeViewState();
}

class _ViewTradeViewState extends State<ViewTradeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsTradeAppBar(context, AppStrings.myOfferDetails,
          showActionButton: false,  onTap: (){
        //  Create a new trade or ads
      }),
      body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: AppSize.s8.h,),

              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s10.w),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s3.r),
                    color: ColorManager.primaryColor
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s10.w, vertical: AppSize.s13.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomTextWithLineHeight(
                              text: myAds[0].paymentMethod,
                              fontWeight: FontWeightManager.bold,
                              textColor: ColorManager.blackTxtColor,
                            ),

                            CustomTextWithLineHeight(
                              text: myAds[0].status == "active" ? 'Active' : 'Disabled',
                              fontWeight: FontWeightManager.bold,
                              textColor: myAds[0].status == "active" ? ColorManager.lemonGreen :
                              ColorManager.blackTxtColor,
                            ),
                          ],
                        ),

                        SizedBox(height: AppSize.s8.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CustomTextWithLineHeight(
                                  text: "Limit:",
                                  fontWeight: FontWeightManager.regular,
                                  textColor: ColorManager.blackTxtColor,
                                  fontSize: FontSize.s10,
                                ),

                                CustomTextWithLineHeight(
                                  text: myAds[0].transactionLimit,
                                  fontWeight: FontWeightManager.regular,
                                  textColor: ColorManager.arrowColor,
                                  fontSize: FontSize.s10,
                                ),
                              ],
                            ),

                            CustomTextWithLineHeight(
                              text: myAds[1].type.toUpperCase(),
                              fontWeight: FontWeightManager.bold,
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
                              text: myAds[0].time,
                              fontWeight: FontWeightManager.regular,
                              textColor: ColorManager.arrowColor,
                            ),

                            InkWell(
                              onTap: (){
                                // show(context);
                              },
                              child: SvgPicture.asset(AppImages.myAdsMoreIcon),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppSize.s39.w,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
                child: Row(
                  children: const [
                    CustomTextWithLineHeight(
                      text: AppStrings.tradesForOffer,
                      fontWeight: FontWeightManager.bold,
                      textColor: Color.fromRGBO(38, 38, 40, 1),
                      fontSize: FontSize.s20,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppSize.s10.h,),

              Expanded(
                  child: ListView.builder(
                    itemCount: trades.length,
                      itemBuilder: (context, index){
                        final tradeOnAd = trades[index];
                        return TradeOnMyAdItem(trade: tradeOnAd,);
                      }))



            ],
          )),
    );
  }
}
