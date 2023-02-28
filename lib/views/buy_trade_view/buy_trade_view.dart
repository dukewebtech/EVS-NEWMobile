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
  // final usdAmount = TextEditingController();
  String btcAmount = "0.0";
  String lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure ";
  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s18.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_outlined, color: Color(0xff292D32),)),
                  SizedBox(width: AppSize.s3.w,),
                  const Text('Buy BTC',style: TextStyle(
                    fontSize: 20,
                    fontWeight:FontWeight.w700 ,
                    fontFamily: 'Lexend',
                    color: Color(0xff424242),


                  ),),
                ],
              ),
            ),
             SizedBox(
              height: 86,
              width: double.infinity,
              child: Card(
                elevation: 0.5,

                color: Colors.grey.shade200,
                child: Padding(
                  padding:  EdgeInsets.only(left: 16,top: 18,right: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          /// the reason we have using ? is because if we use ! it throughs a null check operator error
                          Text("${dashboardViewModel.selectedDashboardTrade?.user!.username!}",style: const TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.w400 ,
                            fontFamily: 'Lexend',
                            color: Color(0xff000000),


                          ),),
                          Text("${dashboardViewModel.selectedDashboardTrade?.paymentMethod!.name}",style: const TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.w400 ,
                            fontFamily: 'Lexend',
                            color: Color(0xff969696),


                          ),)
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children:  [
                          const Text('Rate:',style: TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.w400 ,
                            fontFamily: 'Lexend',
                            color: Color(0xff000000),


                          ),),
                          Text("${dashboardViewModel.selectedDashboardTrade?.profitMargin}",style: const TextStyle(
                            fontSize: 16,
                            fontWeight:FontWeight.w400 ,
                            fontFamily: 'Lexend',
                            color: Color(0xff312DA3),


                          ),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: AppSize.s31.h,),
            const Text('I want to buy',style: TextStyle(
              fontSize: 16,
              fontWeight:FontWeight.w400 ,
              fontFamily: 'Lexend',
              color: Color(0xff000000),


            ),),
            SizedBox(height: AppSize.s17.h,),
            SizedBox(
              width: double.infinity,
              height: 72,
              child: TextFormField(
                controller: btcAmountController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: ColorManager.textFieldColor,
                autofocus: true,
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
                  filled: true,
                  counterText: "",
                  fillColor: ColorManager.whiteColor,
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'NGN',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppSize.s3.r),
                      topLeft: Radius.circular(AppSize.s3.r),
                    ),
                    borderSide: const BorderSide(color: Color(0xffF4B731),
                        width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppSize.s3.r),
                      topLeft: Radius.circular(AppSize.s3.r),
                    ),
                    borderSide: const BorderSide(color: Color(0xffF4B731),
                        width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(AppSize.s3.r),
                      topLeft: Radius.circular(AppSize.s3.r),
                    ),
                    borderSide: const BorderSide(color: Color(0xffF4B731),
                        width: 1),
                  ),
                  hintStyle: const TextStyle(
                      color: ColorManager.labelTextColor,
                      fontSize: FontSize.s20
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

              ),
            ),
            SizedBox(height: AppSize.s17.h,),
            const Text('I will Receive',style: TextStyle(
              fontSize: 16,
              fontWeight:FontWeight.w400 ,
              fontFamily: 'Lexend',
              color: Color(0xff000000),


            ),),
            SizedBox(height: AppSize.s17.h,),
            SizedBox(
              height: 80,
              width: double.infinity,
              child: Card(
                elevation: 0.5,

                color: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
                  side: BorderSide(width: 0.5,color: Color(0xffE8E8E8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10,left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('0.877BTC',style: TextStyle(
                        fontSize: 24,
                        fontWeight:FontWeight.w600 ,
                        fontFamily: 'Lexend',
                        color: Color(0xff666666),


                      ),),
                      Text('#89.4',style: TextStyle(
                        fontSize: 16,
                        fontWeight:FontWeight.w400 ,
                        fontFamily: 'Lexend',
                        color: Color(0xffA7A7A7),


                      ),)
                    ],
                  ),
                ),
              ),
            ),
        /// i added this below container so i can understand the"i will receieve properly to know if it's a textfield with container or just a card with a text"
        // Container(
        //     // height: AppSize.s48.h,
        //     decoration: BoxDecoration(
        //         border: Border.all(
        //             color: ColorManager.inputFieldBorder
        //         ),
        //         borderRadius: BorderRadius.circular(AppSize.s3.r)
        //     ),
        //     child: Row(
        //       children: [
        //         Expanded(child:
        //         TextFormField(
        //           controller: nairaAmountController,
        //           autovalidateMode: AutovalidateMode.onUserInteraction,
        //           cursorColor: ColorManager.textFieldColor,
        //           autofocus: true,
        //
        //           maxLines: 1,
        //           validator: (value){
        //             if(value!.isNotEmpty && double.parse(value.isEmpty ? "0.0" : value) < dashboardViewModel.selectedDashboardTrade!.minAmount ||
        //                 double.parse(value.isEmpty ? "0.0" : value) > dashboardViewModel.selectedDashboardTrade!.maxAmount){
        //               return "Between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}";
        //             }
        //             return null;
        //           },
        //           keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
        //           style: const TextStyle(
        //               color: ColorManager.textFieldColor,
        //               fontSize: FontSize.s16
        //           ),
        //           onChanged: (value)async{
        //             if(value.isNotEmpty){
        //                 btcAmount = value;
        //                final nairaBtc = await  dashboardViewModel.getNairaToBtcRate(value);
        //                print("Naira value: $nairaBtc");
        //                 btcAmountController.text  =  dashboardViewModel.nairaToBtc!.data.btc.toString();
        //                 setState(() {
        //                 });
        //             }else{
        //               btcAmountController.text =  "";
        //             }
        //
        //
        //
        //           },
        //           decoration: InputDecoration(
        //             filled: false,
        //             counterText: "",
        //             fillColor: ColorManager.whiteColor,
        //             contentPadding: const EdgeInsets.all(10),
        //             hintText: AppStrings.amt,
        //             border: OutlineInputBorder(
        //               borderRadius: BorderRadius.only(
        //                 bottomLeft: Radius.circular(AppSize.s3.r),
        //                 topLeft: Radius.circular(AppSize.s3.r),
        //               ),
        //               borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
        //                   width: 1),
        //             ),
        //             enabledBorder: OutlineInputBorder(
        //               borderRadius: BorderRadius.only(
        //                 bottomLeft: Radius.circular(AppSize.s3.r),
        //                 topLeft: Radius.circular(AppSize.s3.r),
        //               ),
        //               borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
        //                   width: 1),
        //             ),
        //             focusedBorder: OutlineInputBorder(
        //               gapPadding: 0.0,
        //               borderRadius: BorderRadius.only(
        //                 bottomLeft: Radius.circular(AppSize.s3.r),
        //                 topLeft: Radius.circular(AppSize.s3.r),
        //               ),
        //               borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
        //                   width: 1),
        //             ),
        //             hintStyle: const TextStyle(
        //                 color: ColorManager.labelTextColor,
        //                 fontSize: FontSize.s16
        //             ),
        //             labelStyle: const TextStyle(
        //                 color: ColorManager.labelTextColor,
        //                 fontSize: FontSize.s16
        //             ),
        //             errorStyle: TextStyle(
        //                 color: ColorManager.redColor,
        //                 fontSize: FontSize.s16
        //             ),
        //           ),
        //
        //         ),),],),),
            SizedBox(height: AppSize.s38.h,),
            const Text('Terms',style: TextStyle(
              fontSize: 16,
              fontWeight:FontWeight.w400 ,
              fontFamily: 'Lexend',
              color: Color(0xff000000),


            ),),
            SizedBox(height: AppSize.s15.h,),
             Text(lorem,style:  TextStyle(
              fontSize: 14,
              fontWeight:FontWeight.w400 ,
              fontFamily: 'Lexend',
              color: Colors.black.withOpacity(0.6),



            ),textAlign: TextAlign.center,),
            SizedBox(height: AppSize.s50.h,),


            dashboardViewModel.loading ? const Center(child: CupertinoActivityIndicator()) : Center(
              child: Consumer<DashboardViewModel2>(
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
                              < dashboardViewModel.selectedDashboardTrade!.minAmount ||
                              double.parse(nairaAmountController.text.trim().isEmpty ? "0.0" :
                              nairaAmountController.text.trim())
                                  > dashboardViewModel.selectedDashboardTrade!.maxAmount){
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: "Amount must be Between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}",
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
                        title: 'Buy');
                  }
              ),
            ),














            ///na here my own go stop
            // SizedBox(height: AppSize.s8.h,),
            // Center(
            //   child: CustomTextWithLineHeight(
            //     text: "Buy BTC from ${dashboardViewModel.selectedDashboardTrade!.user!.username!} by ${dashboardViewModel.selectedDashboardTrade!.paymentMethod!.name}",
            //     textColor: ColorManager.blckColor,
            //     fontSize: FontSize.s14,),
            // ),
            //
            // SizedBox(height: AppSize.s40.h,),
            //
            // Row(
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const CustomTextWithLineHeight(
            //             text: AppStrings.sellersRate,
            //             textColor: ColorManager.arrowColor,
            //           fontSize: FontSize.s14,),
            //           SizedBox(height: AppSize.s4.h,),
            //           Container(
            //             height: AppSize.s35.h,
            //             decoration: BoxDecoration(
            //               color: ColorManager.whiteColor,
            //               borderRadius: BorderRadius.circular(AppSize.s3.r),
            //               border: Border.all(
            //                 color: ColorManager.inputFieldBorder
            //               ),
            //             ),
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(left: AppSize.s8.w),
            //                   child: CustomTextWithLineHeight(
            //                     text: "${dashboardViewModel.selectedDashboardTrade!.profitMargin}",
            //                     textColor: ColorManager.blckColor,
            //                     fontSize: FontSize.s14,),
            //                 ),
            //
            //                 const CustomTextWithLineHeight(
            //                   text: " per NGN",
            //                   textColor: ColorManager.arrowColor,
            //                   fontSize: FontSize.s14,)
            //               ],
            //             ),
            //             alignment: Alignment.center,
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: AppSize.s7.w,),
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const CustomTextWithLineHeight(
            //             text: AppStrings.buyLimit,
            //             textColor: ColorManager.arrowColor,
            //             fontSize: FontSize.s12,),
            //           SizedBox(height: AppSize.s4.h,),
            //           Container(
            //             height: AppSize.s35.h,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(AppSize.s3.r),
            //               color: ColorManager.whiteColor,
            //               border: Border.all(
            //                   color: ColorManager.inputFieldBorder
            //               ),
            //             ),
            //             child: Row(
            //               children: [
            //                 Padding(
            //                   padding: EdgeInsets.only(left: AppSize.s8.w),
            //                   child: CustomTextWithLineHeight(
            //                     text: "${moneyFormat.format(dashboardViewModel.selectedDashboardTrade!.minAmount)}-${moneyFormat.format(dashboardViewModel.selectedDashboardTrade!.maxAmount)} ${dashboardViewModel.selectedDashboardTrade!.currency!.code}",
            //                     textColor: ColorManager.blckColor,
            //                     fontSize: FontSize.s14,),
            //                 ),
            //               ],
            //             ),
            //             alignment: Alignment.center,
            //           )
            //         ],
            //       ),
            //     )
            //   ],
            // ),
            //
            // SizedBox(height: AppSize.s10.h,),
            // Row(
            //   children: const [
            //     CustomTextWithLineHeight(
            //       text: AppStrings.iWantToBuyBtc,
            //       textColor: ColorManager.blckColor,
            //       fontWeight: FontWeightManager.medium,),
            //   ],
            // ),
            // SizedBox(height: AppSize.s8.h,),
            // Container(
            //   // height: AppSize.s48.h,
            //   decoration: BoxDecoration(
            //       border: Border.all(
            //           color: ColorManager.inputFieldBorder
            //       ),
            //       borderRadius: BorderRadius.circular(AppSize.s3.r)
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(child:
            //       TextFormField(
            //         controller: btcAmountController,
            //         autovalidateMode: AutovalidateMode.onUserInteraction,
            //         cursorColor: ColorManager.textFieldColor,
            //         autofocus: true,
            //         maxLines: 1,
            //         keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
            //         style: const TextStyle(
            //             color: ColorManager.textFieldColor,
            //             fontSize: FontSize.s16
            //         ),
            //         onChanged: (value)async{
            //           if(value.isNotEmpty){
            //               btcAmount = value;
            //               await dashboardViewModel.getBtcToNairaRate(value);
            //               nairaAmountController.text = dashboardViewModel.btcNairaModel == null ? "0.00" : dashboardViewModel.btcNairaModel!.data.naira.toString();
            //               setState(() {
            //               });
            //           }else{
            //             nairaAmountController.text = "";
            //             setState(() {
            //             });
            //           }
            //
            //
            //         },
            //         decoration: InputDecoration(
            //           filled: false,
            //           counterText: "",
            //           fillColor: ColorManager.whiteColor,
            //           contentPadding: const EdgeInsets.all(10),
            //           hintText: AppStrings.amt,
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //                 width: 1),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //                 width: 1),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             gapPadding: 0.0,
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
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
            //           errorStyle: TextStyle(
            //               color: ColorManager.redColor,
            //               fontSize: FontSize.s16
            //           ),
            //         ),
            //
            //       )
            //       ),
            //
            //       Container(
            //         width: AppSize.s54.w,
            //         alignment: Alignment.center,
            //         child:
            //         const CustomTextWithLineHeight(text: AppStrings.btc, fontSize: FontSize.s15,),
            //       )
            //     ],
            //   ),
            // ),
            //
            // SizedBox(height: AppSize.s21.h,),
            // Row(
            //   children: const [
            //     CustomTextWithLineHeight(
            //       text: AppStrings.iWillReceive,
            //       textColor: ColorManager.blckColor,
            //       fontWeight: FontWeightManager.medium,),
            //   ],
            // ),
            // SizedBox(height: AppSize.s8.h,),
            // Container(
            //   // height: AppSize.s48.h,
            //   decoration: BoxDecoration(
            //       border: Border.all(
            //           color: ColorManager.inputFieldBorder
            //       ),
            //       borderRadius: BorderRadius.circular(AppSize.s3.r)
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(child:
            //       TextFormField(
            //         controller: nairaAmountController,
            //         autovalidateMode: AutovalidateMode.onUserInteraction,
            //         cursorColor: ColorManager.textFieldColor,
            //         autofocus: true,
            //
            //         maxLines: 1,
            //         validator: (value){
            //           if(value!.isNotEmpty && double.parse(value.isEmpty ? "0.0" : value) < dashboardViewModel.selectedDashboardTrade!.minAmount ||
            //               double.parse(value.isEmpty ? "0.0" : value) > dashboardViewModel.selectedDashboardTrade!.maxAmount){
            //             return "Between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}";
            //           }
            //           return null;
            //         },
            //         keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
            //         style: const TextStyle(
            //             color: ColorManager.textFieldColor,
            //             fontSize: FontSize.s16
            //         ),
            //         onChanged: (value)async{
            //           if(value.isNotEmpty){
            //               btcAmount = value;
            //              final nairaBtc = await  dashboardViewModel.getNairaToBtcRate(value);
            //              print("Naira value: $nairaBtc");
            //               btcAmountController.text  =  dashboardViewModel.nairaToBtc!.data.btc.toString();
            //               setState(() {
            //               });
            //           }else{
            //             btcAmountController.text =  "";
            //           }
            //
            //
            //
            //         },
            //         decoration: InputDecoration(
            //           filled: false,
            //           counterText: "",
            //           fillColor: ColorManager.whiteColor,
            //           contentPadding: const EdgeInsets.all(10),
            //           hintText: AppStrings.amt,
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //                 width: 1),
            //           ),
            //           enabledBorder: OutlineInputBorder(
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
            //                 width: 1),
            //           ),
            //           focusedBorder: OutlineInputBorder(
            //             gapPadding: 0.0,
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.circular(AppSize.s3.r),
            //               topLeft: Radius.circular(AppSize.s3.r),
            //             ),
            //             borderSide: const BorderSide(color: ColorManager.inactiveInputFieldColor,
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
            //           errorStyle: TextStyle(
            //               color: ColorManager.redColor,
            //               fontSize: FontSize.s16
            //           ),
            //         ),
            //
            //       )
            //       ),
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
            //
            // SizedBox(height: AppSize.s10.h,),
            // Row(
            //   children: const [
            //     CustomTextWithLineHeight(
            //       text: AppStrings.aboutThisOffer,
            //       textColor: ColorManager.blckColor,),
            //   ],
            // ),
            // SizedBox(height: AppSize.s15.h,),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.only(
            //     top: 5.h,
            //   ),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(AppSize.s10.r),
            //       color: ColorManager.primaryColor,
            //       border: Border.all(
            //           color: ColorManager.inputFieldBorder
            //       )
            //   ),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //         horizontal: AppSize.s10.w
            //     ),
            //     decoration: BoxDecoration(
            //       color: ColorManager.whiteColor,
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         SizedBox(height: AppSize.s26.h,),
            //         Center(
            //           child: Row(
            //             children: const [
            //               CustomTextWithLineHeight(
            //                 text: AppStrings.terms,
            //                 textColor: ColorManager.arrowColor,
            //               fontWeight: FontWeightManager.bold,),
            //             ],
            //           ),
            //         ),
            //         CustomTextWithLineHeight(
            //           text: "${dashboardViewModel.selectedDashboardTrade!.terms}",
            //           textColor: ColorManager.arrowColor,
            //           fontWeight: FontWeightManager.regular,),
            //
            //
            //
            //
            //         SizedBox(height: AppSize.s17.h,),
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.tradeTimeLimit,
            //           textColor: ColorManager.blckColor,),
            //         SizedBox(height: AppSize.s4.h,),
            //
            //         const CustomText(text: "90 mins"),
            //
            //         SizedBox(height: AppSize.s64.h,),
            //         dashboardViewModel.loading ? const Center(child: CupertinoActivityIndicator()) : Consumer<DashboardViewModel2>(
            //             builder: (ctx, myAd, child) {
            //               WidgetsBinding.instance.
            //               addPostFrameCallback((_) {
            //                 if (myAd.resMessage != '') {
            //                   showTopSnackBar(
            //                     context,
            //                     CustomSnackBar.info(
            //                       message: myAd.resMessage,
            //                       icon: Container(),
            //                       backgroundColor: myAd.isSuccessful ?
            //                       ColorManager.deepGreenColor :
            //                       ColorManager.primaryColor,
            //                     ),
            //                   );
            //                   ///Clear the response message to avoid duplicate
            //                   myAd.clear();
            //                 }
            //               });
            //               return CustomElevatedButton(
            //                   onTap: ()async{
            //                     if(double.parse(nairaAmountController.text.trim().isEmpty ? "0.0" :
            //                     nairaAmountController.text.trim())
            //                         < dashboardViewModel.selectedDashboardTrade!.minAmount ||
            //                         double.parse(nairaAmountController.text.trim().isEmpty ? "0.0" :
            //                         nairaAmountController.text.trim())
            //                             > dashboardViewModel.selectedDashboardTrade!.maxAmount){
            //                       showTopSnackBar(
            //                         context,
            //                         CustomSnackBar.info(
            //                           message: "Amount must be Between ${dashboardViewModel.selectedDashboardTrade!.minAmount} and ${dashboardViewModel.selectedDashboardTrade!.maxAmount}",
            //                           backgroundColor:
            //                           ColorManager.primaryColor,
            //                         ),
            //                       );
            //                     }else{
            //                       dashboardViewModel.changeBtcAmount(btcAmountController.text);
            //                       dashboardViewModel.changeNairaAmount(nairaAmountController.text);
            //                       print("BTC Amount: ${nairaAmountController.text}");
            //                       final isCreated = await dashboardViewModel.initTrade(nairaAmountController.text);
            //
            //                       if(isCreated){
            //                         Future.delayed(const Duration(seconds: 1), () {
            //                           setState(() {
            //                             openConfirmBuyTradeView(context);
            //                           });
            //
            //                         });
            //
            //                       }
            //                     }
            //                   },
            //                   backgroundColor: ColorManager.primaryColor,
            //                   textColor: ColorManager.blackTxtColor,
            //                   title: AppStrings.buyNow);
            //             }
            //         ),
            //
            //
            //
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
