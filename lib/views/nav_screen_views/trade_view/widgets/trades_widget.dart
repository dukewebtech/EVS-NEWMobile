import 'package:evs_pay_mobile/model/new_trade_model.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/trade_view_model.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../resources/font_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../widgets/app_texts/custom_text.dart';
import '../../../../widgets/new_trade_item.dart';

class TradesWidget extends StatefulWidget {
  final String? offerType;
  const TradesWidget({this.offerType = "allTrades", Key? key})
      : super(key: key);

  @override
  State<TradesWidget> createState() => _TradesWidgetState();
}

class _TradesWidgetState extends State<TradesWidget> {
  @override
  void initState() {
    super.initState();
    //   tradeViewModel.newFetchTrades(); // Call the function to populate the initial data
    // _newTradesStreamController.addStream(tradeViewModel.newTradesStream);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final tradesViewModel =
          Provider.of<TradeViewModel>(context, listen: false);
      tradesViewModel.pageNumber = 0;
      tradesViewModel.newFetchTrades();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tradesViewModel = Provider.of<TradeViewModel>(context, listen: false);
    // tradesViewModel.pageNumber = 0;
    // tradesViewModel.newFetchTrades();
    var tradeViewModel = context.watch<TradeViewModel>();

    List trades = tradeViewModel.newTrades;

    /// i tried using a consumer but the list is not still building automaticaly.

    // return Consumer<TradeViewModel>(

    //   builder: (context, data, index) {
    //   List trades = data.newTrades;

    //   trades = trades.where((trade) {
    //     Map status = <String, List>{
    //       "allTrades": ['ACTIVE', 'CONFIRMED', 'CANCELLED'],
    //       "active": ['ACTIVE'],
    //       "completed": ['COMPLETED'],
    //       "confirmed": ['CONFIRMED'],
    //       "disputed": ['DISPUTED'],
    //       "cancelled": ['CANCELLED'],
    //     };

    //     return status[widget.offerType].contains(trade.status);
    //   }).toList();

    //   if (trades.isEmpty) {
    //     if (data.loading) {
    //       return const Center(
    //           child: Padding(
    //         padding: EdgeInsets.all(8),
    //         child: CircularProgressIndicator(),
    //       ));
    //     } else if (tradeViewModel.error) {
    //       return Center(child: errorDialog(size: 20, tradeViewModel: data));
    //     }
    //   }
    //   return Expanded(
    //       child: trades.isEmpty
    //           ? Center(
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: AppSize.s96.h,
    //                   ),
    //                   Center(
    //                       child: SvgPicture.asset(
    //                           "assets/images/empty_state.svg")),
    //                   SizedBox(
    //                     height: AppSize.s49.h,
    //                   ),
    //                   const CustomText(
    //                     text: AppStrings.youHaveNoTrade,
    //                     textColor: ColorManager.blckColor,
    //                     fontSize: FontSize.s16,
    //                   ),
    //                   SizedBox(
    //                     height: AppSize.s8.h,
    //                   ),
    //                   // SizedBox(
    //                   //     width: AppSize.s208.w,
    //                   //     child: const CustomTextNoOverFlow(
    //                   //         alignment: "center",
    //                   //         fontSize: FontSize.s13,
    //                   //         text: AppStrings.transferFundsTo))
    //                 ],
    //               ),
    //             )
    //           : RefreshIndicator(
    //               onRefresh: () async {
    //                 await data.newFetchTrades();
    //               },
    //               child: ListView.builder(
    //                   itemCount:
    //                       trades.length + (tradeViewModel.isLastPage ? 0 : 1),
    //                   itemBuilder: (context, index) {
    //                     if (index ==
    //                         trades.length - tradeViewModel.nextPageTrigger) {
    //                       if (tradeViewModel.newTradesModel!.links!.next !=
    //                           null) {
    //                         tradeViewModel.newTradeUrl =
    //                             tradeViewModel.newTradesModel!.links!.next ??
    //                                 '';
    //                         tradeViewModel.newFetchTrades();
    //                       }
    //                     }
    //                     if (index == trades.length) {
    //                       if (tradeViewModel.error) {
    //                         return Center(
    //                             child: errorDialog(
    //                                 size: 13, tradeViewModel: tradeViewModel));
    //                       } else {
    //                         return Center(
    //                             child: Padding(
    //                           padding: EdgeInsets.symmetric(
    //                               vertical: AppSize.s300.h),
    //                           child: const CupertinoActivityIndicator(),
    //                         ));
    //                       }
    //                     }
    //                     final test = index;

    //                     final NewTradeData post = trades[index];

    //                     return NewTradeItem(
    //                       trade: post,
    //                       test: test,
    //                     );
    //                   }),
    //             ));
    // });

    // /oringal widget for this page
    // List trades = tradeViewModel.newTrades;

    trades = trades.where((trade) {
      Map status = <String, List>{
        "allTrades": ['ACTIVE', 'CONFIRMED', 'CANCELLED'],
        "active": ['ACTIVE'],
        "completed": ['COMPLETED'],
        "confirmed": ['CONFIRMED'],
        "disputed": ['DISPUTED'],
        "cancelled": ['CANCELLED'],
      };

      return status[widget.offerType].contains(trade.status);
    }).toList();

    if (trades.isEmpty) {
      if (tradeViewModel.loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (tradeViewModel.error) {
        return Center(
            child: errorDialog(size: 20, tradeViewModel: tradeViewModel));
      }
    }
    return Expanded(
        child: trades.isEmpty
            ? Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppSize.s96.h,
                    ),
                    Center(
                        child:
                            SvgPicture.asset("assets/images/empty_state.svg")),
                    SizedBox(
                      height: AppSize.s49.h,
                    ),
                    const CustomText(
                      text: AppStrings.youHaveNoTrade,
                      textColor: ColorManager.blckColor,
                      fontSize: FontSize.s16,
                    ),
                    SizedBox(
                      height: AppSize.s8.h,
                    ),
                    // SizedBox(
                    //     width: AppSize.s208.w,
                    //     child: const CustomTextNoOverFlow(
                    //         alignment: "center",
                    //         fontSize: FontSize.s13,
                    //         text: AppStrings.transferFundsTo))
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await tradeViewModel.newFetchTrades();
                },
                child: ListView.builder(
                    itemCount:
                        trades.length + (tradeViewModel.isLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index ==
                          trades.length - tradeViewModel.nextPageTrigger) {
                        if (tradeViewModel.newTradesModel!.links!.next !=
                            null) {
                          tradeViewModel.newTradeUrl =
                              tradeViewModel.newTradesModel!.links!.next ?? '';
                          tradeViewModel.newFetchTrades();
                        }
                      }
                      if (index == trades.length) {
                        if (tradeViewModel.error) {
                          return Center(
                              child: errorDialog(
                                  size: 13, tradeViewModel: tradeViewModel));
                        } else {
                          return Center(
                              child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: AppSize.s300.h),
                            child: const CupertinoActivityIndicator(),
                          ));
                        }
                      }
                      final test = index;

                      final NewTradeData post = trades[index];

                      return NewTradeItem(
                        trade: post,
                        test: test,
                      );
                    }),
              ));
// futureBuider part
    // return Expanded(
    //   child: FutureBuilder<List<NewTradeData?>>(
    //       future: tradeViewModel.newFetchTradesTest(),
    //       builder: (context, snapshot) {
    //         if (snapshot.hasError) {
    //           return const Center(
    //               child: Text(
    //             'An error occurred while fetching your trade',
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //               fontFamily: 'lexend',
    //               fontSize: 20,
    //               color: Color(0xff303030),
    //               fontWeight: FontWeight.w400,
    //             ),
    //           ));
    //         } else if (snapshot.hasData) {
    //           if (snapshot.data == null) {
    //             return Center(
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: AppSize.s96.h,
    //                   ),
    //                   Center(
    //                       child: SvgPicture.asset(
    //                           "assets/images/empty_state.svg")),
    //                   SizedBox(
    //                     height: AppSize.s49.h,
    //                   ),
    //                   const CustomText(
    //                     text: AppStrings.youHaveNotCreatedAnyOffer,
    //                     textColor: ColorManager.blckColor,
    //                     fontSize: FontSize.s16,
    //                   ),
    //                   SizedBox(
    //                     height: AppSize.s8.h,
    //                   ),
    //                   SizedBox(
    //                       width: AppSize.s208.w,
    //                       child: const CustomTextNoOverFlow(
    //                           alignment: "center",
    //                           fontSize: FontSize.s13,
    //                           text: AppStrings.transferFundsToYourWallet))
    //                 ],
    //               ),
    //             );
    //           } else {
    //             // List trades = tradeViewModel.newTrades;

    //             var offers = snapshot.data!;

    //             offers = offers.where((offers) {
    //               Map status = <String, List>{
    //                 "allTrades": ['ACTIVE', 'CONFIRMED', 'CANCELLED'],
    //                 "active": ['ACTIVE'],
    //                 "completed": ['COMPLETED'],
    //                 "confirmed": ['CONFIRMED'],
    //                 "disputed": ['DISPUTED'],
    //                 "cancelled": ['CANCELLED'],
    //               };

    //               return status[widget.offerType].contains(offers!.status);
    //             }).toList();

    //             return RefreshIndicator(
    //               onRefresh: () async {
    //                 await tradeViewModel.newFetchTradesTest();
    //               },
    //               child: ListView.builder(
    //                   itemCount:
    //                       offers.length + (tradeViewModel.isLastPage ? 0 : 1),
    //                   itemBuilder: (context, index) {
    //                     if (index ==
    //                         offers.length - tradeViewModel.nextPageTrigger) {
    //                       if (tradeViewModel.newTradesModel!.links!.next !=
    //                           null) {
    //                         tradeViewModel.newTradeUrl =
    //                             tradeViewModel.newTradesModel!.links!.next ??
    //                                 '';
    //                         tradeViewModel.newFetchTradesTest();
    //                       }
    //                     }
    //                     if (index == offers.length) {
    //                       if (tradeViewModel.error) {
    //                         return Center(
    //                             child: errorDialog(
    //                                 size: 13, tradeViewModel: tradeViewModel));
    //                       } else {
    //                         return Center(
    //                             child: Padding(
    //                           padding: EdgeInsets.symmetric(
    //                               vertical: AppSize.s300.h),
    //                           child: const CupertinoActivityIndicator(),
    //                         ));
    //                       }
    //                     }

    //                     final test = index;

    //                     final NewTradeData post = offers[index]!;

    //                     return NewTradeItem(
    //                       trade: post,
    //                       test: test,
    //                     );
    //                   }),
    //             );
    //           }
    //         } else {
    //           return Padding(
    //               padding: EdgeInsets.only(
    //                   top: MediaQuery.of(context).size.height * 0.2),
    //               child: const Text("loading")
    //               // LoadingIndicator(),
    //               );
    //         }
    //       }),
    // );
  }
}

Widget errorDialog(
    {required double size, required TradeViewModel tradeViewModel}) {
  return SizedBox(
    height: 220,
    width: 250,
    child: Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the trades.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomElevatedButton(
              onTap: () {},
              backgroundColor: ColorManager.primaryColor,
              textColor: ColorManager.whiteColor,
              title: "Retry"),
        ],
      ),
    ),
  );
}
