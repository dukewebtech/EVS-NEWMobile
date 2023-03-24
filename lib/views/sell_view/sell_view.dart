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
import '../../widgets/custom_app_bar.dart';
import '../../widgets/re_usable_widgets.dart';

import 'package:evs_pay_mobile/utils/local_notification_service.dart';

class SellView extends StatefulWidget {
  const SellView({Key? key}) : super(key: key);
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
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    final authProvider = context.watch<AuthenticationProvider>();
    final value = context.watch<DashboardViewModel2>();

// "${dashboardViewModel.singleTradeModel.data!.coinValue}

    var btcAmount = dashboardViewModel.btcToBuy;
    var profitMargin = dashboardViewModel.selectedDashboardTrade?.profitMargin;
    dashboardViewModel.selectedDashboardTrade?.profitMargin;
    var userName = dashboardViewModel.selectedDashboardTrade?.user!.username!;

    return Scaffold(
      appBar:
          evsPayCustomAppBar(context, AppStrings.sellLowerCase, leadingTap: () {
        Navigator.pop(context);
      }, isCenterAlign: true),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s13.w),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.s42.h,
            ),
            SizedBox(
              height: AppSize.s18.h,
            ),
            Row(
              children: const [
                CustomTextWithLineHeight(
                  text: AppStrings.sellLowerCase,
                  textColor: ColorManager.blckColor,
                ),
              ],
            ),
            SizedBox(
              height: AppSize.s22.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  color: ColorManager.primaryColor,
                  border: Border.all(color: ColorManager.inputFieldBorder)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppSize.s10.w),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppSize.s26.h,
                    ),
                    const Center(
                      child: CustomTextWithLineHeight(
                        text: AppStrings.howMuchDoYou,
                        textColor: ColorManager.arrowColor,
                        fontWeight: FontWeightManager.bold,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s92.h,
                    ),
                    const CustomTextWithLineHeight(
                      text: AppStrings.iWantToSell,
                      textColor: ColorManager.arrowColor,
                      fontWeight: FontWeightManager.regular,
                    ),

                    Container(
                      // height: AppSize.s48.h,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorManager.inputFieldBorder),
                          borderRadius: BorderRadius.circular(AppSize.s3.r)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: btcAmountController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                await dashboardViewModel
                                    .getBtcToNairaRate(value);
                                nairaAmountController.text =
                                    dashboardViewModel.btcNairaModel == null
                                        ? "0.00"
                                        : dashboardViewModel
                                            .btcNairaModel!.data.naira
                                            .toString();
                                setState(() {});
                              } else {
                                nairaAmountController.text = "";
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
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(AppSize.s3.r),
                                  topLeft: Radius.circular(AppSize.s3.r),
                                ),
                                borderSide: const BorderSide(
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 0.0,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(AppSize.s3.r),
                                  topLeft: Radius.circular(AppSize.s3.r),
                                ),
                                borderSide: const BorderSide(
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              hintStyle: const TextStyle(
                                  color: ColorManager.labelTextColor,
                                  fontSize: FontSize.s16),
                              labelStyle: const TextStyle(
                                  color: ColorManager.labelTextColor,
                                  fontSize: FontSize.s16),
                              errorStyle: TextStyle(
                                  color: ColorManager.redColor,
                                  fontSize: FontSize.s16),
                            ),
                          )),
                          Container(
                            width: AppSize.s54.w,
                            alignment: Alignment.center,
                            child: const CustomTextWithLineHeight(
                              text: AppStrings.btc,
                              fontSize: FontSize.s15,
                            ),
                          )
                        ],
                      ),
                    ),

                    //
                    // Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(5.r),
                    //       color: ColorManager.whiteColor,
                    //     ),
                    //     alignment: Alignment.center,
                    //     child: TextFormField(
                    //       controller: amountController,
                    //       autovalidateMode: AutovalidateMode.onUserInteraction,
                    //       cursorColor: ColorManager.textFieldColor,
                    //       autofocus: true,
                    //       maxLines: 1,
                    //       validator: (value){
                    //         if(value!.isNotEmpty && double.parse(value.isEmpty ? "0.0" : value) < dashboardViewModel.selectedTrade.minAmount ||
                    //             double.parse(value.isEmpty ? "0.0" : value) > dashboardViewModel.selectedTrade.maxAmount){
                    //           return "Amount much be between ${dashboardViewModel.selectedTrade.minAmount} and ${dashboardViewModel.selectedTrade.maxAmount}";
                    //         }
                    //         return null;
                    //       },
                    //       keyboardType: TextInputType.number,
                    //       style: const TextStyle(
                    //           color: ColorManager.textFieldColor,
                    //           fontSize: FontSize.s16
                    //       ),
                    //       onChanged: (value){
                    //         if(value.isNotEmpty){
                    //           setState(() {
                    //             btcAmount = value;
                    //             dashboardViewModel.getNairaToBtcRate(value);
                    //           });
                    //         }
                    //
                    //       },
                    //
                    //       decoration: InputDecoration(
                    //           filled: false,
                    //           counterText: "",
                    //           fillColor: ColorManager.whiteColor,
                    //           contentPadding: const EdgeInsets.all(10),
                    //           hintText: AppStrings.amt,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(5.r),
                    //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                    //                 width: 1),
                    //           ),
                    //           enabledBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(5.r),
                    //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                    //                 width: 1),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             gapPadding: 0.0,
                    //             borderRadius: BorderRadius.circular(5.r),
                    //             borderSide: const BorderSide(color: ColorManager.textFieldColor,
                    //                 width: 1),
                    //           ),
                    //           hintStyle: const TextStyle(
                    //               color: ColorManager.labelTextColor,
                    //               fontSize: FontSize.s16
                    //           ),
                    //           labelStyle: const TextStyle(
                    //               color: ColorManager.labelTextColor,
                    //               fontSize: FontSize.s16
                    //           ),
                    //         errorStyle: TextStyle(
                    //             color: ColorManager.redColor,
                    //             fontSize: FontSize.s16
                    //         ),
                    //       ),
                    //
                    //     )
                    // ),

                    SizedBox(
                      height: AppSize.s13.h,
                    ),
                    const CustomTextWithLineHeight(
                      text: AppStrings.andReceive,
                      textColor: ColorManager.arrowColor,
                    ),
                    SizedBox(
                      height: AppSize.s4.h,
                    ),

                    Container(
                      // height: AppSize.s48.h,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: ColorManager.inputFieldBorder),
                          borderRadius: BorderRadius.circular(AppSize.s3.r)),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: nairaAmountController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorColor: ColorManager.textFieldColor,
                            autofocus: true,
                            maxLines: 1,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter fields";
                              }
                              if (value.isNotEmpty &&
                                      double.parse(
                                              value.isEmpty ? "0.0" : value) <
                                          dashboardViewModel
                                              .selectedDashboardTrade!
                                              .minAmount ||
                                  double.parse(value.isEmpty ? "0.0" : value) >
                                      dashboardViewModel
                                          .selectedDashboardTrade!.maxAmount) {
                                return "Between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}";
                              }
                              return null;
                            },
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true, signed: false),
                            style: const TextStyle(
                                color: ColorManager.textFieldColor,
                                fontSize: FontSize.s16),
                            onChanged: (value) async {
                              if (value.isNotEmpty) {
                                btcAmount = value;
                                final nairaBtc = await dashboardViewModel
                                    .getNairaToBtcRate(value);
                                print("Naira value: $nairaBtc");
                                btcAmountController.text = dashboardViewModel
                                    .nairaToBtc!.data.btc
                                    .toString();
                                setState(() {});
                              } else {
                                btcAmountController.text = "";
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
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(AppSize.s3.r),
                                  topLeft: Radius.circular(AppSize.s3.r),
                                ),
                                borderSide: const BorderSide(
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                gapPadding: 0.0,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(AppSize.s3.r),
                                  topLeft: Radius.circular(AppSize.s3.r),
                                ),
                                borderSide: const BorderSide(
                                    color: ColorManager.inactiveInputFieldColor,
                                    width: 1),
                              ),
                              hintStyle: const TextStyle(
                                  color: ColorManager.labelTextColor,
                                  fontSize: FontSize.s16),
                              labelStyle: const TextStyle(
                                  color: ColorManager.labelTextColor,
                                  fontSize: FontSize.s16),
                              errorStyle: TextStyle(
                                  color: ColorManager.redColor,
                                  fontSize: FontSize.s16),
                            ),
                          )),
                          Container(
                            width: AppSize.s54.w,
                            alignment: Alignment.center,
                            child: const CustomTextWithLineHeight(
                              text: AppStrings.ngn,
                              fontSize: FontSize.s15,
                            ),
                          )
                        ],
                      ),
                    ),

                    // Container(
                    //   height: AppSize.s48.h,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //           color: ColorManager.inputFieldBorder
                    //       ),
                    //       borderRadius: BorderRadius.circular(AppSize.s3.r)
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Expanded(child:
                    //       Padding(
                    //         padding: EdgeInsets.only(left: AppSize.s12.w),
                    //         child: CustomTextWithLineHeight(text: dashboardViewModel.nairaToBtc == null? "0.0" : "${dashboardViewModel.nairaToBtc!.data.btc}", fontSize: FontSize.s15,),
                    //       )),
                    //
                    //       Container(
                    //         width: AppSize.s54.w,
                    //         alignment: Alignment.center,
                    //         child:
                    //         const CustomTextWithLineHeight(text: AppStrings.ngn, fontSize: FontSize.s15,),
                    //       )
                    //     ],
                    //   ),
                    // ),

                    SizedBox(
                      height: AppSize.s24.h,
                    ),
                    GestureDetector(
                        onTap: () {
                          service.showNotification(
                              id: 1,
                              title: "Buy BTC",
                              body: "Dear Sell lomo jaye ");
                        },
                        child: const Text('noty')),
                    const Center(
                        child: CustomText(text: AppStrings.secureEscrow)),
                    const Center(
                        child: CustomText(
                      text: AppStrings.buyer,
                      fontWeight: FontWeightManager.bold,
                      textColor: ColorManager.arrowColor,
                    )),

                    SizedBox(
                      height: AppSize.s64.h,
                    ),
                    dashboardViewModel.loading
                        ? const Center(child: CupertinoActivityIndicator())
                        : Consumer<DashboardViewModel2>(
                            builder: (ctx, myAd, child) {
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
                                    if (double.parse(nairaAmountController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0.0"
                                                : nairaAmountController.text
                                                    .trim()) <
                                            dashboardViewModel
                                                .selectedDashboardTrade!
                                                .minAmount ||
                                        double.parse(nairaAmountController.text
                                                    .trim()
                                                    .isEmpty
                                                ? "0.0"
                                                : nairaAmountController.text
                                                    .trim()) >
                                            dashboardViewModel
                                                .selectedDashboardTrade!
                                                .maxAmount) {
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.info(
                                          message:
                                              "Amount much be between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}",
                                          backgroundColor:
                                              ColorManager.primaryColor,
                                        ),
                                      );
                                    } else {
                                      final isCreated =
                                          await dashboardViewModel.initTrade(
                                              nairaAmountController.text);
                                      if (isCreated) {
                                        Future.delayed(
                                            const Duration(seconds: 1), () {
                                          setState(() {
                                            // service.showNotification(
                                            //     id: 1,
                                            //     title: "Sell BTC",
                                            //     body:
                                            //         "Dear ${authProvider.userData.user?.username}, You have initiated a trade of ${profitMargin.toString() ?? ""}BTC at rate of ${dashboardViewModel.singleTradeModel.data!.coinValue} with ${userName ?? "User"}.  ");

                                            print('tapped');
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
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
