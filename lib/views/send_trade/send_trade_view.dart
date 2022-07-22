import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/strings_manager.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text_field_no_border.dart';

class SendTradeView extends StatefulWidget {
  const SendTradeView({Key? key}) : super(key: key);

  @override
  State<SendTradeView> createState() => _SendTradeViewState();
}

class _SendTradeViewState extends State<SendTradeView> {
  final walletAddressController = TextEditingController();
  final btcAmountController = TextEditingController();
  final usdAmountController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.send, isCenterAlign: true,
        leadingTap: (){
            Navigator.pop(context);
        }
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(height: AppSize.s24.h,),

            const CustomTextWithLineHeight(text: AppStrings.recipientBtcAddress,
              fontSize: FontSize.s12,),
            SizedBox(height: AppSize.s8.h,),

            CustomTextField(controller: walletAddressController,
            hint: AppStrings.walletAddress,
              contentPadding: AppSize.s20,),

            SizedBox(height: AppSize.s24.h,),
            CustomElevatedButton(onTap: (){},
                backgroundColor: ColorManager.primaryColor,
                textColor: ColorManager.blackTxtColor,
                title: AppStrings.scanQrCode,
            isIconButton: true,),

            SizedBox(height: AppSize.s48.h,),
            const CustomTextWithLineHeight(text: AppStrings.amt,
              fontSize: FontSize.s12,),
            SizedBox(height: AppSize.s8.h,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorManager.inputFieldBorder
                ),
                borderRadius: BorderRadius.circular(AppSize.s3.r)
              ),
              child: Row(
                children: [
                  Expanded(child: CustomTextFieldNoBorder(controller: btcAmountController,
                  contentPadding: AppSize.s20,
                  hint: AppStrings.amt,)),

                  Container(
                    width: AppSize.s54.w,
                    alignment: Alignment.center,
                    child: 
                    const CustomTextWithLineHeight(text: AppStrings.btc, fontSize: FontSize.s15,),
                  )
                ],
              ),
            ),

            SizedBox(height: AppSize.s34.h,),
            const CustomTextWithLineHeight(text: AppStrings.amt,
              fontSize: FontSize.s12,),
            SizedBox(height: AppSize.s8.h,),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: ColorManager.inputFieldBorder
                  ),
                  borderRadius: BorderRadius.circular(AppSize.s3.r)
              ),
              child: Row(
                children: [
                  Expanded(child: CustomTextFieldNoBorder(controller: usdAmountController,
                    contentPadding: AppSize.s20,
                    hint: AppStrings.amt,)),

                  Container(
                    width: AppSize.s54.w,
                    alignment: Alignment.center,
                    child:
                    const CustomTextWithLineHeight(text: AppStrings.usd, fontSize: FontSize.s15,),
                  )
                ],
              ),
            ),

            SizedBox(height: AppSize.s34.h,),
            const CustomTextWithLineHeight(text: AppStrings.descriptionOptional,
              fontSize: FontSize.s12,),
            SizedBox(height: AppSize.s8.h,),

            CustomTextField(controller: descriptionController,
              hint: AppStrings.descriptionOptional,
              maxLines: 10,
              contentPadding: AppSize.s20,),

            SizedBox(height: AppSize.s58.h,),

            CustomElevatedButton(
                onTap: (){
                  openTransactionPinScreen(context);
                },
                backgroundColor: ColorManager.primaryColor,
                textColor: ColorManager.blackTextColor,
                title: AppStrings.clickToContinue),

            SizedBox(height: AppSize.s50.h,),


          ],
        ),
      )),
    );
  }
}
