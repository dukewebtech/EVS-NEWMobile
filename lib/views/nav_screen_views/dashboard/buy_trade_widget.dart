import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
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
    final authProvider = context.watch<AuthenticationProvider>();
    if (dashboardViewModel.buyTrades.isEmpty) {
      if (dashboardViewModel.loading) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ));
      } else if (dashboardViewModel.error) {
        return Center(
            child: errorDialog(context: context,size: 20, dashboardViewModel: dashboardViewModel)
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
                        child: errorDialog(context: context, size: 15, dashboardViewModel: dashboardViewModel)
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
                      dashboardViewModel.changeSelectedDashboardTrade(offer);
                      if(!authProvider.userData.user!.emailVerified! || !authProvider.userData.user!.phoneVerified! ||
                          !authProvider.userData.user!.homeVerified! || !authProvider.userData.user!.idCardVerified! ||
                          authProvider.userData.user!.photo == null){
                        openVerifyAccountToTradeView(context);
                      }else{
                        if(offer.type == "SELL"){
                          dashboardViewModel.getBtcRate();
                          openBuyTradeView(context);
                        }else{
                          openSellView(context);
                        }
                      }

                    },
                    child: Container(
                      ///the container below is the new design widget and i have passed the logic into you, replace with the container above.
                      // Container(
                      //   // padding: EdgeInsets.only(top: 10 ),
                      //   decoration: BoxDecoration(
                      //     // color: Colors.yellow ,
                      //     // color: Color(0xfff6f6f6),
                      //       borderRadius: BorderRadius.circular(12)
                      //   ),
                      //   height: 109,
                      //   width: double.infinity,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children:  [
                      //           Text("${toBeginningOfSentenceCase(offer.user!.username!)}",style: const TextStyle(
                      //             fontSize: 17,
                      //             fontWeight:FontWeight.w500 ,
                      //             fontFamily: 'Lexend',
                      //             color: Color(0xff000000),
                      //
                      //
                      //           ),),
                      //           Text(moneyFormat.format(offer.maxAmount),style: const TextStyle(
                      //             fontSize: 17,
                      //             fontWeight:FontWeight.w500 ,
                      //             fontFamily: 'Lexend',
                      //             color: Color(0xff000000),
                      //
                      //
                      //           ),),
                      //
                      //
                      //         ],
                      //       ),
                      //       const SizedBox(height: 5,),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text("${toBeginningOfSentenceCase(offer.user!.username!)}",style: const TextStyle(
                      //             fontSize: 14,
                      //             fontWeight:FontWeight.w400 ,
                      //             fontFamily: 'Lexend',
                      //             color: Color(0xff8e8e8e),
                      //
                      //
                      //           ),),
                      //           const Text('18%',style: TextStyle(
                      //             fontSize: 14,
                      //             fontWeight:FontWeight.w400 ,
                      //             fontFamily: 'Lexend',
                      //             color: Color(0xff8e8e8e),
                      //
                      //
                      //           ),),
                      //
                      //
                      //         ],
                      //       ),
                      //       const SizedBox(height: 5,),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children:  [
                      //            Text("${moneyFormat.format(offer.minAmount!)} - ${moneyFormat.format(offer.maxAmount)}",style: const TextStyle(
                      //             fontSize: 14,
                      //             fontWeight:FontWeight.w400 ,
                      //             fontFamily: 'Lexend',
                      //             color: Color(0xff8e8e8e),
                      //
                      //
                      //           ),),
                      //           SizedBox(
                      //             height: MediaQuery.of(context).size.height * 0.041,
                      //             width: MediaQuery.of(context).size.width * 0.2,
                      //
                      //             child: ElevatedButton(
                      //
                      //               style: ElevatedButton.styleFrom(
                      //                 elevation: 1,
                      //
                      //                 backgroundColor:  const Color(0xffF4B731),
                      //               ),
                      //               onPressed: (){}, child:const FittedBox(
                      //               child: Text('Sell',style: TextStyle(
                      //                 fontSize: 14,
                      //                 fontWeight:FontWeight.w400 ,
                      //                 fontFamily: 'Lexend',
                      //                 color: Color(0xff303030),
                      //
                      //
                      //               ),),
                      //             ),
                      //             ),
                      //           ),
                      //
                      //
                      //         ],
                      //       ),
                      //       const SizedBox(height: 5,),
                      //
                      //       const Divider(
                      //         thickness: 1.5,
                      //       ),
                      //       const SizedBox(height: 5,),
                      //
                      //     ],
                      //   ),
                      // ),
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

Widget errorDialog({
  required BuildContext context,
  required double size, required DashboardViewModel2 dashboardViewModel}){
  return SizedBox(
    // height: MediaQuery.of(context).size.width * 0.9,
    width: MediaQuery.of(context).size.width * 0.9,
    child:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         const CustomTextWithLineHeight(
           text: 'An error occurred when fetching the trades.',
        textColor: Colors.black, fontWeight: FontWeightManager.medium,
        fontSize: FontSize.s18,
         alignCenter: true,),

        const SizedBox(height: 10,),
        CustomElevatedButton(onTap: (){
          dashboardViewModel.fetchBuyTrades(isRefresh: true);
        }, backgroundColor: ColorManager.primaryColor,
            textColor: ColorManager.whiteColor,
            title: "Retry"),
      ],
    ),
  );
}
