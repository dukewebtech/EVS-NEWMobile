import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evs_pay_mobile/model/create_offer_model.dart';
import 'package:evs_pay_mobile/model/user_model/api_payment_method_model.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/my_ads_view_model.dart';
import 'package:evs_pay_mobile/view_models/nav_screen_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../resources/font_manager.dart';
import '../../../resources/image_manager.dart';
import '../../../view_models/general_view_model.dart';

class CreateOfferView extends StatefulWidget {
  const CreateOfferView({Key? key}) : super(key: key);

  @override
  State<CreateOfferView> createState() => _CreateOfferViewState();
}

class _CreateOfferViewState extends State<CreateOfferView> {
  final locationController = TextEditingController();
  final rateController = TextEditingController();
  final minimumController = TextEditingController();
  final maximumController = TextEditingController();
  final termsOfTradeController = TextEditingController();

  PaymentMethods? selectedPaymentMethod;

  List<Map<String, dynamic>> btnList = [
    {"title": "Buy Bitcoin", "isClicked": false,},
    {"title": "Sell Bitcoin", "isClicked": false,},
  ];


  bool isBuy = true;
  dynamic  changeAll;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeAll = 0;
  }

  @override
  Widget build(BuildContext context) {
    final evsPayViewModel = context.watch<EvsPayViewModel>();
    final myOfferModel = context.watch<MyAdsViewModel>();
    return Scaffold(

      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s13.w),
        child: Column(
          /// i have inserted the sell and buy logic expect for the payment method which might cause and error

        children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_outlined, color: Color(0xff292D32),)),
                  SizedBox(width: AppSize.s3.w,),
                  const Text('Create Offer',style: TextStyle(
                    fontSize: 20,
                    fontWeight:FontWeight.w700 ,
                    fontFamily: 'Lexend',
                    color: Color(0xff606060),


                  ),),
                ],
              ),
            ),

            SizedBox(
              height: 40,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:  btnList.length,
                  itemBuilder: (context, index){
                    var title = btnList[index]['title'];

                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          changeAll = index;

                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.linearToEaseOut,
                        width: 160,
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: changeAll == index
                              ? const Color(0xffF4B731)
                              : Color(0xffEFEFEF),
                          borderRadius: changeAll == index
                              ? BorderRadius.circular(6)
                              : BorderRadius.circular(6),
                        ),
                        child: Center(
                            child: Text(title
                              // btnList[index]["title"],
                            )),
                      ),
                    );

                  }),
            ),
            if(changeAll == 0)

           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Padding(
                 padding: EdgeInsets.only(top: 30),
                 child: Text(
                   'Location',
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.w400,
                     fontFamily: 'Lexend',
                     color: Color(0xffB1B1B1),
                   ),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               SizedBox(
                 width: double.infinity,
                 child: TextFormField(
                   controller: locationController,
                   decoration: InputDecoration(
                     filled: false,
                     counterText: "",
                     fillColor: ColorManager.whiteColor,
                     contentPadding: const EdgeInsets.only(),
                     hintText: '',
                     // suffixIcon: showSuffixIcon ? Icon() : Container(),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     focusedBorder: OutlineInputBorder(
                       gapPadding: 0.0,
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     hintStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                     labelStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                   ),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               const Text(
                 'Payment Method',
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Lexend',
                   color: Color(0xffB1B1B1),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               SizedBox(
                 width: double.infinity,
                 child: TextFormField(
                   decoration: InputDecoration(
                     filled: false,
                     counterText: "",
                     fillColor: ColorManager.whiteColor,
                     contentPadding: const EdgeInsets.only(),
                     hintText: '',
                     // suffixIcon: showSuffixIcon ? Icon() : Container(),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     focusedBorder: OutlineInputBorder(
                       gapPadding: 0.0,
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     hintStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                     labelStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                   ),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               const Text(
                 'Rate',
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Lexend',
                   color: Color(0xffB1B1B1),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               SizedBox(
                 width: double.infinity,
                 child: TextFormField(
                   controller: rateController,
                   decoration: InputDecoration(
                     filled: false,
                     counterText: "",
                     fillColor: ColorManager.whiteColor,
                     contentPadding: const EdgeInsets.only(),
                     hintText: '',
                     // suffixIcon: showSuffixIcon ? Icon() : Container(),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     focusedBorder: OutlineInputBorder(
                       gapPadding: 0.0,
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     hintStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                     labelStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                   ),
                 ),
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,

                     children: [
                       const Text(
                         'Minimum',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.w400,
                           fontFamily: 'Lexend',
                           color: Color(0xffB1B1B1),
                         ),
                       ),
                       SizedBox(
                         height: AppSize.s6.h,
                       ),
                       SizedBox(
                         height: 72,
                         width: 176,
                         child: TextFormField(
                           controller: minimumController,
                           decoration: InputDecoration(
                             filled: false,
                             counterText: "",
                             fillColor: ColorManager.whiteColor,
                             contentPadding: const EdgeInsets.only(),
                             hintText: '',
                             // suffixIcon: showSuffixIcon ? Icon() : Container(),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             focusedBorder: OutlineInputBorder(
                               gapPadding: 0.0,
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             hintStyle: const TextStyle(
                                 color: ColorManager.labelTextColor,
                                 fontSize: FontSize.s16),
                             labelStyle: const TextStyle(
                                 color: ColorManager.labelTextColor,
                                 fontSize: FontSize.s16),
                           ),
                         ),
                       ),
                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       const Text(
                         'Maximum',
                         style: TextStyle(
                           fontSize: 18,
                           fontWeight: FontWeight.w400,
                           fontFamily: 'Lexend',
                           color: Color(0xffB1B1B1),
                         ),
                       ),
                       SizedBox(
                         height: AppSize.s6.h,
                       ),
                       SizedBox(
                         height: 72,
                         width: 176,
                         child: TextFormField(
                           controller: maximumController,
                           decoration: InputDecoration(
                             filled: false,
                             counterText: "",
                             fillColor: ColorManager.whiteColor,
                             contentPadding: const EdgeInsets.only(),
                             hintText: '',
                             // suffixIcon: showSuffixIcon ? Icon() : Container(),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             enabledBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             focusedBorder: OutlineInputBorder(
                               gapPadding: 0.0,
                               borderRadius: BorderRadius.circular(12.r),
                               borderSide: const BorderSide(
                                   color: Color(0xffE8E8E8), width: 1),
                             ),
                             hintStyle: const TextStyle(
                                 color: ColorManager.labelTextColor,
                                 fontSize: FontSize.s16),
                             labelStyle: const TextStyle(
                                 color: ColorManager.labelTextColor,
                                 fontSize: FontSize.s16),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
               SizedBox(
                 height: AppSize.s26.h,
               ),

               const Text(
                 'Terms Of Trade',
                 style: TextStyle(
                   fontSize: 16,
                   fontWeight: FontWeight.w400,
                   fontFamily: 'Lexend',
                   color: Color(0xffB1B1B1),
                 ),
               ),
               SizedBox(
                 height: AppSize.s14.h,
               ),
               SizedBox(
                 width: double.infinity,
                 child: TextFormField(
                   controller: termsOfTradeController,
                   maxLines: 9,

                   decoration: InputDecoration(
                     filled: false,
                     counterText: "",
                     fillColor: ColorManager.whiteColor,
                     contentPadding: const EdgeInsets.only(),
                     hintText: '',
                     // suffixIcon: showSuffixIcon ? Icon() : Container(),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     enabledBorder: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     focusedBorder: OutlineInputBorder(
                       gapPadding: 0.0,
                       borderRadius: BorderRadius.circular(12.r),
                       borderSide:
                       const BorderSide(color: Color(0xffE8E8E8), width: 1),
                     ),
                     hintStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                     labelStyle: const TextStyle(
                         color: ColorManager.labelTextColor,
                         fontSize: FontSize.s16),
                   ),
                 ),
               ),
               SizedBox(
                 height: AppSize.s40.h,
               ),
               Center(
                 child: Consumer<MyAdsViewModel>(builder: (ctx, myAd, child) {
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
                   return SizedBox(
                     height: 50,
                     width: double.infinity,
                     child: ElevatedButton(onPressed:  () async {
                       if (locationController.text.isNotEmpty &&
                           selectedPaymentMethod != null &&
                           rateController.text.isNotEmpty &&
                           minimumController.text.isNotEmpty &&
                           maximumController.text.isNotEmpty &&
                           termsOfTradeController.text.trim().isNotEmpty) {
                         DateTime now = DateTime.now();
                         DateTime expiryDate = now.add(const Duration(days: 30));
                         final createOffer = CreateOfferModel(
                             location: locationController.text,
                             type: isBuy ? "BUY" : "SELL",
                             minAmount: int.parse(minimumController.text.trim()),
                             maxAmount: int.parse(maximumController.text),
                             paymentMethodCode: selectedPaymentMethod!.code!,
                             currencyCode: "NGN",
                             coinSymbol: "btc",
                             tags: ["payment", "special offers"],
                             terms: termsOfTradeController.text,
                             paymentWindow: 90,
                             profitMargin: int.parse(rateController.text),
                             paymentDetails: "",
                             trackLiquidity: false,
                             trustedPeopleOnly: false,
                             expiryDate: expiryDate);

                         myOfferModel.createOfferModel = createOffer;

                         final isCreated = await myOfferModel.createOffer(
                             context: context, createOfferModel: createOffer);

                         print("Is Created: $isCreated");
                         if (isCreated) {
                           Future.delayed(const Duration(seconds: 2), () {
                             setState(() {
                               context
                                   .read<NavScreenViewModel>()
                                   .updateSelectedPage(1);
                               openNavScreen(context);
                             });
                           });
                         }
                       } else {
                         print('Some fields are empty');
                         showTopSnackBar(
                           context,
                           const CustomSnackBar.info(
                             message: AppStrings.fillAllRequiredFields,
                             backgroundColor: ColorManager.primaryColor,
                           ),
                         );
                       }
                     }, child: const Text('Create Offer',style: TextStyle(
                       fontSize: 22,
                       fontWeight: FontWeight.w400,
                       fontFamily: 'Lexend',
                       color: Color(0xff303030)

                     ),)),
                   );


                   // CustomElevatedButton(
                     //   onTap: () async {
                     //     if (locationController.text.isNotEmpty &&
                     //         selectedPaymentMethod != null &&
                     //         rateController.text.isNotEmpty &&
                     //         minimumController.text.isNotEmpty &&
                     //         maximumController.text.isNotEmpty &&
                     //         termsOfTradeController.text.trim().isNotEmpty) {
                     //       DateTime now = DateTime.now();
                     //       DateTime expiryDate = now.add(const Duration(days: 30));
                     //       final createOffer = CreateOfferModel(
                     //           location: locationController.text,
                     //           type: isBuy ? "BUY" : "SELL",
                     //           minAmount: int.parse(minimumController.text.trim()),
                     //           maxAmount: int.parse(maximumController.text),
                     //           paymentMethodCode: selectedPaymentMethod!.code!,
                     //           currencyCode: "NGN",
                     //           coinSymbol: "btc",
                     //           tags: ["payment", "special offers"],
                     //           terms: termsOfTradeController.text,
                     //           paymentWindow: 90,
                     //           profitMargin: int.parse(rateController.text),
                     //           paymentDetails: "",
                     //           trackLiquidity: false,
                     //           trustedPeopleOnly: false,
                     //           expiryDate: expiryDate);
                     //
                     //       myOfferModel.createOfferModel = createOffer;
                     //
                     //       final isCreated = await myOfferModel.createOffer(
                     //           context: context, createOfferModel: createOffer);
                     //
                     //       print("Is Created: $isCreated");
                     //       if (isCreated) {
                     //         Future.delayed(const Duration(seconds: 2), () {
                     //           setState(() {
                     //             context
                     //                 .read<NavScreenViewModel>()
                     //                 .updateSelectedPage(1);
                     //             openNavScreen(context);
                     //           });
                     //         });
                     //       }
                     //     } else {
                     //       print('Some fields are empty');
                     //       showTopSnackBar(
                     //         context,
                     //         const CustomSnackBar.info(
                     //           message: AppStrings.fillAllRequiredFields,
                     //           backgroundColor: ColorManager.primaryColor,
                     //         ),
                     //       );
                     //     }
                     //   },
                     //   backgroundColor: ColorManager.primaryColor,
                     //   textColor: ColorManager.blckColor,
                     //   title: 'Create Offer');
                 }),
               ),
             ],
           ),
            if(changeAll == 1)
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lexend',
                    color: Color(0xffB1B1B1),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: locationController,
                  decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.only(),
                    hintText: '',
                    // suffixIcon: showSuffixIcon ? Icon() : Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    hintStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lexend',
                  color: Color(0xffB1B1B1),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.only(),
                    hintText: '',
                    // suffixIcon: showSuffixIcon ? Icon() : Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    hintStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              const Text(
                'Rate',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lexend',
                  color: Color(0xffB1B1B1),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: rateController,
                  decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.only(),
                    hintText: '',
                    // suffixIcon: showSuffixIcon ? Icon() : Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    hintStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        'Minimum',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lexend',
                          color: Color(0xffB1B1B1),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s6.h,
                      ),
                      SizedBox(
                        height: 72,
                        width: 176,
                        child: TextFormField(
                          controller: minimumController,
                          decoration: InputDecoration(
                            filled: false,
                            counterText: "",
                            fillColor: ColorManager.whiteColor,
                            contentPadding: const EdgeInsets.only(),
                            hintText: '',
                            // suffixIcon: showSuffixIcon ? Icon() : Container(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0.0,
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            hintStyle: const TextStyle(
                                color: ColorManager.labelTextColor,
                                fontSize: FontSize.s16),
                            labelStyle: const TextStyle(
                                color: ColorManager.labelTextColor,
                                fontSize: FontSize.s16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Maximum',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lexend',
                          color: Color(0xffB1B1B1),
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s6.h,
                      ),
                      SizedBox(
                        height: 72,
                        width: 176,
                        child: TextFormField(
                          controller: maximumController,
                          decoration: InputDecoration(
                            filled: false,
                            counterText: "",
                            fillColor: ColorManager.whiteColor,
                            contentPadding: const EdgeInsets.only(),
                            hintText: '',
                            // suffixIcon: showSuffixIcon ? Icon() : Container(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0.0,
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                  color: Color(0xffE8E8E8), width: 1),
                            ),
                            hintStyle: const TextStyle(
                                color: ColorManager.labelTextColor,
                                fontSize: FontSize.s16),
                            labelStyle: const TextStyle(
                                color: ColorManager.labelTextColor,
                                fontSize: FontSize.s16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: AppSize.s26.h,
              ),

              const Text(
                'Terms Of Trade',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Lexend',
                  color: Color(0xffB1B1B1),
                ),
              ),
              SizedBox(
                height: AppSize.s14.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  controller: termsOfTradeController,
                  maxLines: 9,

                  decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.only(),
                    hintText: '',
                    // suffixIcon: showSuffixIcon ? Icon() : Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                      const BorderSide(color: Color(0xffE8E8E8), width: 1),
                    ),
                    hintStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s40.h,
              ),
              Center(
                child: Consumer<MyAdsViewModel>(builder: (ctx, myAd, child) {
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
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(onPressed:  () async {
                      if (locationController.text.isNotEmpty &&
                          selectedPaymentMethod != null &&
                          rateController.text.isNotEmpty &&
                          minimumController.text.isNotEmpty &&
                          maximumController.text.isNotEmpty &&
                          termsOfTradeController.text.trim().isNotEmpty) {
                        DateTime now = DateTime.now();
                        DateTime expiryDate = now.add(const Duration(days: 30));
                        final createOffer = CreateOfferModel(
                            location: locationController.text,
                            type: isBuy ? "BUY" : "SELL",
                            minAmount: int.parse(minimumController.text.trim()),
                            maxAmount: int.parse(maximumController.text),
                            paymentMethodCode: selectedPaymentMethod!.code!,
                            currencyCode: "NGN",
                            coinSymbol: "btc",
                            tags: ["payment", "special offers"],
                            terms: termsOfTradeController.text,
                            paymentWindow: 90,
                            profitMargin: int.parse(rateController.text),
                            paymentDetails: "",
                            trackLiquidity: false,
                            trustedPeopleOnly: false,
                            expiryDate: expiryDate);

                        myOfferModel.createOfferModel = createOffer;

                        final isCreated = await myOfferModel.createOffer(
                            context: context, createOfferModel: createOffer);

                        print("Is Created: $isCreated");
                        if (isCreated) {
                          Future.delayed(const Duration(seconds: 2), () {
                            setState(() {
                              context
                                  .read<NavScreenViewModel>()
                                  .updateSelectedPage(1);
                              openNavScreen(context);
                            });
                          });
                        }
                      } else {
                        print('Some fields are empty');
                        showTopSnackBar(
                          context,
                          const CustomSnackBar.info(
                            message: AppStrings.fillAllRequiredFields,
                            backgroundColor: ColorManager.primaryColor,
                          ),
                        );
                      }
                    }, child: const Text('Create Offer',style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Lexend',
                        color: Color(0xff303030)

                    ),)),
                  );


                  // CustomElevatedButton(
                  //   onTap: () async {
                  //     if (locationController.text.isNotEmpty &&
                  //         selectedPaymentMethod != null &&
                  //         rateController.text.isNotEmpty &&
                  //         minimumController.text.isNotEmpty &&
                  //         maximumController.text.isNotEmpty &&
                  //         termsOfTradeController.text.trim().isNotEmpty) {
                  //       DateTime now = DateTime.now();
                  //       DateTime expiryDate = now.add(const Duration(days: 30));
                  //       final createOffer = CreateOfferModel(
                  //           location: locationController.text,
                  //           type: isBuy ? "BUY" : "SELL",
                  //           minAmount: int.parse(minimumController.text.trim()),
                  //           maxAmount: int.parse(maximumController.text),
                  //           paymentMethodCode: selectedPaymentMethod!.code!,
                  //           currencyCode: "NGN",
                  //           coinSymbol: "btc",
                  //           tags: ["payment", "special offers"],
                  //           terms: termsOfTradeController.text,
                  //           paymentWindow: 90,
                  //           profitMargin: int.parse(rateController.text),
                  //           paymentDetails: "",
                  //           trackLiquidity: false,
                  //           trustedPeopleOnly: false,
                  //           expiryDate: expiryDate);
                  //
                  //       myOfferModel.createOfferModel = createOffer;
                  //
                  //       final isCreated = await myOfferModel.createOffer(
                  //           context: context, createOfferModel: createOffer);
                  //
                  //       print("Is Created: $isCreated");
                  //       if (isCreated) {
                  //         Future.delayed(const Duration(seconds: 2), () {
                  //           setState(() {
                  //             context
                  //                 .read<NavScreenViewModel>()
                  //                 .updateSelectedPage(1);
                  //             openNavScreen(context);
                  //           });
                  //         });
                  //       }
                  //     } else {
                  //       print('Some fields are empty');
                  //       showTopSnackBar(
                  //         context,
                  //         const CustomSnackBar.info(
                  //           message: AppStrings.fillAllRequiredFields,
                  //           backgroundColor: ColorManager.primaryColor,
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   backgroundColor: ColorManager.primaryColor,
                  //   textColor: ColorManager.blckColor,
                  //   title: 'Create Offer');
                }),
              ),
            ],
          ),


            /// na here i go stop
            SizedBox(
              height: AppSize.s42.h,
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           isBuy = true;
            //         });
            //       },
            //       child: Container(
            //         height: AppSize.s32.h,
            //         width: AppSize.s128.w,
            //         decoration: BoxDecoration(
            //           color: isBuy
            //               ? ColorManager.primaryColor
            //               : ColorManager.sellSelectedColor,
            //           borderRadius: BorderRadius.circular(AppSize.s3.r),
            //         ),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const CustomTextWithLineHeight(
            //               text: AppStrings.buyBitcoin,
            //               textColor: ColorManager.blckColor,
            //             ),
            //             SizedBox(
            //               width: AppSize.s5.w,
            //             ),
            //             const Icon(
            //               Icons.arrow_forward,
            //               color: ColorManager.blckColor,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         setState(() {
            //           isBuy = false;
            //         });
            //       },
            //       child: Container(
            //         height: AppSize.s32.h,
            //         width: AppSize.s128.w,
            //         decoration: BoxDecoration(
            //           color: isBuy
            //               ? ColorManager.sellSelectedColor
            //               : ColorManager.primaryColor,
            //           borderRadius: BorderRadius.circular(AppSize.s3),
            //         ),
            //         alignment: Alignment.center,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             const CustomTextWithLineHeight(
            //               text: AppStrings.sellBitcoin,
            //               textColor: ColorManager.blackTxtColor,
            //             ),
            //             SizedBox(
            //               width: AppSize.s5.w,
            //             ),
            //             const Icon(
            //               Icons.arrow_back,
            //               color: ColorManager.blackTxtColor,
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            //
            // SizedBox(
            //   height: AppSize.s18.h,
            // ),
            //
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
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.location,
            //           textColor: ColorManager.blckColor,
            //         ),
            //         SizedBox(
            //           height: AppSize.s5.h,
            //         ),
            //         CustomTextField(
            //           controller: locationController,
            //           hint: AppStrings.inputLocation,
            //         ),
            //         SizedBox(
            //           height: AppSize.s13.h,
            //         ),
            //         const CustomTextWithLineHeight(
            //           text: '${AppStrings.paymentMethod}:',
            //           textColor: ColorManager.blckColor,
            //         ),
            //         SizedBox(
            //           height: AppSize.s4.h,
            //         ),
            //         if (!evsPayViewModel.isLoading)
            //           Row(
            //             children: [
            //               Expanded(
            //                 child: DropdownButtonHideUnderline(
            //                   child: DropdownButton2(
            //                     isExpanded: true,
            //                     hint: Row(
            //                       // ignore: prefer_const_literals_to_create_immutables
            //                       children: [
            //                         const Expanded(
            //                             child: CustomText(
            //                           text: AppStrings.paymentMethod,
            //                         )),
            //                       ],
            //                     ),
            //                     items: evsPayViewModel
            //                         .paymentMethod.paymentMethods
            //                         .map((item) =>
            //                             DropdownMenuItem<PaymentMethods>(
            //                                 value: item,
            //                                 child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment
            //                                           .spaceBetween,
            //                                   children: [
            //                                     CustomText(text: item.name!)
            //                                   ],
            //                                 )))
            //                         .toList(),
            //                     value: selectedPaymentMethod,
            //                     onChanged: (value) {
            //                       setState(() {
            //                         selectedPaymentMethod =
            //                             value as PaymentMethods;
            //                       });
            //                     },
            //                     icon: SvgPicture.asset(AppImages.dropDownIcon),
            //                     iconSize: 14,
            //                     buttonHeight: 50,
            //                     buttonPadding:
            //                         const EdgeInsets.only(left: 14, right: 14),
            //                     buttonDecoration: BoxDecoration(
            //                       borderRadius:
            //                           BorderRadius.circular(AppSize.s6.r),
            //                       border: Border.all(
            //                         color: ColorManager.filterGreyColor,
            //                       ),
            //                       color: ColorManager.whiteColor,
            //                     ),
            //                     itemHeight: 40,
            //                     dropdownPadding: null,
            //                     dropdownDecoration: BoxDecoration(
            //                       borderRadius:
            //                           BorderRadius.circular(AppSize.s4.r),
            //                       color: ColorManager.whiteColor,
            //                     ),
            //                     dropdownElevation: 8,
            //                     selectedItemHighlightColor:
            //                         ColorManager.filterGreyColor,
            //                     scrollbarAlwaysShow: false,
            //                     offset: const Offset(0, 0),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         SizedBox(
            //           height: AppSize.s11.h,
            //         ),
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.rate,
            //           textColor: ColorManager.blckColor,
            //         ),
            //         SizedBox(
            //           height: AppSize.s4.h,
            //         ),
            //         CustomTextField(
            //           controller: rateController,
            //           hint: AppStrings.rate,
            //           isEnabled: true,
            //           isNumbers: true,
            //         ),
            //         SizedBox(
            //           height: AppSize.s11.h,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: const [
            //             CustomTextWithLineHeight(
            //               text: AppStrings.minimum,
            //               textColor: ColorManager.blckColor,
            //             ),
            //             CustomTextWithLineHeight(
            //               text: AppStrings.maximum,
            //               textColor: ColorManager.blckColor,
            //             ),
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Expanded(
            //               child: CustomTextField(
            //                 isNumbers: true,
            //                 controller: minimumController,
            //                 hint: AppStrings.minimum,
            //               ),
            //             ),
            //             Expanded(
            //               child: CustomTextField(
            //                 isNumbers: true,
            //                 controller: maximumController,
            //                 hint: AppStrings.maximum,
            //               ),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           height: AppSize.s11.h,
            //         ),
            //         const CustomTextWithLineHeight(
            //           text: AppStrings.termsOfTrade,
            //           textColor: ColorManager.blckColor,
            //         ),
            //         SizedBox(
            //           height: AppSize.s4.h,
            //         ),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: CustomTextField(
            //                 maxLines: 12,
            //                 controller: termsOfTradeController,
            //                 hint: AppStrings.termsOfTrade,
            //               ),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           height: AppSize.s100.h,
            //         ),
            //         Consumer<MyAdsViewModel>(builder: (ctx, myAd, child) {
            //           WidgetsBinding.instance.addPostFrameCallback((_) {
            //             if (myAd.resMessage != '') {
            //               showTopSnackBar(
            //                 context,
            //                 CustomSnackBar.info(
            //                   message: myAd.resMessage,
            //                   backgroundColor: myAd.isSuccessful
            //                       ? ColorManager.deepGreenColor
            //                       : ColorManager.primaryColor,
            //                 ),
            //               );
            //
            //               ///Clear the response message to avoid duplicate
            //               myAd.clear();
            //             }
            //           });
            //           return CustomElevatedButton(
            //               onTap: () async {
            //                 if (locationController.text.isNotEmpty &&
            //                     selectedPaymentMethod != null &&
            //                     rateController.text.isNotEmpty &&
            //                     minimumController.text.isNotEmpty &&
            //                     maximumController.text.isNotEmpty &&
            //                     termsOfTradeController.text.trim().isNotEmpty) {
            //                   DateTime now = DateTime.now();
            //                   DateTime expiryDate =
            //                       now.add(const Duration(days: 30));
            //                   final createOffer = CreateOfferModel(
            //                       location: locationController.text,
            //                       type: isBuy ? "BUY" : "SELL",
            //                       minAmount:
            //                           int.parse(minimumController.text.trim()),
            //                       maxAmount: int.parse(maximumController.text),
            //                       paymentMethodCode:
            //                           selectedPaymentMethod!.code!,
            //                       currencyCode: "NGN",
            //                       coinSymbol: "btc",
            //                       tags: ["payment", "special offers"],
            //                       terms: termsOfTradeController.text,
            //                       paymentWindow: 90,
            //                       profitMargin: int.parse(rateController.text),
            //                       paymentDetails: "",
            //                       trackLiquidity: false,
            //                       trustedPeopleOnly: false,
            //                       expiryDate: expiryDate);
            //
            //                   myOfferModel.createOfferModel = createOffer;
            //
            //                   final isCreated = await myOfferModel.createOffer(
            //                       context: context,
            //                       createOfferModel: createOffer);
            //
            //                   print("Is Created: $isCreated");
            //                   if (isCreated) {
            //                     Future.delayed(const Duration(seconds: 2), () {
            //                       setState(() {
            //                         context
            //                             .read<NavScreenViewModel>()
            //                             .updateSelectedPage(1);
            //                         openNavScreen(context);
            //                       });
            //                     });
            //                   }
            //                 } else {
            //                   print('Some fields are empty');
            //                   showTopSnackBar(
            //                     context,
            //                     const CustomSnackBar.info(
            //                       message: AppStrings.fillAllRequiredFields,
            //                       backgroundColor: ColorManager.primaryColor,
            //                     ),
            //                   );
            //                 }
            //               },
            //               backgroundColor: ColorManager.primaryColor,
            //               textColor: ColorManager.blckColor,
            //               title: AppStrings.createAnOffer);
            //         }),
            //         SizedBox(
            //           height: AppSize.s48.h,
            //         ),
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
