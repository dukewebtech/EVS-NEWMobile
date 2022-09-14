import 'package:evs_pay_mobile/resources/constants/constants.dart';
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

class BuyTradeView extends StatefulWidget {
  const BuyTradeView({Key? key}) : super(key: key);
  @override
  State<BuyTradeView> createState() => _BuyTradeViewState();
}
class _BuyTradeViewState extends State<BuyTradeView> {
  final btcAmountController = TextEditingController();
  final nairaAmountController = TextEditingController();
  final usdAmount = TextEditingController();
  String btcAmount = "0.0";
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
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s13.w
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.s8.h,),
            Center(
              child: CustomTextWithLineHeight(
                text: "Buy BTC from ${dashboardViewModel.selectedTrade.user!.firstName!} by ${dashboardViewModel.selectedTrade.paymentMethod!.name}",
                textColor: ColorManager.blckColor,
                fontSize: FontSize.s14,),
            ),

            SizedBox(height: AppSize.s40.h,),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextWithLineHeight(
                        text: AppStrings.sellersRate,
                        textColor: ColorManager.arrowColor,
                      fontSize: FontSize.s14,),
                      SizedBox(height: AppSize.s4.h,),
                      Container(
                        height: AppSize.s35.h,
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(AppSize.s3.r),
                          border: Border.all(
                            color: ColorManager.inputFieldBorder
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: AppSize.s8.w),
                              child: CustomTextWithLineHeight(
                                text: "${dashboardViewModel.selectedTrade.profitMargin}",
                                textColor: ColorManager.blckColor,
                                fontSize: FontSize.s14,),
                            ),

                            const CustomTextWithLineHeight(
                              text: " per NGN",
                              textColor: ColorManager.arrowColor,
                              fontSize: FontSize.s14,)
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                ),
                SizedBox(width: AppSize.s7.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomTextWithLineHeight(
                        text: AppStrings.buyLimit,
                        textColor: ColorManager.arrowColor,
                        fontSize: FontSize.s12,),
                      SizedBox(height: AppSize.s4.h,),
                      Container(
                        height: AppSize.s35.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.s3.r),
                          color: ColorManager.whiteColor,
                          border: Border.all(
                              color: ColorManager.inputFieldBorder
                          ),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: AppSize.s8.w),
                              child: CustomTextWithLineHeight(
                                text: "${moneyFormat.format(dashboardViewModel.selectedTrade.minAmount)}-${moneyFormat.format(dashboardViewModel.selectedTrade.maxAmount)} ${dashboardViewModel.selectedTrade.currency!.code}",
                                textColor: ColorManager.blckColor,
                                fontSize: FontSize.s14,),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                      )
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: AppSize.s10.h,),
            Row(
              children: const [
                CustomTextWithLineHeight(
                  text: AppStrings.iWantToBuyBtc,
                  textColor: ColorManager.blckColor,
                  fontWeight: FontWeightManager.medium,),
              ],
            ),
            SizedBox(height: AppSize.s8.h,),
            Container(
              // height: AppSize.s48.h,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorManager.inputFieldBorder
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s3.r)
              ),
              child: Row(
                children: [
                  Expanded(child:
                  TextFormField(
                    controller: btcAmountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: ColorManager.textFieldColor,
                    autofocus: true,
                    maxLines: 1,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                    style: const TextStyle(
                        color: ColorManager.textFieldColor,
                        fontSize: FontSize.s16
                    ),
                    onChanged: (value)async{
                      if(value.isNotEmpty){
                          btcAmount = value;
                          await dashboardViewModel.getBtcToNairaRate(value);
                          nairaAmountController.text = dashboardViewModel.btcNairaModel == null ? "0.00" : dashboardViewModel.btcNairaModel!.data.naira.toString();
                          setState(() {
                          });
                      }else{
                        nairaAmountController.text = "";
                        setState(() {
                        });
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
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      hintStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16
                      ),
                      labelStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16
                      ),
                      errorStyle: TextStyle(
                          color: ColorManager.redColor,
                          fontSize: FontSize.s16
                      ),
                    ),

                  )
                  ),

                  Container(
                    width: AppSize.s54.w,
                    alignment: Alignment.center,
                    child:
                    const CustomTextWithLineHeight(text: AppStrings.btc, fontSize: FontSize.s15,),
                  )
                ],
              ),
            ),

            SizedBox(height: AppSize.s21.h,),
            Row(
              children: const [
                CustomTextWithLineHeight(
                  text: AppStrings.iWillReceive,
                  textColor: ColorManager.blckColor,
                  fontWeight: FontWeightManager.medium,),
              ],
            ),
            SizedBox(height: AppSize.s8.h,),
            Container(
              // height: AppSize.s48.h,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorManager.inputFieldBorder
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s3.r)
              ),
              child: Row(
                children: [
                  Expanded(child:
                  TextFormField(
                    controller: nairaAmountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    cursorColor: ColorManager.textFieldColor,
                    autofocus: true,

                    maxLines: 1,
                    validator: (value){
                      if(value!.isNotEmpty && double.parse(value.isEmpty ? "0.0" : value) < dashboardViewModel.selectedTrade.minAmount ||
                          double.parse(value.isEmpty ? "0.0" : value) > dashboardViewModel.selectedTrade.maxAmount){
                        return "Between ${dashboardViewModel.selectedTrade.minAmount} and ${dashboardViewModel.selectedTrade.maxAmount}";
                      }
                      return null;
                    },
                    keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                    style: const TextStyle(
                        color: ColorManager.textFieldColor,
                        fontSize: FontSize.s16
                    ),
                    onChanged: (value)async{
                      if(value.isNotEmpty){
                          btcAmount = value;
                         final nairaBtc = await  dashboardViewModel.getNairaToBtcRate(value);
                         print("Naira value: $nairaBtc");
                          btcAmountController.text  =  dashboardViewModel.nairaToBtc!.data.btc.toString();
                          setState(() {
                          });
                      }else{
                        btcAmountController.text =  "";
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
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        gapPadding: 0.0,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(AppSize.s3.r),
                          topLeft: Radius.circular(AppSize.s3.r),
                        ),
                        borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
                            width: 1),
                      ),
                      hintStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16
                      ),
                      labelStyle: const TextStyle(
                          color: ColorManager.labelTextColor,
                          fontSize: FontSize.s16
                      ),
                      errorStyle: TextStyle(
                          color: ColorManager.redColor,
                          fontSize: FontSize.s16
                      ),
                    ),

                  )
                  ),

                  Container(
                    width: AppSize.s54.w,
                    alignment: Alignment.center,
                    child:
                    const CustomTextWithLineHeight(text: AppStrings.ngn, fontSize: FontSize.s15,),
                  )
                ],
              ),
            ),

            SizedBox(height: AppSize.s10.h,),
            Row(
              children: const [
                CustomTextWithLineHeight(
                  text: AppStrings.aboutThisOffer,
                  textColor: ColorManager.blckColor,),
              ],
            ),
            SizedBox(height: AppSize.s15.h,),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 5.h,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s10.r),
                  color: ColorManager.primaryColor,
                  border: Border.all(
                      color: ColorManager.inputFieldBorder
                  )
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s10.w
                ),
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSize.s26.h,),
                    Center(
                      child: Row(
                        children: const [
                          CustomTextWithLineHeight(
                            text: AppStrings.terms,
                            textColor: ColorManager.arrowColor,
                          fontWeight: FontWeightManager.bold,),
                        ],
                      ),
                    ),
                    CustomTextWithLineHeight(
                      text: "${dashboardViewModel.selectedTrade.terms}",
                      textColor: ColorManager.arrowColor,
                      fontWeight: FontWeightManager.regular,),




                    SizedBox(height: AppSize.s17.h,),
                    const CustomTextWithLineHeight(
                      text: AppStrings.tradeTimeLimit,
                      textColor: ColorManager.blckColor,),
                    SizedBox(height: AppSize.s4.h,),

                    const CustomText(text: "90 mins"),

                    SizedBox(height: AppSize.s64.h,),
                    dashboardViewModel.loading ? const Center(child: CupertinoActivityIndicator()) : Consumer<DashboardViewModel2>(
                        builder: (ctx, myAd, child) {
                          WidgetsBinding.instance.
                          addPostFrameCallback((_) {
                            if (myAd.resMessage != '') {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.info(
                                  message: myAd.resMessage,
                                  icon: Container(),
                                  backgroundColor: myAd.isSuccessful ?
                                  ColorManager.deepGreenColor :
                                  ColorManager.primaryColor,
                                ),
                              );
                              ///Clear the response message to avoid duplicate
                              myAd.clear();
                            }
                          });
                          return CustomElevatedButton(
                              onTap: ()async{
                                if(double.parse(nairaAmountController.text.trim().isEmpty ? "0.0" :
                                nairaAmountController.text.trim())
                                    < dashboardViewModel.selectedTrade.minAmount ||
                                    double.parse(nairaAmountController.text.trim().isEmpty ? "0.0" :
                                    nairaAmountController.text.trim())
                                        > dashboardViewModel.selectedTrade.maxAmount){
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.info(
                                      message: "Amount must be Between ${dashboardViewModel.selectedTrade.minAmount} and ${dashboardViewModel.selectedTrade.maxAmount}",
                                      backgroundColor:
                                      ColorManager.primaryColor,
                                    ),
                                  );
                                }else{
                                  dashboardViewModel.changeBtcAmount(btcAmountController.text);
                                  dashboardViewModel.changeNairaAmount(nairaAmountController.text);
                                  print("BTC Amount: ${nairaAmountController.text}");
                                  final isCreated = await dashboardViewModel.initTrade(nairaAmountController.text);

                                  if(isCreated){
                                    Future.delayed(const Duration(seconds: 1), () {
                                      setState(() {
                                        openConfirmBuyTradeView(context);
                                      });

                                    });

                                  }
                                }
                              },
                              backgroundColor: ColorManager.primaryColor,
                              textColor: ColorManager.blackTxtColor,
                              title: AppStrings.buyNow);
                        }
                    ),



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
