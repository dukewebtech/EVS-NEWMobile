import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/evs_pay_header_widget.dart';
import 'package:evs_pay_mobile/widgets/transaction_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/transaction_history_model.dart';
import '../../../model/transaction_type_model.dart';
import '../../../resources/font_manager.dart';

class WalletView extends StatefulWidget {
  const WalletView({Key? key}) : super(key: key);

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {

  int index = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: const Color.fromRGBO(248, 248, 248, 1),
              height: AppSize.s229.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s14.w),
                    child: const EvsPayHeaderWidget(
                      title: AppStrings.wallet,
                      isWallet: true,
                      leftIcon: AppImages.backButton,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s40.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextWithLineHeight(
                          text: AppStrings.totalBalance,
                          textColor: ColorManager.blackTextColor,),
                        SizedBox(height: AppSize.s12.h,),

                        const CustomTextWithLineHeight(
                          text: AppStrings.amount,
                          textColor: ColorManager.blackTextColor,
                          fontSize: FontSize.s22,
                          fontWeight: FontWeightManager.bold,),

                        const CustomTextWithLineHeight(
                          text: AppStrings.bitCoinAmount,
                          textColor: ColorManager.blackTextColor,
                          fontSize: FontSize.s14,
                          fontWeight: FontWeightManager.regular,),

                        SizedBox(height: AppSize.s21.h,),
                        SizedBox(
                          // width: AppSize.s300.w,
                          height: AppSize.s28.h,
                          child: ListView.builder(
                              itemCount: transactionTypes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index){
                                final transaction = transactionTypes[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: AppSize.s10.w
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      if(index == 0){
                                        openSendTradeScreen(context);
                                      }else{
                                        openReceiveTradeScreen(context);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: AppSize.s24.w,
                                          vertical: AppSize.s5.h
                                      ),
                                      height: AppSize.s28.h,
                                      width: AppSize.s100.w,
                                      decoration: BoxDecoration(
                                          color: transaction.containerColor,
                                        borderRadius: BorderRadius.circular(AppSize.s4.r)
                                      ),
                                      child: CustomTextWithLineHeight(text: transaction.title, textColor: transaction.textColor,),

                                    ),
                                  ),
                                );
                              }),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: ColorManager.whiteColor,
                // height: AppSize.s40.h,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s27.w, vertical: AppSize.s18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomTextWithLineHeight(text: AppStrings.transactionHistory, fontSize: FontSize.s18,),
                      PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      CustomTextWithLineHeight(text: AppStrings.pending),
                                    ],
                                  ),
                                  SizedBox(height: AppSize.s13.h,),
                                  SvgPicture.asset(AppImages.popupMenuIcon),
                                ],
                              ),
                              value: 1,
                              onTap: (){
                                // print("pending");
                              },
                            ),
                            PopupMenuItem(
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      CustomTextWithLineHeight(text: AppStrings.completed),
                                    ],
                                  ),
                                  SizedBox(height: AppSize.s13.h,),
                                  SvgPicture.asset(AppImages.popupMenuIcon),
                                ],
                              ),
                              value: 1,
                              onTap: (){
                                // print("pending");
                              },
                            ),

                            PopupMenuItem(
                              child: Column(
                                children: const [
                                  CustomTextWithLineHeight(text: AppStrings.cancelled),

                                ],
                              ),
                              value: 1,
                              onTap: (){
                                // print("pending");
                              },
                            ),
                          ]
                      )
                    ],
                  ),
                )),
            Expanded(
                child: Container(
              color: ColorManager.whiteColor,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: transactionHistories.length,
                      itemBuilder: (context, index){
                      final transaction = transactionHistories[index];
                    return TransactionHistoryItem(transaction: transaction);
                  }),
            ))
          ],
        ),
      ),
    );
  }
}
