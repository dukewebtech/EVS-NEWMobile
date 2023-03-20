import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/general_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
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
      // appBar: evsTradeAppBar(context, AppStrings.myOfferDetails,
      //     showActionButton: false, onTap: () {
      //   //  Create a new trade or ads
      // }),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s25.h,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_outlined)),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  'My Offer Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Lexend',
                    color: Color(0xff3C3C3C),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF4B731),
                  borderRadius: BorderRadius.circular(5),
                  image: const DecorationImage(
                      image: AssetImage("assets/images/shape.png"),
                      fit: BoxFit.cover),
                ),

                // color: const Color.fromRGBO(248, 248, 248, 1),s
                height: AppSize.s120.h,
                width: double.infinity,
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      top: 10,
                      left: 10,
                      child: CustomTextWithLineHeight(
                        fontSize: 16,
                        text: evsPayProvider.selectedOffer.paymentMethod.name!,
                        fontWeight: FontWeight.w800,
                        textColor: ColorManager.amountColor,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 6,
                      child: SizedBox(
                        height: evsPayProvider.selectedOffer.status == "ACTIVE"
                            ? 30
                            : 33,
                        width: evsPayProvider.selectedOffer.status == "ACTIVE"
                            ? 55
                            : 63,
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                          color: Colors.green,
                          child: Center(
                            child: CustomTextWithLineHeight(
                              fontSize: 12,
                              text: evsPayProvider.selectedOffer.status ==
                                      "ACTIVE"
                                  ? 'Active'
                                  : 'Disabled',
                              fontWeight: FontWeightManager.semiBold,
                              textColor: evsPayProvider.selectedOffer.status ==
                                      "ACTIVE"
                                  ? Colors.white
                                  : ColorManager.blackTxtColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 45,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomTextWithLineHeight(
                                text: "Limit: ",
                                fontWeight: FontWeightManager.medium,
                                textColor: Colors.grey.shade800,
                                fontSize: FontSize.s14,
                              ),
                              CustomTextWithLineHeight(
                                text:
                                    "${moneyFormat.format(evsPayProvider.selectedOffer.minAmount)} - "
                                    "${moneyFormat.format(evsPayProvider.selectedOffer.maxAmount)} "
                                    "${evsPayProvider.selectedOffer.currency!.code}",
                                fontWeight: FontWeightManager.medium,
                                textColor: Colors.grey.shade800,
                                fontSize: FontSize.s14,
                              ),
                            ],
                          ),
                          CustomTextWithLineHeight(
                            text:
                                evsPayProvider.selectedOffer.type.toUpperCase(),
                            fontWeight: FontWeightManager.bold,
                            textColor: ColorManager.blackTextColor,
                            fontSize: FontSize.s14,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 75,
                      left: 10,
                      right: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextWithLineHeight(
                            text: Jiffy(evsPayProvider.selectedOffer.createdAt)
                                .yMMMMEEEEdjm,
                            fontWeight: FontWeightManager.regular,
                            textColor: Colors.grey.shade800,
                          ),
                          InkWell(
                              onTap: () {
                                // show(context);
                              },
                              child: const Icon(Icons.more_vert_outlined)
                              // SvgPicture.asset(AppImages.myAdsMoreIcon),
                              )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// this is the previous design for the header "kaizen",
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(AppSize.s3.r),
            //         color: ColorManager.primaryColor),
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(
            //           horizontal: AppSize.s10.w, vertical: AppSize.s13.h),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               CustomTextWithLineHeight(
            //                 text:
            //                     evsPayProvider.selectedOffer.paymentMethod.name!,
            //                 fontWeight: FontWeightManager.bold,
            //                 textColor: ColorManager.blackTxtColor,
            //               ),
            //               CustomTextWithLineHeight(
            //                 text: evsPayProvider.selectedOffer.status == "ACTIVE"
            //                     ? 'Active'
            //                     : 'Disabled',
            //                 fontWeight: FontWeightManager.bold,
            //                 textColor:
            //                     evsPayProvider.selectedOffer.status == "ACTIVE"
            //                         ? ColorManager.lemonGreen
            //                         : ColorManager.blackTxtColor,
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: AppSize.s8.h,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 children: [
            //                   const CustomTextWithLineHeight(
            //                     text: "Limit:",
            //                     fontWeight: FontWeightManager.regular,
            //                     textColor: ColorManager.blackTxtColor,
            //                     fontSize: FontSize.s10,
            //                   ),
            //                   CustomTextWithLineHeight(
            //                     text:
            //                         "${moneyFormat.format(evsPayProvider.selectedOffer.minAmount)} - "
            //                         "${moneyFormat.format(evsPayProvider.selectedOffer.maxAmount)} "
            //                         "${evsPayProvider.selectedOffer.currency!.code}",
            //                     fontWeight: FontWeightManager.regular,
            //                     textColor: ColorManager.arrowColor,
            //                     fontSize: FontSize.s10,
            //                   ),
            //                 ],
            //               ),
            //               CustomTextWithLineHeight(
            //                 text: evsPayProvider.selectedOffer.type.toUpperCase(),
            //                 fontWeight: FontWeightManager.bold,
            //                 textColor: ColorManager.arrowColor,
            //                 fontSize: FontSize.s10,
            //               ),
            //             ],
            //           ),
            //           SizedBox(
            //             height: AppSize.s12.h,
            //           ),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               CustomTextWithLineHeight(
            //                 text: Jiffy(evsPayProvider.selectedOffer.createdAt)
            //                     .yMMMMEEEEdjm,
            //                 fontWeight: FontWeightManager.regular,
            //                 textColor: ColorManager.arrowColor,
            //               ),
            //               InkWell(
            //                 onTap: () {
            //                   // show(context);
            //                 },
            //                 child: SvgPicture.asset(AppImages.myAdsMoreIcon),
            //               )
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: AppSize.s30.w,
            ),
            Row(
              children: const [
                CustomTextWithLineHeight(
                  text: AppStrings.tradesForOffer,
                  fontWeight: FontWeight.w500,
                  textColor: Color(0xff3C3C3C),
                  fontSize: FontSize.s16,
                ),
              ],
            ),
            SizedBox(
              height: AppSize.s10.h,
            ),
            Expanded(
                child: evsPayProvider.tradesOnOffer.tradesOnOffer!.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppSize.s96.h,
                            ),
                            Center(
                                child: SvgPicture.asset(
                                    "assets/images/empty_state.svg")),
                            SizedBox(
                              height: AppSize.s49.h,
                            ),
                            const CustomText(
                              text: "No trades on offer yet",
                              textColor: ColorManager.blckColor,
                              fontSize: FontSize.s16,
                            ),
                            SizedBox(
                              height: AppSize.s8.h,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount:
                            evsPayProvider.tradesOnOffer.tradesOnOffer?.length,
                        itemBuilder: (context, index) {
                          final tradeOnAd = evsPayProvider
                              .tradesOnOffer.tradesOnOffer![index];
                          return TradeOnMyAdItem(
                            trade: tradeOnAd,
                          );
                        }))
          ],
        ),
      )),
    );
  }
}
