import 'package:evs_pay_mobile/model/dashboard_trade_model.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../resources/navigation_utils.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../view_models/dashboard_view_model.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/re_usable_widgets.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class FilterTradeWidget extends StatelessWidget {
  const FilterTradeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tradeViewModel = context.watch<DashboardViewModel2>();
    if (tradeViewModel.filteredTrades.isEmpty) {
      if (tradeViewModel.loadingFilterTrade) {
        return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CupertinoActivityIndicator(),
            ));
      } else if (tradeViewModel.error) {
        return Center(
            child: errorDialog
              (context: context,
                size: 20, tradeViewModel: tradeViewModel)
        );
      }
    }
    return Expanded(
        child: RefreshIndicator(
          onRefresh: () async{
            print("Pulled to refresh");
          },
          child: ListView.builder(
              itemCount: tradeViewModel.filteredTrades.length + (tradeViewModel.isLastFilteredPage ? 0 : 1),
              itemBuilder: (context, index){
                if (index == tradeViewModel.filteredTrades.length - tradeViewModel.nextPageTrigger) {
                  print("Just something here");
                  if(tradeViewModel.filteredTradeModel!.links!.next != null){
                    print("In here to fetch again");
                    print("${tradeViewModel.filteredTradeModel!.links!.next}");
                    tradeViewModel.sellUrl = tradeViewModel.tradesModel!.links!.next?? '';

                    tradeViewModel.fetchFilteredTrades();
                  }else{
                    // print("Gotten to the end");
                  }

                }
                if (index == tradeViewModel.filteredTrades.length) {
                  if (tradeViewModel.error) {
                    return Center(
                        child: errorDialog(
                          context: context,
                            size: 15, tradeViewModel: tradeViewModel)
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
                final DashboardTradeData offer = tradeViewModel.filteredTrades[index];
                // final offer = displayOffers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.s12.w
                  ),
                  child: InkWell(
                    onTap: (){
                      tradeViewModel.changeSelectedDashboardTrade(offer);
                      if(offer.type == "SELL"){
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
                                    CustomTextWithLineHeight(text: offer.type == "SELL" ? "BUY" : "SELL",
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
  required double size, required DashboardViewModel2? tradeViewModel}){
  return SizedBox(
    // height: MediaQuery.of(context).size.width * 0.9,
    width: MediaQuery.of(context).size.width * 0.5,
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
          tradeViewModel!.fetchFilteredTrades();
        }, backgroundColor: ColorManager.primaryColor,
            textColor: ColorManager.whiteColor,
            title: "Retry"),
      ],
    ),
  );
  //   SizedBox(
  //   height: 180,
  //   width: 200,
  //   child:  Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Text('An error occurred when fetching the trades.',
  //         style: TextStyle(
  //             fontSize: size,
  //             fontWeight: FontWeight.w500,
  //             color: Colors.black
  //         ),
  //       ),
  //       const SizedBox(height: 10,),
  //       CustomElevatedButton(onTap: (){
  //
  //       }, backgroundColor: ColorManager.primaryColor,
  //           textColor: ColorManager.whiteColor,
  //           title: "Retry"),
  //     ],
  //   ),
  // );
}
