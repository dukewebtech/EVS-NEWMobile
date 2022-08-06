import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evs_pay_mobile/model/offer_model.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../model/payment_method_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/evs_pay_header_widget.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<OfferModel> displayOffers = [];

  String selectedOption = "";
  bool showFilterOption = false;

  final amountController = TextEditingController();
  final btcValueController = TextEditingController();

  PaymentMethodModel? selectedPaymentMethod;
  String? selectedCoin;

  @override
  void initState() {
    selectedOption = "SELL";

    displayOffers = offers.where((element) => element.offerType.toUpperCase() == "SELL").toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
            child: const EvsPayHeaderWidget(showLeftIcon: false,),
          ),

          SizedBox(height: AppSize.s30.h,),

          Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextWithLineHeight(
                text: AppStrings.totalBalance,
                textColor: ColorManager.blackTextColor,),
              SizedBox(height: AppSize.s12.h,),

              const CustomTextWithLineHeight(
                text: AppStrings.amount,
                textColor: ColorManager.amountColor,
                fontSize: FontSize.s22,
                fontWeight: FontWeightManager.semiBold,),

              CustomTextWithLineHeight(
                text: "${authProvider.walletData.data![0].balance} BTC",
                textColor: ColorManager.blackTextColor,
                fontSize: FontSize.s14,
                fontWeight: FontWeightManager.regular,),

              SizedBox(height: AppSize.s29.h,),

            ],
          ),),

          if(!authProvider.userData.user!.emailVerified! || !authProvider.userData.user!.phoneVerified! ||
              !authProvider.userData.user!.homeVerified! || !authProvider.userData.user!.idCardVerified! ||
              authProvider.userData.user!.photo == null
          )
          Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s12.w),
          child: InkWell(
            onTap: (){
              openVerificationHomeView(context);
            },
            child: Container(
              height: AppSize.s49.h,
              decoration: const BoxDecoration(
                color: ColorManager.verifyContainerColor
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.verifyIconYellow),
                  SizedBox(width: AppSize.s23.w,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        CustomTextWithLineHeight(
                          text: AppStrings.verifyAccount,
                          textColor: ColorManager.blckColor,
                          fontSize: FontSize.s11,),

                        CustomTextWithLineHeight(
                          text: AppStrings.youHaveNotComplete,
                          textColor: ColorManager.arrowColor,
                          fontSize: FontSize.s8,),


                      ],
                    ),
                  ),

                  SvgPicture.asset(AppImages.forwardArrowSvg),
                ],
              )
            ),
          ),),

          SizedBox(
            height: AppSize.s31.h,
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.s23.w),
          child: Container(
            height: AppSize.s39.h,
            decoration: BoxDecoration(color: ColorManager.primaryColor,
            borderRadius: BorderRadius.circular(AppSize.s10.r),
              border: Border.all(color: ColorManager.filterGreyColor)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: selectedOption ==
                        "SELL" ? AppSize.s5.h : 0),
                    child: InkWell(
                      onTap: (){
                        setState(() {

                        });
                        selectedOption = "SELL";
                        displayOffers = offers.where((element) => element.offerType.toUpperCase() == "SELL").toList();
                        showFilterOption = false;
                      },
                      child: Container(
                        height: AppSize.s39.h,
                        decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.only(bottomLeft:
                          Radius.circular(AppSize.s10.r), ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: AppSize.s15.w,),
                            SvgPicture.asset(AppImages.sellIcon),
                            SizedBox(width: AppSize.s8.w,),
                            const CustomTextWithLineHeight(text: AppStrings.sell,
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s15,
                                textColor: ColorManager.blackTxtColor)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: selectedOption == "BUY" ? AppSize.s5.h : 0),
                    child: InkWell(
                      onTap: (){
                        setState(() {

                        });
                        selectedOption = "BUY";
                        displayOffers =  offers.where((element) => element.offerType.toUpperCase() == "BUY").toList();
                        showFilterOption = false;
                      },
                      child: Container(
                        height: AppSize.s39.h,
                        decoration: BoxDecoration(color: ColorManager.whiteColor,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: AppSize.s15.w,),
                            SvgPicture.asset(AppImages.buyIcon),
                            SizedBox(width: AppSize.s8.w,),
                            const CustomTextWithLineHeight(text: AppStrings.buy,
                              fontWeight: FontWeightManager.bold, fontSize: FontSize.s15,
                              textColor: ColorManager.blackTxtColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),


                InkWell(
                  onTap: (){
                    setState(() {

                    });
                    selectedOption = "FILTER";
                    showFilterOption = !showFilterOption;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: selectedOption == "FILTER" && showFilterOption ? AppSize.s5.h : 0),
                    child: Container(
                      height: AppSize.s39.h,
                      width: AppSize.s64.w,
                      decoration: BoxDecoration(
                        color: ColorManager.filterGreyColor,
                        borderRadius: BorderRadius.only(bottomRight:
                        Radius.circular(AppSize.s10.r),)
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(AppImages.filterIcon)
                    ),
                  ),
                ),
              ],
            ),
          ),),

          if(selectedOption == "FILTER" && showFilterOption)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s32.w),
              child: Column(
                children: [
                  SizedBox(height: AppSize.s15.h,),
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
                                  items: paymentMethods
                                      .map((item) => DropdownMenuItem<PaymentMethodModel>(
                                      value: item,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(text: item.method)
                                        ],
                                      )))
                                      .toList(),
                                  value: selectedPaymentMethod,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentMethod = value as PaymentMethodModel;
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
                  SizedBox(height: AppSize.s17.h,),

                  Row(
                    children: [
                      Expanded(child: CustomTextField(controller: amountController, isNumbers: true, hint: "Amount",)),
                      SizedBox(width: AppSize.s19.w,),
                      Expanded(child: CustomTextField(controller: btcValueController, isNumbers: true, isEnabled: false, hint: "BTC Value",)),

                    ],
                  ),
                  SizedBox(height: AppSize.s20.h,),
                  Container(
                    height: AppSize.s40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.circular(AppSize.s4.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppImages.searchIcon),
                        SizedBox(width: AppSize.s5.w,),
                        const CustomText(text: AppStrings.search, fontSize: FontSize.s16, textColor: ColorManager.blackTxtColor,)
                      ],
                    ),
                  )
                ],
              ),
            ),

          SizedBox(height: AppSize.s26.h,),

          Expanded(
              child: ListView.builder(
                itemCount: displayOffers.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index){
                  final offer = displayOffers[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.s12.w
                  ),
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
                                  CustomTextWithLineHeight(text: offer.coinName,
                                  fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.bold,
                                    textColor: ColorManager.blackTxtColor,
                                  ),

                                  CustomTextWithLineHeight(text: offer.paymentMethod,
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
                                CustomTextWithLineHeight(text: offer.nairaValue,
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
                              child: CustomTextWithLineHeight(text: offer.limit,
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
                                  CustomTextWithLineHeight(text: offer.offerType,
                                    fontSize: FontSize.s12,
                                    fontWeight: FontWeightManager.bold,
                                    textColor: ColorManager.blackTxtColor,
                                  ),
                                  
                                  SizedBox(width: AppSize.s5.w,),
                                  
                                  SvgPicture.asset(offer.coinIcon)
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }))
        ],
      ),
    );
  }
}
