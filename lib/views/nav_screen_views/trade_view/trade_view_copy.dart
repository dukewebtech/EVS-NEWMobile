import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/my_ads_future_builder_widget.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/widgets/trades_widget.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../../view_models/general_view_model.dart';

class TradeViewCopy extends StatefulWidget {
  const TradeViewCopy({Key? key}) : super(key: key);

  @override
  State<TradeViewCopy> createState() => _TradeViewCopyState();
}

class _TradeViewCopyState extends State<TradeViewCopy> {
  bool isMyAds = true;
  var changeAll = 0;

  @override
  void initState() {
    super.initState();
    changeAll = 0;
  }

  @override
  Widget build(BuildContext context) {
    final evsPayViewModel = context.watch<EvsPayViewModel>();
    final authProvider = context.watch<AuthenticationProvider>();

    List<Map<String, dynamic>> btnList = [
      {
        "title": "My Ads",
        "isClicked": false,
        "isCone": false,
      },
      {
        "title": "Trades",
        "isClicked": false,
        "isCone": false,
      },
      {
        "title": "pro",
        "isClicked": false,
        "isCone": true,

      }
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Iconsax.transaction_minus,
          color: Colors.black,
        ),
        elevation: 2.5,
        backgroundColor: ColorManager.primaryColor,
        onPressed: () {
          if (!authProvider.userData.user!.emailVerified! ||
              !authProvider.userData.user!.phoneVerified! ||
              !authProvider.userData.user!.homeVerified! ||
              !authProvider.userData.user!.idCardVerified! ||
              authProvider.userData.user!.photo == null) {
            openVerifyAccountToTradeView(context);
          } else {
            evsPayViewModel.getPaymentMethods(context: context);
            openCreateOfferScreen(context);
          }
        },
      ),
      // appBar: evsTradeAppBar(context, AppStrings.trades, onTap: () async {
      //   if (!authProvider.userData.user!.emailVerified! ||
      //       !authProvider.userData.user!.phoneVerified! ||
      //       !authProvider.userData.user!.homeVerified! ||
      //       !authProvider.userData.user!.idCardVerified! ||
      //       authProvider.userData.user!.photo == null) {
      //     openVerifyAccountToTradeView(context);
      //   } else {
      //     evsPayViewModel.getPaymentMethods(context: context);
      //     openCreateOfferScreen(context);
      //   }
      // }),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 24, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trades',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                fontFamily: 'Lexend',
                color: Color(0xff3C3C3C),
              ),
            ),

            ///this is for my ads
            // IconButton(
            //     onPressed: () {
            //       show(context);
            //     },
            //     icon: const Icon(Icons.add)),

            ///this is for trades

            const Icon(Icons.info_outline),
            IconButton(
                onPressed: () {
                  // changeAll == 0 ? show(context) : showTradeDialog(context);
                  if (changeAll == 0) show(context);
                  if (changeAll == 1) showTradeDialog(context);
                },
                icon: const Icon(Icons.more_horiz_rounded)),
            SizedBox(
              height: AppSize.s18.h,
            ),

            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: btnList.length,
                  itemBuilder: (context, index) {
                    var title = btnList[index]['title'];
                    // var icon = btnList[index]['isCone'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          changeAll = index;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: 140,
                        color: const Color(0xffEFEFEF),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut,
                          width: 100,
                          margin: const EdgeInsets.only(
                              left: 5, right: 5, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: changeAll == index
                                ? const Color(0xffF4B731)
                                : const Color(0xffEFEFEF),
                            borderRadius: changeAll == index
                                ? BorderRadius.circular(6)
                                : BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                 title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'Lexend',
                                  color: Color(0xff000000),
                                ),
                                // btnList[index]["title"],
                              ),
                              // if (title == 'Pro') const Icon(Icons.star)

                              // GestureDetector(
                              //   onTap: () {
                              //     if (index == 1) {
                              //       setState(() {
                              //         print('This is one');
                              //       });
                              //     } else if (index == 2) {
                              //       setState(() {
                              //         print('This is Two');
                              //       });
                              //     }
                              //   },
                              //   child: Visibility(
                              //     visible: index == 2,
                              //     child: const Icon(Icons.star),
                              //   ),
                              // )
                            ],
                          )),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: AppSize.s18.h,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //         child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(left: AppSize.s54.w),
            //               child: InkWell(
            //                 onTap: () {
            //                   setState(() {
            //                     isMyAds = true;
            //                   });
            //                 },
            //                 child: const CustomTextWithLineHeight(
            //                   text: AppStrings.myAds,
            //                   fontSize: FontSize.s15,
            //                   fontWeight: FontWeightManager.medium,
            //                   textColor: ColorManager.blckColor,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: AppSize.s10.h,
            //             ),
            //             InkWell(
            //                 onTap: () {
            //                   if (isMyAds) {
            //                     show(context);
            //                   }
            //                 },
            //                 child: Container(
            //                     width: AppSize.s30.w,
            //                     height: AppSize.s10.h,
            //                     alignment: Alignment.center,
            //                     child:
            //                         SvgPicture.asset(AppImages.dropDownIcon)))
            //           ],
            //         ),
            //         SizedBox(
            //           height: AppSize.s8.h,
            //         ),
            //         if (isMyAds)
            //           Container(
            //             height: AppSize.s5.h,
            //             decoration: const BoxDecoration(
            //                 color: ColorManager.primaryColor),
            //           )
            //       ],
            //     )),
            //     Expanded(
            //         child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Padding(
            //               padding: EdgeInsets.only(left: AppSize.s54.w),
            //               child: InkWell(
            //                 onTap: () {
            //                   setState(() {
            //                     isMyAds = false;
            //                   });
            //                 },
            //                 child: const CustomTextWithLineHeight(
            //                   text: AppStrings.trades,
            //                   fontSize: FontSize.s15,
            //                   fontWeight: FontWeightManager.medium,
            //                   textColor: ColorManager.blckColor,
            //                 ),
            //               ),
            //             ),
            //             SizedBox(
            //               width: AppSize.s10.h,
            //             ),
            //             InkWell(
            //                 onTap: () {
            //                   if (!isMyAds) {
            //                     showTradeDialog(context);
            //                   }
            //                 },
            //                 child: Container(
            //                     width: AppSize.s30.w,
            //                     height: AppSize.s10.h,
            //                     alignment: Alignment.center,
            //                     child:
            //                         SvgPicture.asset(AppImages.dropDownIcon)))
            //           ],
            //         ),
            //         SizedBox(
            //           height: AppSize.s8.h,
            //         ),
            //         if (!isMyAds)
            //           Container(
            //             height: AppSize.s5.h,
            //             decoration: const BoxDecoration(
            //                 color: ColorManager.primaryColor),
            //           )
            //       ],
            //     )),
            //   ],
            // ),

            // if (isMyAds)
            //   evsPayViewModel.isLoading
            //       ? Container()
            //       : const MyAdsFutureBuilderWidget(),
            if (changeAll == 0)
              evsPayViewModel.isLoading
                  ? Container()
                  : const MyAdsFutureBuilderWidget(),

            // if (!isMyAds)
            //   evsPayViewModel.isLoading ? Container() : const TradesWidget(),

            if (changeAll == 1)
              evsPayViewModel.isLoading ? Container() : const TradesWidget(),

            if (changeAll == 2)
              SizedBox(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    if (changeAll == 0) {
                      setState(() {
                        print('ovo');
                      });
                    } else {
                      print('2');
                    }
                  },
                ),
              )
          ],
        ),
      )),
    );
  }

  void show(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: AppSize.s350.h,
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
                  // height: AppSize.s117.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s15.r)),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.enableTrade,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.disableTrade,
                          textColor: ColorManager.redColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: AppSize.s13.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s31.w),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // height: AppSize.s60.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s5.r)),
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

  void showTradeDialog(BuildContext context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: AppSize.s510.h,
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
                  // height: AppSize.s117.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s15.r)),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.active,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.completed,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.confirmed,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.disputed,
                          textColor: ColorManager.redColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s20.h,
                      ),
                      SvgPicture.asset(AppImages.tradeOptionsDivider),
                      SizedBox(
                        height: AppSize.s22.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: CustomTextWithLineHeight(
                          text: AppStrings.cancelled,
                          textColor: ColorManager.redColor,
                          fontSize: FontSize.s16.sp,
                          fontWeight: FontWeightManager.medium,
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: AppSize.s13.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s31.w),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  // height: AppSize.s60.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: AppSize.s21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(AppSize.s5.r)),
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


//  Container(
//                       padding: const EdgeInsets.only(
//                         top: 6,
//                         left: 5,
//                         right: 5,
//                       ),
//                       decoration: BoxDecoration(
//                           // color: Colors.yellow ,
//                           // color: Color(0xfff6f6f6),
//                           borderRadius: BorderRadius.circular(12)),
//                       height: 105,
//                       width: double.infinity,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "${toBeginningOfSentenceCase(offer.user!.username!)}",
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Lexend',
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                               Text(
//                                 moneyFormat.format(offer.maxAmount),
//                                 style: const TextStyle(
//                                   fontSize: 15,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Lexend',
//                                   color: Color(0xff000000),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 offer.paymentMethod!.name!,
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Lexend',
//                                   color: Color(0xff8e8e8e),
//                                 ),
//                               ),
//                               const Text(
//                                 '18%',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Lexend',
//                                   color: Color(0xff8e8e8e),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "NGN ${moneyFormat.format(offer.minAmount!)} - ${moneyFormat.format(offer.maxAmount)}",
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w400,
//                                   fontFamily: 'Lexend',
//                                   color: Color(0xff8e8e8e),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height:
//                                     MediaQuery.of(context).size.height * 0.041,
//                                 width: MediaQuery.of(context).size.width * 0.2,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     elevation: 1,
//                                     backgroundColor: const Color(0xffF4B731),
//                                   ),
//                                   onPressed: () {
//                                     openSellView(context);
//                                   },
//                                   child: const FittedBox(
//                                     child: Text(
//                                       'Sell',
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w400,
//                                         fontFamily: 'Lexend',
//                                         color: Color(0xff303030),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           const Divider(
//                             thickness: 1.5,
//                           ),
//                         ],
//                       ),
//                     ),
