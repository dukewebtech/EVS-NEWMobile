import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/view_models/dashboard_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../model/dashboard_trade_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/re_usable_widgets.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class BuyTradeWidget extends StatelessWidget {
  const BuyTradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    if (dashboardViewModel.buyTrades.isEmpty) {
      if (dashboardViewModel.loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (dashboardViewModel.error) {
        return Center(
            child: errorDialog(size: 20, dashboardViewModel: dashboardViewModel)
        );
      }
    }
    return Expanded(
        child: RefreshIndicator(
          onRefresh: () async{
            print("Pulled to refresh");
            dashboardViewModel.resetBuyTradePageNumber();
            await dashboardViewModel.fetchBuyTrades(isRefresh: true);
          },
          child: ListView.builder(
              itemCount: dashboardViewModel.buyTrades.length + (dashboardViewModel.isBuyTradeLastPage ? 0 : 1),
              itemBuilder: (context, index){
                if (index == dashboardViewModel.buyTrades.length - dashboardViewModel.nextPageTrigger) {
                  print("Just something here");
                  if(dashboardViewModel.buyTradesModel!.links!.next != null){
                    print("In here to fetch again");
                    print("${dashboardViewModel.buyTradesModel!.links!.next}");
                    dashboardViewModel.buyUrl = dashboardViewModel.buyTradesModel!.links!.next?? '';

                    dashboardViewModel.fetchBuyTrades();
                  }else{
                    // print("Gotten to the end");
                  }

                }
                if (index == dashboardViewModel.buyTrades.length) {
                  if (dashboardViewModel.error) {
                    return Center(
                        child: errorDialog(size: 15, dashboardViewModel: dashboardViewModel)
                    );
                  } else {
                    return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppSize.s300.h
                          ),
                          child: const CupertinoActivityIndicator(),
                        ));
                  }
                }
                final DashboardTradeData offer = dashboardViewModel.buyTrades[index];
                // final offer = displayOffers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s12.w
                  ),
                  child: InkWell(
                    onTap: (){
                      dashboardViewModel.setSelectedTrade(offer);
                      if(offer.type == "SELL"){
                        dashboardViewModel.getBtcRate();
                        openBuyTradeView(context);
                      }else{
                        openSellView(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(AppSize.s15.r),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: ColorManager.filterGreyColor
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextWithLineHeight(text: "${toBeginningOfSentenceCase(offer.user!.username!)}",
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.bold,
                                      textColor: ColorManager.blackTxtColor,
                                    ),
                                    CustomTextWithLineHeight(text: offer.paymentMethod!.name!,
                                      fontSize: FontSize.s10,
                                      fontWeight: FontWeightManager.regular,
                                      textColor: ColorManager.lightTextColor,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  CustomTextWithLineHeight(text: moneyFormat.format(offer.maxAmount),
                                    fontSize: FontSize.s14,
                                    fontWeight: FontWeightManager.bold,
                                    textColor: ColorManager.accentColor,
                                  ),
                                  CustomTextWithLineHeight(text: AppStrings.perUSD,
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    textColor: ColorManager.lightTextColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: AppSize.s15.h,),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextWithLineHeight(text:  "${moneyFormat.format(offer.minAmount!)} - ${moneyFormat.format(offer.maxAmount!)}",
                                  fontSize: FontSize.s10,
                                  fontWeight: FontWeightManager.regular,
                                  textColor: ColorManager.lightTextColor,
                                ),
                              ),
                              Container(
                                height: AppSize.s26.h,
                                width: AppSize.s96.w,
                                decoration: BoxDecoration(
                                    color: ColorManager.primaryColor,
                                    borderRadius: BorderRadius.circular(AppSize.s3.r)
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: AppSize.s31.w,),
                                    CustomTextWithLineHeight(text: offer.type == "SELL" ? AppStrings.buy : AppStrings.sell,
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.bold,
                                      textColor: ColorManager.blackTxtColor,
                                    ),
                                    SizedBox(width: AppSize.s5.w,),
                                    SvgPicture.asset(AppImages.btcIconSmallBlack)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}

Widget errorDialog({required double size, required DashboardViewModel2 dashboardViewModel}){
  return SizedBox(
    height: 180,
    width: 200,
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('An error occurred when fetching the trades.',
          style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
        ),
        const SizedBox(height: 10,),
        CustomElevatedButton(onTap: (){
        }, backgroundColor: ColorManager.primaryColor,
            textColor: ColorManager.whiteColor,
            title: "Retry"),
      ],
    ),
  );
}