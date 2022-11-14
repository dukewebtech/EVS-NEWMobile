import 'package:evs_pay_mobile/model/new_trade_model.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/view_models/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/navigation_utils.dart';
import '../resources/strings_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

class NewTradeItem extends StatelessWidget {
  final NewTradeData trade;
  const NewTradeItem({Key? key, required this.trade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    final auth = context.watch<AuthenticationProvider>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s4.r),
      child: InkWell(
        onTap: ()async{
          dashboardViewModel.changeTradeReference(trade.reference);
          context.read<DashboardViewModel2>().changeSelectedNewTrade(trade);
          final  isFetched = await context.read<DashboardViewModel2>().getTradeDetails(trade.reference);
          if(isFetched){
            print("Trade type: ${trade.type}");
            if(trade.type == "SELL"){
              if(trade.partner?.username == auth.userData.user?.username){
                openConfirmBuyTradeView(context);
              }else{
                openConfirmSellTradeView(context);
              }

            }else{
              if(trade.partner?.username == auth.userData.user?.username){
                openConfirmSellTradeView(context);
              }else{
                openConfirmBuyTradeView(context);
              }

            }

          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
          // height: AppSize.s96.h,
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
              SizedBox(height: AppSize.s12.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWithLineHeight(
                    text: "${trade.partner?.username == auth.userData.user?.username ? trade.user?.username : trade.partner?.username}",
                    fontWeight: FontWeightManager.bold,
                    textColor: ColorManager.blckColor,
                    fontSize: FontSize.s12,
                  ),

                  CustomTextWithLineHeight(
                    text: trade.type ?? "",
                    fontWeight: FontWeightManager.bold,
                    textColor: trade.type == "SELL" ? ColorManager.primaryColor : ColorManager.blackTxtColor,
                  ),
                ],
              ),

              SizedBox(height: AppSize.s8.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWithLineHeight(
                    text: trade.paymentMethod!.name?? "",
                    fontWeight: FontWeightManager.regular,
                    textColor: ColorManager.blckColor,
                    fontSize: FontSize.s12,
                  ),

                  CustomTextWithLineHeight(
                    text: "${moneyFormat.format(trade.amount)} ${trade.currency?.code}",
                    fontWeight: FontWeightManager.regular,
                    textColor: ColorManager.arrowColor,
                    fontSize: FontSize.s10,
                  ),
                ],
              ),
              SizedBox(height: AppSize.s4.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextWithLineHeight(
                    text: Jiffy(trade.createdAt).yMMMMEEEEdjm,
                    fontWeight: FontWeightManager.regular,
                    textColor: ColorManager.arrowColor,
                  ),

                ],
              ),

              SizedBox(height: AppSize.s10.h,),

              Row(
                children: [
                  Container(
                    // height: AppSize.s15.h,
                    // width: AppSize.s48.w,
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s22.w, vertical: AppSize.s3.h),
                    decoration:  BoxDecoration(
                        color: ColorManager.deepGreenColor,
                        borderRadius: BorderRadius.circular(AppSize.s2.r)
                    ),
                    alignment: Alignment.center,
                    child: CustomTextWithLineHeight(text: trade.status ?? "",
                      textColor: ColorManager.whiteColor, fontSize: FontSize.s6,),
                  )
                ],
              ),

              SizedBox(height: AppSize.s12.h,),

            ],
          ),
        ),
      ),
    );
  }

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
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
                          Navigator.pop(context);
                          // openViewTradeScreen(context);
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
                  height: AppSize.s60.h,
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
