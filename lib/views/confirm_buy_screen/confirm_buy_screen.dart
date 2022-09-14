import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/widgets/expiry_date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/styles_manager.dart';
import '../../resources/value_manager.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/re_usable_widgets.dart';

class ConfirmBuyScreen extends StatefulWidget {
  const ConfirmBuyScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmBuyScreen> createState() => _ConfirmBuyScreenState();
}

class _ConfirmBuyScreenState extends State<ConfirmBuyScreen> {

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.buyLowerCase,
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
                          text: "Buy Bitcoin from ${dashboardViewModel.selectedTrade.user!.firstName}",
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

                  Row(
                    children: [
                      ExpiryDateWidget(item: dashboardViewModel.initTradeData.data!.deadline!.hour < 10 ? "0" : dashboardViewModel.initTradeData.data!.deadline!.hour.toString()[0] ),
                      SizedBox(width: AppSize.s4.w,),
                      ExpiryDateWidget(item: dashboardViewModel.initTradeData.data!.deadline!.hour < 10 ? dashboardViewModel.initTradeData.data!.deadline!.hour.toString()[0] : dashboardViewModel.initTradeData.data!.deadline!.hour.toString()[1]),
                      SizedBox(width: AppSize.s3.w,),
                      SvgPicture.asset("assets/images/clock_time.svg"),
                      SizedBox(width: AppSize.s3.w,),
                      ExpiryDateWidget(item: dashboardViewModel.initTradeData.data!.deadline!.minute < 10 ? "0" : dashboardViewModel.initTradeData.data!.deadline!.minute.toString()[0]),
                      SizedBox(width: AppSize.s4.w,),
                      ExpiryDateWidget(item: dashboardViewModel.initTradeData.data!.deadline!.minute < 10 ? dashboardViewModel.initTradeData.data!.deadline!.minute.toString()[0] : dashboardViewModel.initTradeData.data!.deadline!.minute.toString()[1]),
                    ],
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
                        text: "NGN${moneyFormat.format(double.parse(dashboardViewModel.initTradeData.data!.amount!))}",
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
                        text: "\$${dashboardViewModel.initTradeData.data!.offer!.profitMargin}/\$",
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
                        text: "${dashboardViewModel.initTradeData.data!.coinValue} BTC",
                        textColor: ColorManager.greenTextColor,
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
                children: [
                  CustomTextNoOverFlow(text: dashboardViewModel.selectedTrade.terms,
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
                      CustomTextNoOverFlow(text: "${dashboardViewModel.initTradeData.data!.partner!.phone!}",
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
                  text: "After payment click  ",
                  style: getRichTextStyle(
                      fontSize: FontSize.s15,
                      textColor: ColorManager.greyColor,
                      fontWeight: FontWeightManager.medium),
                  children: <TextSpan>[
                    TextSpan(text: '“ i have paid” ', style:
                    getRichTextStyle(
                        fontSize: FontSize.s15,
                        textColor: ColorManager.blackColor,
                        fontWeight: FontWeightManager.medium)),
                    TextSpan(text: "button to notify seller", style:
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
              child: CustomElevatedButton(onTap: ()async{
                final isConfirmed = await dashboardViewModel.iHavePaidTrade(dashboardViewModel.initTradeData.data!.reference);
                print("I have paid $isConfirmed");

              },
                  backgroundColor: ColorManager.primaryColor,
                  textColor: ColorManager.blackTxtColor,
                  title: "I have Paid"),
            ),

            SizedBox(height: AppSize.s31.h,),

          ],
        )
      )),
    );
  }
}
