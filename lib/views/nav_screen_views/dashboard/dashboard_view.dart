import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evs_pay_mobile/model/offer_model.dart';
import 'package:evs_pay_mobile/resources/constants/constants.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/buy_trade_widget.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/filter_trade_widget.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/dashboard/sell_trade_widget.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../model/user_model/api_payment_method_model.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../view_models/dashboard_view_model.dart';
import '../../../view_models/general_view_model.dart';
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

  int sellOrBuyTab = 0;

  String btcAmount = "BTC Value";

  final amountController = TextEditingController();
  final btcValueController = TextEditingController();

  PaymentMethods? selectedPaymentMethod;
  String? selectedCoin;



  @override
  void initState() {
    selectedOption = "SELL";
    sellOrBuyTab = 0;
    displayOffers = offers.where((element) => element.offerType.toUpperCase() == "SELL").toList();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final evsPayVModel = Provider.of<EvsPayViewModel>(context, listen: false);
      final authProvider = Provider.of<AuthenticationProvider>(context, listen: false);
      final dashboardViewModel = Provider.of<DashboardViewModel2>(context, listen: false);
      await authProvider.getWalletAddress(context: context);
      await dashboardViewModel.getBtcToNairaRate(authProvider.walletData.data!.isEmpty? "0.00" : authProvider.walletData.data![0].balance.toString());
      print("Waiting");
      evsPayVModel.getPaymentMethods(context: context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final evsPayViewModel = context.watch<EvsPayViewModel>();
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(
      // backgroundColor: ColorManager.blackTxtColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s25.w),
              child: const EvsPayHeaderWidget(showLeftIcon: true,),
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
                  Consumer<DashboardViewModel2>(
                      builder: (ctx, dashboardViewModel, child) {
                        return CustomTextWithLineHeight(
                          text: "NGN${authProvider.walletData.data!.isEmpty || authProvider.isLoading || dashboardViewModel.loading? "0.00" : dashboardViewModel.btcNairaModel == null
                              ? "0.00" : moneyFormat.format(dashboardViewModel.btcNairaModel!.data.naira)}",
                          textColor: ColorManager.amountColor,
                          fontSize: FontSize.s22,
                          fontWeight: FontWeightManager.semiBold,);
                      }
                  ),
                  CustomTextWithLineHeight(
                    text: authProvider.walletData.data!.isEmpty? "0.00" : "${authProvider.walletData.data![0].balance} BTC",
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
                            sellOrBuyTab = 0;
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
                            sellOrBuyTab = 1;
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
                    SizedBox(height: AppSize.s17.h,),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: amountController,
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
                                final nairaBtc = await  dashboardViewModel.getNairaToBtcRate(value);
                                btcValueController.text= dashboardViewModel.nairaToBtc!.data.btc.toString();
                                print("Naira value: $nairaBtc");
                                setState(() {
                                });
                              }else{
                                btcValueController.text =  "BTC Value";

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

                          ),
                          // CustomTextField(controller: amountController, isNumbers: true, hint: "Amount",)
                        ),
                        SizedBox(width: AppSize.s19.w,),
                        Expanded(child: CustomTextField(controller: btcValueController, isNumbers: true, isEnabled: false, hint: "BTC Value",)),

                      ],
                    ),
                    SizedBox(height: AppSize.s20.h,),
                    InkWell(
                      onTap: (){
                        context.read<DashboardViewModel2>().changeFilteredPageNumber(0);
                        String queryParam = sellOrBuyTab == 0? "?type=buy" : "?type=sell";
                        String paymentMethodParam = selectedPaymentMethod == null ? "" : "&payment_method=${selectedPaymentMethod!.code}";
                        String amountParam = amountController.text.isEmpty ? "" : "&amount=${amountController.text}";
                        queryParam = queryParam + paymentMethodParam + amountParam;
                        print("Query Param: $queryParam");

                        context.read<DashboardViewModel2>().fetchFilteredTrades(queryParam: queryParam);
                      },
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ),

            SizedBox(height: AppSize.s26.h,),

            if(selectedOption ==
                "SELL")
              const SellTradeWidget(),

            if(selectedOption ==
                "BUY")
              const BuyTradeWidget(),
            if(selectedOption ==
                "FILTER")
              const FilterTradeWidget()

          ],
        ),
      ),
    );
  }
}



