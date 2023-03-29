import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/view_models/dashboard_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_text_field_no_border.dart';

class SendTradeView extends StatefulWidget {
  const SendTradeView({Key? key}) : super(key: key);

  @override
  State<SendTradeView> createState() => _SendTradeViewState();
}

class _SendTradeViewState extends State<SendTradeView> {
  final walletAddressController = TextEditingController();
  // final btcAmountController = TextEditingController();

  final nairaAmountController = TextEditingController();
  final btcAmountController = TextEditingController();

  final usdAmountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    var btcAmount = dashboardViewModel.btcToBuy;
    final _formKey = GlobalKey<FormState>();

    final authProvider = context.watch<AuthenticationProvider>();
    // var pay = evs.sendBTC(walletAdresss: walletAdresss, amount: amount, password: password, description: description)
    var amountRecieved =
        nairaAmountController.text.isEmpty ? 0.0 : nairaAmountController.text;

    return Scaffold(
      // appBar: evsPayCustomAppBar(
      //     context, AppStrings.send, isCenterAlign: true,
      //   leadingTap: (){
      //       Navigator.pop(context);
      //   }
      // ),
      body: SafeArea(
          child: SingleChildScrollView(
        /// go through this page properly and ask about the difference in both designs to get clarifications
        padding: EdgeInsets.symmetric(horizontal: AppSize.s20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
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
                      'Send BTC',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lexend',
                        color: Color(0xff3C3C3C),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.s31.h,
              ),

              const Text(
                'Recipient Address',
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
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter wallet address';
                    }
                    if (value.length < 35) {
                      return 'enter a valid address';
                    }
                    return null;
                  },
                  controller: walletAddressController,
                  decoration: InputDecoration(
                    // suffixIcon: const Icon(
                    //   Iconsax.scan,
                    //   color: Color(0xff8a8a8a),
                    // ),

                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: '',
                    // suffixIcon: showSuffixIcon ? Icon() : Container(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
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
                height: AppSize.s20.h,
              ),

              const Text(
                'Amount',
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
              SizedBox(
                width: double.infinity,
                height: 72,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter amount';
                    }
                    if (value.length < 3) {
                      return 'please enter amount';
                    }
                    return null;
                  },
                  controller: btcAmountController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: ColorManager.textFieldColor,
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      decimal: true, signed: false),
                  style: const TextStyle(
                      color: ColorManager.textFieldColor,
                      fontSize: FontSize.s16),
                  onChanged: (value) async {
                    if (value.isNotEmpty) {
                      btcAmount = value;
                      await dashboardViewModel.getNairaToBtcRate(value);
                      nairaAmountController.text =
                          dashboardViewModel.nairaToBtc == null
                              ? "0.00"
                              : dashboardViewModel.nairaToBtc!.data.btc
                                  .toString();
                      setState(() {});
                    } else {
                      nairaAmountController.text = "";
                      setState(() {});
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
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSize.s3.r),
                        topLeft: Radius.circular(AppSize.s3.r),
                      ),
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(AppSize.s3.r),
                        topLeft: Radius.circular(AppSize.s3.r),
                      ),
                      borderSide:
                          const BorderSide(color: Color(0xffF4B731), width: 1),
                    ),
                    hintStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s20),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s16),
                    errorStyle: TextStyle(
                        color: ColorManager.redColor, fontSize: FontSize.s16),
                  ),
                ),
              ),
              // Container(
              //   height: 60,
              //   decoration: BoxDecoration(
              //       border: Border.all(color: ColorManager.inputFieldBorder),
              //       borderRadius: BorderRadius.circular(AppSize.s12.r)),
              //   child: Row(
              //     children: [
              //       Expanded(
              //           child: CustomTextFieldNoBorder(
              //         controller: btcAmountController,
              //         contentPadding: AppSize.s20,
              //       )),
              //       Container(
              //         width: AppSize.s54.w,
              //         alignment: Alignment.center,
              //         child: const CustomTextWithLineHeight(
              //           text: 'NG',
              //           fontSize: FontSize.s15,
              //         ),
              //       )
              //     ],
              //   ),
              // ),

              // SizedBox(
              //   width: double.infinity,
              //   child: TextFormField(
              //     controller: btcAmountController,
              //     decoration: InputDecoration(
              //       filled: false,
              //       counterText: "",
              //       fillColor: ColorManager.whiteColor,
              //       contentPadding: const EdgeInsets.all(10),
              //       hintText: '',
              //       // suffixIcon: showSuffixIcon ? Icon() : Container(),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12.r),
              //         borderSide:
              //             const BorderSide(color: Color(0xffE8E8E8), width: 1),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12.r),
              //         borderSide:
              //             const BorderSide(color: Color(0xffE8E8E8), width: 1),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         gapPadding: 0.0,
              //         borderRadius: BorderRadius.circular(12.r),
              //         borderSide:
              //             const BorderSide(color: Color(0xffE8E8E8), width: 1),
              //       ),
              //       hintStyle: const TextStyle(
              //           color: ColorManager.labelTextColor,
              //           fontSize: FontSize.s16),
              //       labelStyle: const TextStyle(
              //           color: ColorManager.labelTextColor,
              //           fontSize: FontSize.s16),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: AppSize.s10.h,
              // ),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: Card(
                  elevation: 0.5,
                  color: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side:
                        const BorderSide(width: 0.5, color: Color(0xffE8E8E8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${amountRecieved}BTC",
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
                height: AppSize.s10.h,
              ),
              const Text(
                'Description (Optional)',
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

              SizedBox(
                height: 70,
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: false,
                    counterText: "",
                    fillColor: ColorManager.whiteColor,
                    contentPadding: const EdgeInsets.all(10),
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
                        fontSize: FontSize.s20),
                    labelStyle: const TextStyle(
                        color: ColorManager.labelTextColor,
                        fontSize: FontSize.s20),
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.s2.h,
              ),
              // SizedBox(
              //   height: 170,
              //   width: double.infinity,
              //   child: Card(
              //     elevation: 1.0,
              //     color: const Color(0xffffffff),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(11),
              //       side: const BorderSide(width: 0.5, color: Color(0xffE8E8E8)),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.only(left: 18, right: 18, top: 23),
              //       child: Column(
              //         children: const [
              //           TitleAndAmount(
              //             title: 'Amount to debit',
              //             amount: 'NGN 100,000',
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           TitleAndAmount(
              //             title: 'Amount to credit',
              //             amount: '125 BTC',
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           TitleAndAmount(
              //             title: 'Network fees',
              //             amount: '0.3 BTC',
              //           ),
              //           SizedBox(
              //             height: 15,
              //           ),
              //           TitleAndAmount(
              //             title: 'Platform fee',
              //             amount: '\$2',
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: AppSize.s9.h,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Text(
              //       'Total',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.w400,
              //         fontFamily: 'Lexend',
              //         color: Color(0xff000000),
              //       ),
              //     ),
              //     Text(
              //       'NGN 100,000',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //         fontFamily: 'Lexend',
              //         color: Color(0xff020202),
              //       ),
              //     )
              //   ],
              // ),
              SizedBox(
                height: AppSize.s150.h,
              ),

              Center(
                child: CustomElevatedButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        openTransactionPinScreen(context, {
                          'walletAddres': walletAddressController.text.trim(),
                          'amount': btcAmountController.text,
                          'description': descriptionController.text,
                        });
                      }
                    },
                    backgroundColor: ColorManager.primaryColor,
                    textColor: ColorManager.blackTextColor,
                    title: 'Send'),
              ),
              SizedBox(
                height: AppSize.s5.h,
              ),

              /// na here i go stop

              SizedBox(
                height: AppSize.s24.h,
              ),

              const CustomTextWithLineHeight(
                text: AppStrings.recipientBtcAddress,
                fontSize: FontSize.s12,
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),

              CustomTextField(
                controller: walletAddressController,
                hint: AppStrings.walletAddress,
                contentPadding: AppSize.s20,
              ),

              SizedBox(
                height: AppSize.s24.h,
              ),

              SizedBox(
                height: AppSize.s48.h,
              ),
              const CustomTextWithLineHeight(
                text: AppStrings.amt,
                fontSize: FontSize.s12,
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.inputFieldBorder),
                    borderRadius: BorderRadius.circular(AppSize.s3.r)),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFieldNoBorder(
                      controller: btcAmountController,
                      contentPadding: AppSize.s20,
                      hint: AppStrings.amt,
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

              SizedBox(
                height: AppSize.s34.h,
              ),
              const CustomTextWithLineHeight(
                text: AppStrings.amt,
                fontSize: FontSize.s12,
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.inputFieldBorder),
                    borderRadius: BorderRadius.circular(AppSize.s3.r)),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFieldNoBorder(
                      controller: usdAmountController,
                      contentPadding: AppSize.s20,
                      hint: AppStrings.amt,
                    )),
                    Container(
                      width: AppSize.s54.w,
                      alignment: Alignment.center,
                      child: const CustomTextWithLineHeight(
                        text: AppStrings.usd,
                        fontSize: FontSize.s15,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: AppSize.s34.h,
              ),
              const CustomTextWithLineHeight(
                text: AppStrings.descriptionOptional,
                fontSize: FontSize.s12,
              ),
              SizedBox(
                height: AppSize.s8.h,
              ),

              CustomTextField(
                controller: descriptionController,
                hint: AppStrings.descriptionOptional,
                maxLines: 10,
                contentPadding: AppSize.s20,
              ),

              SizedBox(
                height: AppSize.s58.h,
              ),

              CustomElevatedButton(
                  onTap: () {
                    openTransactionPinScreen(context, {});
                  },
                  backgroundColor: ColorManager.primaryColor,
                  textColor: ColorManager.blackTextColor,
                  title: AppStrings.clickToContinue),
              SizedBox(
                height: AppSize.s50.h,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class TitleAndAmount extends StatelessWidget {
  final String title, amount;
  const TitleAndAmount({
    required this.title,
    required this.amount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lexend',
            color: const Color(0xff000000).withOpacity(0.40),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lexend',
            color: const Color(0xff000000).withOpacity(0.69),
          ),
        )
      ],
    );
  }
}
