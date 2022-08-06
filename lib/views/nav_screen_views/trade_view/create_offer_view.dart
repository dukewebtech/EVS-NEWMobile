import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evs_pay_mobile/model/user_model/api_payment_method_model.dart';
import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final evsPayViewModel = context.watch<EvsPayViewModel>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
        context, AppStrings.createAnOffer,
        isCenterAlign: true,
          leadingTap: (){
          Navigator.pop(context);
          }
      ),

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s13.w
        ),
        child: Column(
          children: [
            SizedBox(height: AppSize.s42.h,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: AppSize.s32.h,
                    width: AppSize.s128.w,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(234, 236, 239, 1),
                      borderRadius: BorderRadius.circular(AppSize.s3),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextWithLineHeight(
                          text: AppStrings.buyBitcoin,
                          textColor: Color.fromRGBO(196, 157, 62, 1),),
                        SizedBox(width: AppSize.s5.w,),
                        
                        const Icon(
                          Icons.arrow_forward,
                          color: Color.fromRGBO(196, 157, 62, 1),)
                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: AppSize.s32.h,
                    width: AppSize.s128.w,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(234, 236, 239, 1),
                      borderRadius: BorderRadius.circular(AppSize.s3),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextWithLineHeight(
                          text: AppStrings.sellBitcoin,
                          textColor: ColorManager.blackTxtColor,),
                        SizedBox(width: AppSize.s5.w,),

                        const Icon(
                          Icons.arrow_back,
                          color: ColorManager.blackTxtColor,)
                      ],
                    ),
                  ),
                ),


              ],
            ),

            SizedBox(height: AppSize.s18.h,),

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
                    const CustomTextWithLineHeight(
                        text: AppStrings.location,
                    textColor: ColorManager.blckColor,),

                    SizedBox(height: AppSize.s5.h,),

                    CustomTextField(
                        controller: locationController,
                      hint: AppStrings.inputLocation,
                    ),

                    SizedBox(height: AppSize.s13.h,),
                    const CustomTextWithLineHeight(
                      text: '${AppStrings.paymentMethod}:',
                      textColor: ColorManager.blckColor,),
                    SizedBox(height: AppSize.s4.h,),

                    if(!evsPayViewModel.isLoading)
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Expanded(
                                      child: CustomText(text: AppStrings.paymentMethod,)),
                                ],
                              ),
                              items: evsPayViewModel.paymentMethod.paymentMethods
                                  .map((item) => DropdownMenuItem<PaymentMethods>(
                                  value: item,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(text: item.name!)
                                    ],
                                  )))
                                  .toList(),
                              value: selectedPaymentMethod,
                              onChanged: (value) {
                                setState(() {
                                  selectedPaymentMethod = value as PaymentMethods;
                                });
                              },
                              icon: SvgPicture.asset(AppImages.dropDownIcon),
                              iconSize: 14,
                              buttonHeight: 50,
                              buttonPadding:
                              const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s6.r),
                                border: Border.all(
                                  color: ColorManager.filterGreyColor,
                                ),
                                color: ColorManager.whiteColor,
                              ),
                              itemHeight: 40,
                              dropdownPadding: null,
                              dropdownDecoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(AppSize.s4.r),
                                color: ColorManager.whiteColor,
                              ),
                              dropdownElevation: 8,
                              selectedItemHighlightColor:
                              ColorManager.filterGreyColor,
                              scrollbarAlwaysShow: false,
                              offset: const Offset(0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),


                    SizedBox(height: AppSize.s11.h,),
                    const CustomTextWithLineHeight(
                      text: AppStrings.rate,
                      textColor: ColorManager.blckColor,),
                    SizedBox(height: AppSize.s4.h,),
                    CustomTextField(
                      controller: rateController,
                      hint: AppStrings.rate,
                      isEnabled: false,
                    ),

                    SizedBox(height: AppSize.s11.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CustomTextWithLineHeight(
                          text: AppStrings.minimum,
                          textColor: ColorManager.blckColor,),

                        CustomTextWithLineHeight(
                          text: AppStrings.maximum,
                          textColor: ColorManager.blckColor,),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Expanded(
                          child: CustomTextField(
                            controller: minimumController,
                            hint: AppStrings.minimum,
                          ),
                        ),

                        Expanded(child: CustomTextField(
                          controller: maximumController,
                          hint: AppStrings.maximum,
                        ),)
                      ],
                    ),

                    SizedBox(height: AppSize.s11.h,),

                    const CustomTextWithLineHeight(
                      text: AppStrings.termsOfTrade,
                      textColor: ColorManager.blckColor,),

                    SizedBox(height: AppSize.s4.h,),

                    Row(
                      children: [
                        Expanded(child: CustomTextField(
                          maxLines: 12,
                          controller: termsOfTradeController,
                          hint: AppStrings.termsOfTrade,
                        ),)
                      ],
                    ),

                    SizedBox(
                      height: AppSize.s100.h,),

                    CustomElevatedButton(onTap: (){},
                        backgroundColor: ColorManager.primaryColor,
                        textColor: ColorManager.blckColor,
                        title: AppStrings.createAnOffer),

                    SizedBox(height: AppSize.s48.h,),


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
