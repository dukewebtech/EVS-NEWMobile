import 'package:evs_pay_mobile/model/dashboard_trade_model.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/navigation_utils.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/re_usable_widgets.dart';

import 'package:evs_pay_mobile/utils/local_notification_service.dart';

class SellView extends StatefulWidget {
    final dynamic ref;

  final dynamic username;
  final dynamic minLimits;
  final dynamic maxLimits;

  final dynamic amt;
  final dynamic paymentType;
  final dynamic terms;
  const SellView(
      {
        this.ref,
        this.username,
      this.maxLimits,
      this.minLimits,
      this.amt,
      this.paymentType,
      this.terms,
      Key? key})
      : super(key: key);
  @override
  State<SellView> createState() => _SellViewState();
}

class _SellViewState extends State<SellView> {
  // final amountController = TextEditingController();
  // final usdAmount = TextEditingController();

  late final LocalNotificationService service;

  void onNotificationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {}
  }

  void listenToNotification() {
    service.onNotificationClick.stream.listen(onNotificationListener);
  }

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    listenToNotification();
    super.initState();
  }

  final btcAmountController = TextEditingController();
  final nairaAmountController = TextEditingController();

  String btcAmount = "0.0";

  @override
  void dispose() {
    super.dispose();
    nairaAmountController.dispose();
    btcAmountController.dispose();
    widget.amt;
    widget.username;
    widget.terms;
    widget.minLimits;
    widget.maxLimits;
  }

  @override
  Widget build(BuildContext context) {
    // if (mounted) {
    //   setState(() {});
    // }

    final dashboardViewModel = context.watch<DashboardViewModel2>();
// final List<DashboardTradeData> offer =dashboardViewModel.trades;
    final authProvider = context.watch<AuthenticationProvider>();
    final value = dashboardViewModel.buyTrades;

// "${dashboardViewModel.singleTradeModel.data!.coinValue}

    var ky = dashboardViewModel.selectedDashboardTrade?.maxAmount;
    var my = dashboardViewModel.selectedDashboardTrade?.minAmount;
   
    // var ty = dashboardViewModel.initTradeData.data?.coin?.name;
    print("this ---------------- $ky ------------------------");
    var btcAmount = dashboardViewModel.btcToBuy;
    var profitMargin = dashboardViewModel.selectedDashboardTrade?.profitMargin;
    dashboardViewModel.selectedDashboardTrade?.profitMargin;
    var userName = dashboardViewModel.selectedDashboardTrade?.user!.username!;
    var limitmax =
        dashboardViewModel.selectedDashboardTrade?.maxAmount.toString();
    var limitmin =
        dashboardViewModel.selectedDashboardTrade?.minAmount.toString();
    var amountRecieved =
        nairaAmountController.text.isEmpty ? 0.0 : nairaAmountController.text;
    var btcRecieved =
        btcAmountController.text.isEmpty ? 0.0 : btcAmountController.text;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s13.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///this is where i start "kaizen"

            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: Color(0xff292D32),
                      )),
                  SizedBox(
                    width: AppSize.s3.w,
                  ),
                  const Text(
                    'Sell BTC',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lexend',
                      color: Color(0xff424242),
                    ),
                  ),
                ],
              ),
            ),
            // Text(ty ?? "null"),
            Text(ky.toString()),
            Text(my.toString()),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                elevation: 0.5,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, right: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// the reason we have using ? is because if we use ! it throughs a null check operator error
                          Text(
                            widget.username,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            widget.paymentType,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff969696),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Rate:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "${widget.amt}/USD",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff312DA3),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Limit:',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff000000),
                            ),
                          ),
                          Text(
                            "NGN ${widget.minLimits} - ${widget.maxLimits}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff312DA3),
                            ),
                          )
                        ],
                      ),
                      // Text(
                      //   "NGN ${dashboardViewModel.createOfferModel.maxAmount ?? "kay"}",
                      //   style: const TextStyle(
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w400,
                      //     fontFamily: 'Lexend',
                      //     color: Color(0xff8e8e8e),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s31.h,
            ),
            const Text(
              'I want to sell',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lexend',
                color: Color(0xff000000),
              ),
            ),
            SizedBox(
              height: AppSize.s10.h,
            ),

            Container(
              // height: AppSize.s48.h,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.inputFieldBorder),
                  borderRadius: BorderRadius.circular(AppSize.s3.r)),
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: nairaAmountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: ColorManager.textFieldColor,
                    autofocus: true,
                    maxLines: 1,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    style: const TextStyle(
                        color: ColorManager.textFieldColor,
                        fontSize: FontSize.s16),
                    onChanged: (value) async {
                      if (value.isNotEmpty) {
                        btcAmount = value;
                        await dashboardViewModel.getNairaToBtcRate(value);
                        btcAmountController.text =
                            dashboardViewModel.nairaToBtc == null
                                ? "0.00"
                                : dashboardViewModel.nairaToBtc!.data.btc
                                    .toString();
                        setState(() {});
                      } else {
                        btcAmountController.text = "";
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                      filled: false,
                      counterText: "",
                      fillColor: ColorManager.whiteColor,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: AppStrings.amt,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(
                            color: ColorManager.primaryColor, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(
                            color: ColorManager.primaryColor, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(
                            color: ColorManager.primaryColor, width: 1),
                      ),
                      hintStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16),
                      labelStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16),
                      errorStyle: TextStyle(
                          color: ColorManager.redColor, fontSize: FontSize.s16),
                    ),
                  )),
                  Container(
                    width: AppSize.s54.w,
                    alignment: Alignment.center,
                    child: const CustomTextWithLineHeight(
                      text: 'NG',
                      fontSize: FontSize.s15,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s17.h,
            ),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Card(
                elevation: 0.5,
                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(width: 0.5, color: Color(0xffE8E8E8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${btcRecieved}BTC",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Lexend',
                          color: Color(0xff666666),
                        ),
                      ),
                      // const Text(
                      //   '\$49',
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //     fontFamily: 'Lexend',
                      //     color: Color(0xffA7A7A7),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s30.h,
            ),
            // Text(dashboardViewModel.singleTradeModel.data!.offer!.profitMargin
            //     .toString()),
            // Text(dashboardViewModel.singleTradeModel.data!.offer!.minAmount
            //     .toString()),
            // Text(dashboardViewModel.singleTradeModel.data!.offer!.terms
            //     .toString()),
            // const Center(child: CustomText(text: AppStrings.secureEscrow)),
            // const Center(
            //     child: CustomText(
            //   text: AppStrings.buyer,
            //   fontWeight: FontWeightManager.bold,
            //   textColor: ColorManager.arrowColor,
            // )),
            const Text(
              'Terms',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lexend',
                color: Color(0xff000000),
              ),
            ),

            SizedBox(
              height: AppSize.s15.h,
            ),
            Text(
              widget.terms,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'Lexend',
                color: Colors.black.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(
              height: AppSize.s64.h,
            ),
            dashboardViewModel.loading
                ? const Center(child: CupertinoActivityIndicator())
                : Consumer<DashboardViewModel2>(builder: (ctx, myAd, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (myAd.resMessage != '') {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            message: myAd.resMessage,
                            backgroundColor: myAd.isSuccessful
                                ? ColorManager.deepGreenColor
                                : ColorManager.primaryColor,
                          ),
                        );

                        ///Clear the response message to avoid duplicate
                        myAd.clear();
                      }
                    });
                    return Center(
                      child: CustomElevatedButton(
                          onTap: () async {
                            // final ngnAmount =
                            //     double.parse(nairaAmountController.text);
                            final minAmount = widget.minLimits;
                            final maxAmount = widget.maxLimits;

                            if (double.parse(nairaAmountController.text
                                            .trim()
                                            .isEmpty
                                        ? "0.0"
                                        : nairaAmountController.text.trim()) <
                                    minAmount ||
                                double.parse(nairaAmountController.text
                                            .trim()
                                            .isEmpty
                                        ? "0.0"
                                        : nairaAmountController.text.trim()) >
                                    maxAmount) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.info(
                                  message:
                                      "Amount much be between ${widget.minLimits} and ${widget.maxLimits}",
                                  backgroundColor: ColorManager.primaryColor,
                                ),
                              );
                            } else {
                              final isCreated = await dashboardViewModel
                                  .initTrade(nairaAmountController.text, widget.ref);
                              if (isCreated) {
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    // service.showNotification(
                                    //     id: 1,
                                    //     title: "Sell BTC",
                                    //     body:
                                    //         "Dear ${authProvider.userData.user?.username}, You have initiated a trade of ${profitMargin.toString()}BTC at rate of ${dashboardViewModel.singleTradeModel.data!.coinValue} with ${userName ?? "User"}.  ");

                                    openConfirmSellTradeView(context);
                                  });
                                });
                              }
                            }
                          },
                          backgroundColor: ColorManager.primaryColor,
                          textColor: ColorManager.blackTxtColor,
                          title: AppStrings.proceedToSell),
                    );
                  }),
            Text(dashboardViewModel.selectedDashboardTrade?.maxAmount
                    .toString() ??
                "null")

            ///this where i end
            // SizedBox(
            //   height: AppSize.s42.h,
            // ),
            // SizedBox(
            //   height: AppSize.s18.h,
            // ),
            // Row(
            //   children: const [
            //     CustomTextWithLineHeight(
            //       text: AppStrings.sellLowerCase,
            //       textColor: ColorManager.blckColor,
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: AppSize.s22.h,
            // ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.only(
            //     top: 5.h,
            //   ),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(AppSize.s10.r),
            //       color: ColorManager.primaryColor,
            //       border: Border.all(color: ColorManager.inputFieldBorder)),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
            //     decoration: BoxDecoration(
            //       color: ColorManager.whiteColor,
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(
            //           height: AppSize.s26.h,
            //         ),
            //         const Center(
            //           child: CustomTextWithLineHeight(
            //             text: AppStrings.howMuchDoYou,
            //             textColor: ColorManager.arrowColor,
            //             fontWeight: FontWeightManager.bold,
            //           ),
            //         ),
            //         SizedBox(
            //           height: AppSize.s92.h,
            //         ),
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.iWantToSell,
            //           textColor: ColorManager.arrowColor,
            //           fontWeight: FontWeightManager.regular,
            //         ),

            //         Container(
            //           // height: AppSize.s48.h,
            //           decoration: BoxDecoration(
            //               border:
            //                   Border.all(color: ColorManager.inputFieldBorder),
            //               borderRadius: BorderRadius.circular(AppSize.s3.r)),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                   child: TextFormField(
            //                 controller: btcAmountController,
            //                 autovalidateMode:
            //                     AutovalidateMode.onUserInteraction,
            //                 cursorColor: ColorManager.textFieldColor,
            //                 autofocus: true,
            //                 maxLines: 1,
            //                 keyboardType: const TextInputType.numberWithOptions(
            //                     decimal: true, signed: false),
            //                 style: const TextStyle(
            //                     color: ColorManager.textFieldColor,
            //                     fontSize: FontSize.s16),
            //                 onChanged: (value) async {
            //                   if (value.isNotEmpty) {
            //                     btcAmount = value;
            //                     await dashboardViewModel
            //                         .getBtcToNairaRate(value);
            //                     nairaAmountController.text =
            //                         dashboardViewModel.btcNairaModel == null
            //                             ? "0.00"
            //                             : dashboardViewModel
            //                                 .btcNairaModel!.data.naira
            //                                 .toString();
            //                     setState(() {});
            //                   } else {
            //                     nairaAmountController.text = "";
            //                     setState(() {});
            //                   }
            //                 },
            //                 decoration: InputDecoration(
            //                   filled: false,
            //                   counterText: "",
            //                   fillColor: ColorManager.whiteColor,
            //                   contentPadding: const EdgeInsets.all(10),
            //                   hintText: AppStrings.amt,
            //                   border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   enabledBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   focusedBorder: OutlineInputBorder(
            //                     gapPadding: 0.0,
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   hintStyle: const TextStyle(
            //                       color: ColorManager.labelTextColor,
            //                       fontSize: FontSize.s16),
            //                   labelStyle: const TextStyle(
            //                       color: ColorManager.labelTextColor,
            //                       fontSize: FontSize.s16),
            //                   errorStyle: TextStyle(
            //                       color: ColorManager.redColor,
            //                       fontSize: FontSize.s16),
            //                 ),
            //               )),
            //               Container(
            //                 width: AppSize.s54.w,
            //                 alignment: Alignment.center,
            //                 child: const CustomTextWithLineHeight(
            //                   text: AppStrings.btc,
            //                   fontSize: FontSize.s15,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),

            //         //
            //         // Container(
            //         //     decoration: BoxDecoration(
            //         //       borderRadius: BorderRadius.circular(5.r),
            //         //       color: ColorManager.whiteColor,
            //         //     ),
            //         //     alignment: Alignment.center,
            //         //     child: TextFormField(
            //         //       controller: amountController,
            //         //       autovalidateMode: AutovalidateMode.onUserInteraction,
            //         //       cursorColor: ColorManager.textFieldColor,
            //         //       autofocus: true,
            //         //       maxLines: 1,
            //         //       validator: (value){
            //         //         if(value!.isNotEmpty && double.parse(value.isEmpty ? "0.0" : value) < dashboardViewModel.selectedTrade.minAmount ||
            //         //             double.parse(value.isEmpty ? "0.0" : value) > dashboardViewModel.selectedTrade.maxAmount){
            //         //           return "Amount much be between ${dashboardViewModel.selectedTrade.minAmount} and ${dashboardViewModel.selectedTrade.maxAmount}";
            //         //         }
            //         //         return null;
            //         //       },
            //         //       keyboardType: TextInputType.number,
            //         //       style: const TextStyle(
            //         //           color: ColorManager.textFieldColor,
            //         //           fontSize: FontSize.s16
            //         //       ),
            //         //       onChanged: (value){
            //         //         if(value.isNotEmpty){
            //         //           setState(() {
            //         //             btcAmount = value;
            //         //             dashboardViewModel.getNairaToBtcRate(value);
            //         //           });
            //         //         }
            //         //
            //         //       },
            //         //
            //         //       decoration: InputDecoration(
            //         //           filled: false,
            //         //           counterText: "",
            //         //           fillColor: ColorManager.whiteColor,
            //         //           contentPadding: const EdgeInsets.all(10),
            //         //           hintText: AppStrings.amt,
            //         //           border: OutlineInputBorder(
            //         //             borderRadius: BorderRadius.circular(5.r),
            //         //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //         //                 width: 1),
            //         //           ),
            //         //           enabledBorder: OutlineInputBorder(
            //         //             borderRadius: BorderRadius.circular(5.r),
            //         //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //         //                 width: 1),
            //         //           ),
            //         //           focusedBorder: OutlineInputBorder(
            //         //             gapPadding: 0.0,
            //         //             borderRadius: BorderRadius.circular(5.r),
            //         //             borderSide: const BorderSide(color: ColorManager.textFieldColor,
            //         //                 width: 1),
            //         //           ),
            //         //           hintStyle: const TextStyle(
            //         //               color: ColorManager.labelTextColor,
            //         //               fontSize: FontSize.s16
            //         //           ),
            //         //           labelStyle: const TextStyle(
            //         //               color: ColorManager.labelTextColor,
            //         //               fontSize: FontSize.s16
            //         //           ),
            //         //         errorStyle: TextStyle(
            //         //             color: ColorManager.redColor,
            //         //             fontSize: FontSize.s16
            //         //         ),
            //         //       ),
            //         //
            //         //     )
            //         // ),

            //         SizedBox(
            //           height: AppSize.s13.h,
            //         ),
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.andReceive,
            //           textColor: ColorManager.arrowColor,
            //         ),
            //         SizedBox(
            //           height: AppSize.s4.h,
            //         ),

            //         Container(
            //           // height: AppSize.s48.h,
            //           decoration: BoxDecoration(
            //               border:
            //                   Border.all(color: ColorManager.inputFieldBorder),
            //               borderRadius: BorderRadius.circular(AppSize.s3.r)),
            //           child: Row(
            //             children: [
            //               Expanded(
            //                   child: TextFormField(
            //                 controller: nairaAmountController,
            //                 autovalidateMode:
            //                     AutovalidateMode.onUserInteraction,
            //                 cursorColor: ColorManager.textFieldColor,
            //                 autofocus: true,
            //                 maxLines: 1,
            //                 validator: (value) {
            //                   if (value!.isEmpty) {
            //                     return "Please enter fields";
            //                   }
            //                   // if (value.isNotEmpty &&
            //                   //         double.parse(
            //                   //                 value.isEmpty ? "0.0" : value) <
            //                   //             dashboardViewModel
            //                   //                 .selectedDashboardTrade!
            //                   //                 .minAmount ||
            //                   //     double.parse(value.isEmpty ? "0.0" : value) >
            //                   //         dashboardViewModel
            //                   //             .selectedDashboardTrade!.maxAmount) {
            //                   if (value.isNotEmpty) {
            //                     double amount = double.parse(value);
            //                     if (amount < widget.minLimits) {
            //                       return "Between ${widget.minLimits} and ${widget.maxLimits}";
            //                     }
            //                   }
            //                   return null;
            //                 },
            //                 keyboardType: const TextInputType.numberWithOptions(
            //                     decimal: true, signed: false),
            //                 style: const TextStyle(
            //                     color: ColorManager.textFieldColor,
            //                     fontSize: FontSize.s16),
            //                 onChanged: (value) async {
            //                   if (value.isNotEmpty) {
            //                     btcAmount = value;
            //                     final nairaBtc = await dashboardViewModel
            //                         .getNairaToBtcRate(value);
            //                     print("Naira value: $nairaBtc");
            //                     btcAmountController.text = dashboardViewModel
            //                         .nairaToBtc!.data.btc
            //                         .toString();
            //                     setState(() {});
            //                   } else {
            //                     btcAmountController.text = "";
            //                   }
            //                 },
            //                 decoration: InputDecoration(
            //                   filled: false,
            //                   counterText: "",
            //                   fillColor: ColorManager.whiteColor,
            //                   contentPadding: const EdgeInsets.all(10),
            //                   hintText: AppStrings.amt,
            //                   border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   enabledBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   focusedBorder: OutlineInputBorder(
            //                     gapPadding: 0.0,
            //                     borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(AppSize.s3.r),
            //                       topLeft: Radius.circular(AppSize.s3.r),
            //                     ),
            //                     borderSide: const BorderSide(
            //                         color: ColorManager.inactiveInputFieldColor,
            //                         width: 1),
            //                   ),
            //                   hintStyle: const TextStyle(
            //                       color: ColorManager.labelTextColor,
            //                       fontSize: FontSize.s16),
            //                   labelStyle: const TextStyle(
            //                       color: ColorManager.labelTextColor,
            //                       fontSize: FontSize.s16),
            //                   errorStyle: TextStyle(
            //                       color: ColorManager.redColor,
            //                       fontSize: FontSize.s16),
            //                 ),
            //               )),
            //               Container(
            //                 width: AppSize.s54.w,
            //                 alignment: Alignment.center,
            //                 child: const CustomTextWithLineHeight(
            //                   text: AppStrings.ngn,
            //                   fontSize: FontSize.s15,
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),

            //         // Container(
            //         //   height: AppSize.s48.h,
            //         //   decoration: BoxDecoration(
            //         //       border: Border.all(
            //         //           color: ColorManager.inputFieldBorder
            //         //       ),
            //         //       borderRadius: BorderRadius.circular(AppSize.s3.r)
            //         //   ),
            //         //   child: Row(
            //         //     children: [
            //         //       Expanded(child:
            //         //       Padding(
            //         //         padding: EdgeInsets.only(left: AppSize.s12.w),
            //         //         child: CustomTextWithLineHeight(text: dashboardViewModel.nairaToBtc == null? "0.0" : "${dashboardViewModel.nairaToBtc!.data.btc}", fontSize: FontSize.s15,),
            //         //       )),
            //         //
            //         //       Container(
            //         //         width: AppSize.s54.w,
            //         //         alignment: Alignment.center,
            //         //         child:
            //         //         const CustomTextWithLineHeight(text: AppStrings.ngn, fontSize: FontSize.s15,),
            //         //       )
            //         //     ],
            //         //   ),
            //         // ),

            //         SizedBox(
            //           height: AppSize.s24.h,
            //         ),

            //         const Center(
            //             child: CustomText(text: AppStrings.secureEscrow)),
            //         const Center(
            //             child: CustomText(
            //           text: AppStrings.buyer,
            //           fontWeight: FontWeightManager.bold,
            //           textColor: ColorManager.arrowColor,
            //         )),

            //         SizedBox(
            //           height: AppSize.s64.h,
            //         ),
            //         dashboardViewModel.loading
            //             ? const Center(child: CupertinoActivityIndicator())
            //             : Consumer<DashboardViewModel2>(
            //                 builder: (ctx, myAd, child) {
            //                 WidgetsBinding.instance.addPostFrameCallback((_) {
            //                   if (myAd.resMessage != '') {
            //                     showTopSnackBar(
            //                       context,
            //                       CustomSnackBar.info(
            //                         message: myAd.resMessage,
            //                         backgroundColor: myAd.isSuccessful
            //                             ? ColorManager.deepGreenColor
            //                             : ColorManager.primaryColor,
            //                       ),
            //                     );

            //                     ///Clear the response message to avoid duplicate
            //                     myAd.clear();
            //                   }
            //                 });
            //                 return Center(
            //                   child: CustomElevatedButton(
            //                       onTap: () async {
            //                         if (double.parse(nairaAmountController.text
            //                                         .trim()
            //                                         .isEmpty
            //                                     ? "0.0"
            //                                     : nairaAmountController.text
            //                                         .trim()) <
            //                                 dashboardViewModel
            //                                     .selectedDashboardTrade!
            //                                     .minAmount ||
            //                             double.parse(nairaAmountController.text
            //                                         .trim()
            //                                         .isEmpty
            //                                     ? "0.0"
            //                                     : nairaAmountController.text
            //                                         .trim()) >
            //                                 dashboardViewModel
            //                                     .selectedDashboardTrade!
            //                                     .maxAmount) {
            //                           showTopSnackBar(
            //                             context,
            //                             CustomSnackBar.info(
            //                               message:
            //                                   "Amount much be between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}",
            //                               backgroundColor:
            //                                   ColorManager.primaryColor,
            //                             ),
            //                           );
            //                         } else {
            //                           final isCreated =
            //                               await dashboardViewModel.initTrade(
            //                                   nairaAmountController.text);
            //                           if (isCreated) {
            //                             Future.delayed(
            //                                 const Duration(seconds: 1), () {
            //                               setState(() {
            //                                 service.showNotification(
            //                                     id: 1,
            //                                     title: "Sell BTC",
            //                                     body:
            //                                         "Dear ${authProvider.userData.user?.username}, You have initiated a trade of ${profitMargin.toString() ?? ""}BTC at rate of ${dashboardViewModel.singleTradeModel.data!.coinValue} with ${userName ?? "User"}.  ");

            //                                 print('tapped');
            //                                 openConfirmSellTradeView(context);
            //                               });
            //                             });
            //                           }
            //                         }
            //                       },
            //                       backgroundColor: ColorManager.primaryColor,
            //                       textColor: ColorManager.blackTxtColor,
            //                       title: AppStrings.proceedToSell),
            //                 );
            //               }),

            //         ///
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}
