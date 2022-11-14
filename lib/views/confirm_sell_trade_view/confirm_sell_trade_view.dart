import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/widgets/expiry_date_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/re_usable_widgets.dart';

class ConfirmSellTradeScreen extends StatefulWidget {
  const ConfirmSellTradeScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmSellTradeScreen> createState() => _ConfirmSellTradeScreenState();
}

class _ConfirmSellTradeScreenState extends State<ConfirmSellTradeScreen> {

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.sellLowerCase,
          leadingTap: (){
            Navigator.pop(context);
          },
          isCenterAlign: true),

      body: SafeArea(child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: AppSize.s12.h,),
              Container(
                color: const Color.fromRGBO(249, 250, 244, 1),
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s24.w,
                    vertical: AppSize.s24.h),
                child: Column(
                  children: [
                    Container(
                      height: AppSize.s28.h,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          CustomTextWithLineHeight(
                            text: "Sell Bitcoin to  ${dashboardViewModel.singleTradeModel?.data?.partner?.username}",
                            textColor: ColorManager.blckColor,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,),
                        ],
                      ),
                    ),
                    Container(
                      height: AppSize.s28.h,
                      alignment: Alignment.center,
                      child: Row(
                        children: const [
                          CustomTextWithLineHeight(
                            text: "This transaction will last for",
                            textColor: ColorManager.blckColor,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeightManager.regular,),
                        ],
                      ),
                    ),

                    CountdownTimer(
                      endTime: dashboardViewModel.singleTradeModel!.data!.deadline!.millisecondsSinceEpoch,
                      widgetBuilder: (BuildContext context, CurrentRemainingTime? time) {
                        if (time == null) {
                          return Row(
                            children: const [
                              CustomTextWithLineHeight(
                                text: "Trade Time Elapsed",
                                textColor: ColorManager.blckColor,
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.bold,),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            ExpiryDateWidget(item: time.hours == null || time.hours! < 10 ? "0" : time.hours.toString()[0] ),
                            SizedBox(width: AppSize.s4.w,),
                            ExpiryDateWidget(item: time.hours == null || time.hours! < 1 ? "0" : time.hours!.toString()[0]),
                            SizedBox(width: AppSize.s3.w,),
                            SvgPicture.asset("assets/images/clock_time.svg"),
                            SizedBox(width: AppSize.s3.w,),
                            ExpiryDateWidget(item: time.min == null || time.min! < 10 ? "0" : time.min.toString()[0]),
                            SizedBox(width: AppSize.s4.w,),
                            ExpiryDateWidget(item: time.min == null || time.min! < 10 ? "0" : time.min!.toString()[1]),
                          ],
                        );
                      },
                    ),

                  ],
                ),
              ),


              SizedBox(height: AppSize.s19.h,),

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s24.w
                ),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        CustomTextWithLineHeight(
                          text: "Confirm Order info",
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.bold,),
                      ],
                    ),
                    SizedBox(height: AppSize.s8.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const CustomTextWithLineHeight(
                          text: "Amount",
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,),

                        CustomTextWithLineHeight(
                          text: "NGN${moneyFormat.format(double.parse(dashboardViewModel.singleTradeModel!.data!.amount!.toString()))}",
                          textColor: ColorManager.greenTextColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,)
                      ],
                    ),
                    SizedBox(height: AppSize.s4.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const CustomTextWithLineHeight(
                          text: "Rate",
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,),

                        CustomTextWithLineHeight(
                          text: "\$${dashboardViewModel.singleTradeModel!.data!.offer!.profitMargin}/\$",
                          textColor: ColorManager.greenTextColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,)
                      ],
                    ),
                    SizedBox(height: AppSize.s4.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const CustomTextWithLineHeight(
                          text: "Quantity",
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,),

                        CustomTextWithLineHeight(
                          text: "${dashboardViewModel.singleTradeModel!.data!.coinValue} BTC",
                          textColor: ColorManager.greenTextColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,)
                      ],
                    ),

                    SizedBox(height: AppSize.s4.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        const CustomTextWithLineHeight(
                          text: "Payment Status",
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,),

                        CustomTextWithLineHeight(
                          text: dashboardViewModel.singleTradeModel!.data!.confirmedAt == null ?'Pending' : 'Paid',
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s16,
                          fontWeight: FontWeightManager.medium,)
                      ],
                    ),

                    SizedBox(height: AppSize.s16.h,),

                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Padding(
                    padding: EdgeInsets.only(
                        left: AppSize.s24.w
                    ),
                    child: const CustomTextWithLineHeight(
                      text: "Trade Details",
                      textColor: ColorManager.blackTxtColor,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,),
                  ),


                  InkWell(
                    onTap: (){
                      openChatScreen(context);
                    },
                    child: Container(
                      height: AppSize.s48.h,
                      width: AppSize.s128.w,
                      decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                AppSize.s5.r
                            ),
                            bottomLeft: Radius.circular(
                                AppSize.s5.r
                            ),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppImages.chatIcon),
                          SizedBox(width: AppSize.s12.w,),
                          const CustomTextWithLineHeight(
                            text: "Chat",
                            textColor: ColorManager.blackTxtColor,
                            fontSize: FontSize.s16,
                            fontWeight: FontWeightManager.bold,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppSize.s5.h,),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s21.w,
                    vertical: AppSize.s10.h
                ),
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(217, 217, 217, 1),
                    borderRadius: BorderRadius.circular(AppSize.s10.r)
                ),
                margin: EdgeInsets.symmetric(horizontal: AppSize.s24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextNoOverFlow(text: "${dashboardViewModel.singleTradeModel!.data!.offer!.terms}",
                      fontSize: FontSize.s15,
                      textColor: ColorManager.blckColor,),

                    SizedBox(height: AppSize.s20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CustomTextNoOverFlow(text: "Call Contact:",
                            fontSize: FontSize.s15,
                            textColor: ColorManager.blckColor),
                        SizedBox(width: AppSize.s20.w,),
                        CustomTextNoOverFlow(text: "${dashboardViewModel.singleTradeModel!.data!.partner!.phone!}",
                            fontSize: FontSize.s15,
                            textColor: ColorManager.blckColor),
                      ],
                    ),


                  ],
                ),
              ),

              SizedBox(height: AppSize.s39.h,),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s24.w
                ),
                child: RichText(
                  text: TextSpan(
                    text: "Only click  ",
                    style: getRichTextStyle(
                        fontSize: FontSize.s15,
                        textColor: ColorManager.greyColor,
                        fontWeight: FontWeightManager.medium),
                    children: <TextSpan>[
                      TextSpan(text: '“Release Coin” ', style:
                      getRichTextStyle(
                          fontSize: FontSize.s15,
                          textColor: ColorManager.blackColor,
                          fontWeight: FontWeightManager.medium)),
                      TextSpan(text: "button after you have confirmed payment from buyer", style:
                      getRichTextStyle(
                          fontSize: FontSize.s15,
                          textColor: ColorManager.greyColor,
                          fontWeight: FontWeightManager.medium)
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppSize.s50.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s50.w),
                child: Consumer<DashboardViewModel2>(
                    builder: (ctx, dashboardViewModel, child) {
                      WidgetsBinding.instance.
                      addPostFrameCallback((_) {
                        if (dashboardViewModel.resMessage != '') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.info(
                              message: dashboardViewModel.resMessage,
                              backgroundColor:
                              dashboardViewModel.isSuccessful ? ColorManager.deepGreenColor : ColorManager.orangeColor,
                            ),
                          );
                          ///Clear the response message to avoid duplicate
                          dashboardViewModel.clear();
                        }
                      });
                    return dashboardViewModel.loading ? const Center(child: CupertinoActivityIndicator()) : CustomElevatedButton(onTap: ()async{
                      final action = dashboardViewModel.singleTradeModel!.data!.status == "CONFIRMED" ? "complete" : dashboardViewModel.singleTradeModel!.data!.status == "COMPLETED" ? "dispute" : "comfirm";
                      final isConfirmed = await dashboardViewModel.releaseCoin(
                          dashboardViewModel.singleTradeModel!.data!.reference,
                        action

                      );

                      if(isConfirmed){
                        dashboardViewModel.getTradeDetails(dashboardViewModel.singleTradeModel!.data!.reference);
                      }
                      print("I have paid here $isConfirmed");

                    },
                        backgroundColor: ColorManager.primaryColor,
                        textColor: ColorManager.blackTxtColor,
                        title: dashboardViewModel.singleTradeModel!.data!.status == "CONFIRMED" ? "Release Coin" : dashboardViewModel.singleTradeModel!.data!.status == "COMPLETED" ? "Dispute Trade" : "Release Coin");
                  }
                ),
              ),

              SizedBox(height: AppSize.s31.h,),

            ],
          )
      )),
    );
    // return Scaffold(
    //   appBar: evsPayCustomAppBar(
    //       context, AppStrings.buyLowerCase,
    //       leadingTap: (){
    //         Navigator.pop(context);
    //       },
    //       isCenterAlign: true),
    //
    //   body: SafeArea(child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         SizedBox(height: AppSize.s12.h,),
    //         Container(
    //           color: const Color.fromRGBO(249, 250, 244, 1),
    //           padding: EdgeInsets.symmetric(
    //               horizontal: AppSize.s24.w,
    //           vertical: AppSize.s24.h),
    //           child: Column(
    //             children: [
    //               Container(
    //                 height: AppSize.s28.h,
    //                 alignment: Alignment.center,
    //                 child: Row(
    //                   children: [
    //                     CustomTextWithLineHeight(
    //                       text: "Buy Bitcoin from  ${dashboardViewModel.selectedTrade?.partner?.firstName}",
    //                       textColor: ColorManager.blckColor,
    //                       fontSize: FontSize.s16,
    //                       fontWeight: FontWeightManager.bold,),
    //                   ],
    //                 ),
    //               ),
    //               Container(
    //                 height: AppSize.s28.h,
    //                 alignment: Alignment.center,
    //                 child: Row(
    //                   children: const [
    //                     CustomTextWithLineHeight(
    //                       text: "This transaction will last for",
    //                       textColor: ColorManager.blckColor,
    //                       fontSize: FontSize.s14,
    //                       fontWeight: FontWeightManager.regular,),
    //                   ],
    //                 ),
    //               ),
    //
    //               Row(
    //                 children: [
    //                   ExpiryDateWidget(item: dashboardViewModel.selectedTrade!.deadline!.hour < 10 ? "0" : dashboardViewModel.selectedTrade!.deadline!.hour.toString()[0] ),
    //                   SizedBox(width: AppSize.s4.w,),
    //                   ExpiryDateWidget(item: dashboardViewModel.selectedTrade!.deadline!.hour < 10 ? dashboardViewModel.selectedTrade!.deadline!.hour.toString()[0] : dashboardViewModel.selectedTrade!.deadline!.hour.toString()[1]),
    //                   SizedBox(width: AppSize.s3.w,),
    //                   SvgPicture.asset("assets/images/clock_time.svg"),
    //                   SizedBox(width: AppSize.s3.w,),
    //                   ExpiryDateWidget(item: dashboardViewModel.selectedTrade!.deadline!.minute < 10 ? "0" : dashboardViewModel.selectedTrade!.deadline!.minute.toString()[0]),
    //                   SizedBox(width: AppSize.s4.w,),
    //                   ExpiryDateWidget(item: dashboardViewModel.selectedTrade!.deadline!.minute < 10 ? dashboardViewModel.selectedTrade!.deadline!.minute.toString()[0] : dashboardViewModel.selectedTrade!.deadline!.minute.toString()[1]),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //
    //         SizedBox(height: AppSize.s19.h,),
    //
    //         Padding(
    //             padding: EdgeInsets.symmetric(
    //           horizontal: AppSize.s24.w
    //         ),
    //           child: Column(
    //             children: [
    //               Row(
    //                 children: const [
    //                   CustomTextWithLineHeight(
    //                     text: "Confirm Order info",
    //                     textColor: ColorManager.blckColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.bold,),
    //                 ],
    //               ),
    //               SizedBox(height: AppSize.s8.h,),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children:  [
    //                   const CustomTextWithLineHeight(
    //                     text: "Amount",
    //                     textColor: ColorManager.arrowColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,),
    //
    //                   CustomTextWithLineHeight(
    //                     text: "NGN${moneyFormat.format(double.parse(dashboardViewModel.selectedTrade!.amount!.toString()))}",
    //                     textColor: ColorManager.greenTextColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,)
    //                 ],
    //               ),
    //               SizedBox(height: AppSize.s4.h,),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children:  [
    //                   const CustomTextWithLineHeight(
    //                     text: "Rate",
    //                     textColor: ColorManager.arrowColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,),
    //
    //                   CustomTextWithLineHeight(
    //                     text: "\$${dashboardViewModel.selectedTrade!.offer!.profitMargin}/\$",
    //                     textColor: ColorManager.greenTextColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,)
    //                 ],
    //               ),
    //               SizedBox(height: AppSize.s4.h,),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children:  [
    //                   const CustomTextWithLineHeight(
    //                     text: "Quantity",
    //                     textColor: ColorManager.arrowColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,),
    //
    //                   CustomTextWithLineHeight(
    //                     text: "${dashboardViewModel.selectedTrade!.coinValue} BTC",
    //                     textColor: ColorManager.greenTextColor,
    //                     fontSize: FontSize.s16,
    //                     fontWeight: FontWeightManager.medium,)
    //                 ],
    //               ),
    //
    //               SizedBox(height: AppSize.s16.h,),
    //
    //             ],
    //           ),
    //         ),
    //
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children:  [
    //             Padding(
    //               padding: EdgeInsets.only(
    //                 left: AppSize.s24.w
    //               ),
    //               child: const CustomTextWithLineHeight(
    //                 text: "Trade Details",
    //                 textColor: ColorManager.blackTxtColor,
    //                 fontSize: FontSize.s16,
    //                 fontWeight: FontWeightManager.bold,),
    //             ),
    //
    //
    //             InkWell(
    //               onTap: (){
    //                 openChatScreen(context);
    //               },
    //               child: Container(
    //                 height: AppSize.s48.h,
    //                 width: AppSize.s128.w,
    //                 decoration: BoxDecoration(
    //                     color: ColorManager.primaryColor,
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(
    //                       AppSize.s5.r
    //                     ),
    //                     bottomLeft: Radius.circular(
    //                         AppSize.s5.r
    //                     ),
    //                   )
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     SvgPicture.asset(AppImages.chatIcon),
    //                     SizedBox(width: AppSize.s12.w,),
    //                     const CustomTextWithLineHeight(
    //                       text: "Chat",
    //                       textColor: ColorManager.blackTxtColor,
    //                       fontSize: FontSize.s16,
    //                       fontWeight: FontWeightManager.bold,)
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //
    //         SizedBox(height: AppSize.s5.h,),
    //
    //         Container(
    //           width: double.infinity,
    //           padding: EdgeInsets.symmetric(
    //             horizontal: AppSize.s21.w,
    //             vertical: AppSize.s10.h
    //           ),
    //           decoration: BoxDecoration(
    //             color: const Color.fromRGBO(217, 217, 217, 1),
    //             borderRadius: BorderRadius.circular(AppSize.s10.r)
    //           ),
    //           margin: EdgeInsets.symmetric(horizontal: AppSize.s24.w),
    //           child: Column(
    //             children: [
    //               CustomTextNoOverFlow(text: "${dashboardViewModel.selectedTrade!.offer!.terms}",
    //               fontSize: FontSize.s15,
    //               textColor: ColorManager.blckColor,),
    //
    //               SizedBox(height: AppSize.s20.h,),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 children: [
    //                   const CustomTextNoOverFlow(text: "Call Contact:",
    //                     fontSize: FontSize.s15,
    //                       textColor: ColorManager.blckColor),
    //                   SizedBox(width: AppSize.s20.w,),
    //                   CustomTextNoOverFlow(text: "${dashboardViewModel.selectedTrade?.partner!.phone!}",
    //                       fontSize: FontSize.s15,
    //                       textColor: ColorManager.blckColor),
    //                 ],
    //               ),
    //
    //
    //             ],
    //           ),
    //         ),
    //
    //         SizedBox(height: AppSize.s39.h,),
    //
    //         Padding(
    //           padding: EdgeInsets.symmetric(
    //             horizontal: AppSize.s24.w
    //           ),
    //           child: RichText(
    //             text: TextSpan(
    //               text: "After payment click  ",
    //               style: getRichTextStyle(
    //                   fontSize: FontSize.s15,
    //                   textColor: ColorManager.greyColor,
    //                   fontWeight: FontWeightManager.medium),
    //               children: <TextSpan>[
    //                 TextSpan(text: '“ i have paid” ', style:
    //                 getRichTextStyle(
    //                     fontSize: FontSize.s15,
    //                     textColor: ColorManager.blackColor,
    //                     fontWeight: FontWeightManager.medium)),
    //                 TextSpan(text: "button to notify seller", style:
    //                 getRichTextStyle(
    //                     fontSize: FontSize.s15,
    //                     textColor: ColorManager.greyColor,
    //                     fontWeight: FontWeightManager.medium)
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //
    //         SizedBox(height: AppSize.s50.h,),
    //
    //         Padding(
    //           padding: EdgeInsets.symmetric(horizontal: AppSize.s50.w),
    //           child: CustomElevatedButton(onTap: ()async{
    //             final isConfirmed = await dashboardViewModel.iHavePaidTrade(dashboardViewModel.selectedTrade?.reference);
    //             print("I have paid $isConfirmed");
    //
    //           },
    //               backgroundColor: ColorManager.primaryColor,
    //               textColor: ColorManager.blackTxtColor,
    //               title: "I have Paid"),
    //         ),
    //
    //         SizedBox(height: AppSize.s31.h,),
    //
    //       ],
    //     )
    //   )),
    // );
  }
}
