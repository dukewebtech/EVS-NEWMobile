import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/trade_app_bar.dart';
import 'package:evs_pay_mobile/widgets/trade_on_my_ad_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';


class ViewOfferView extends StatefulWidget {
  const ViewOfferView({Key? key}) : super(key: key);

  @override
  State<ViewOfferView> createState() => _ViewOfferViewState();
}

class _ViewOfferViewState extends State<ViewOfferView> {

  @override
  Widget build(BuildContext context) {
    final evsPayProvider = context.watch<EvsPayViewModel>();
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
                              text: evsPayProvider.selectedOffer.paymentMethod.name!,
                              fontWeight: FontWeightManager.bold,
                              textColor: ColorManager.blackTxtColor,
                            ),

                            CustomTextWithLineHeight(
                              text: evsPayProvider.selectedOffer.status == "ACTIVE" ? 'Active' : 'Disabled',
                              fontWeight: FontWeightManager.bold,
                              textColor: evsPayProvider.selectedOffer.status == "ACTIVE" ? ColorManager.lemonGreen :
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
                                  text:
                                  "${moneyFormat.format(evsPayProvider.selectedOffer.minAmount)} - "
                                      "${moneyFormat.format(evsPayProvider.selectedOffer.maxAmount)} "
                                      "${evsPayProvider.selectedOffer.currency!.code}",
                                  fontWeight: FontWeightManager.regular,
                                  textColor: ColorManager.arrowColor,
                                  fontSize: FontSize.s10,
                                ),
                              ],
                            ),

                            CustomTextWithLineHeight(
                              text: evsPayProvider.selectedOffer.type.toUpperCase(),
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
                              text: Jiffy(evsPayProvider.selectedOffer.createdAt).yMMMMEEEEdjm,
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
                  child: evsPayProvider.tradesOnOffer.tradesOnOffer!.isEmpty ?  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppSize.s96.h,
                        ),
                        Center(
                            child: SvgPicture.asset("assets/images/empty_state.svg")
                        ),
                        SizedBox(
                          height: AppSize.s49.h,
                        ),

                        const CustomText(text:
                        "No trades on offer yet",
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16,),
                        SizedBox(
                          height: AppSize.s8.h,
                        ),

                      ],
                    ),
                  ) :  ListView.builder(
                    itemCount: evsPayProvider.tradesOnOffer.tradesOnOffer?.length,
                      itemBuilder: (context, index){
                        final tradeOnAd = evsPayProvider.tradesOnOffer.tradesOnOffer![index];
                        return TradeOnMyAdItem(trade: tradeOnAd,);
                      }))



            ],
          )),
    );
  }
}
