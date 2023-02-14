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
import '../scan_qr_code/scan_qr_code_view.dart';

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

        //     IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_outlined, color: Color(0xff292D32),)),
        //             SizedBox(width: AppSize.s8.w,),
        //       const Text('Buy BTC',style: TextStyle(
        //               fontSize: 20,
        //               fontWeight:FontWeight.w700 ,
        //               fontFamily: 'Lexend',
        //               color: Color(0xff424242),
        //
        //
        //             ),),
        //     SizedBox(height: AppSize.s31.h,),
        //
        //     const Text('Recipient Address',style: TextStyle(
        //   fontSize: 16,
        //   fontWeight:FontWeight.w400 ,
        //   fontFamily: 'Lexend',
        //   color: Color(0xff000000),
        //
        //
        // ),),
        //     SizedBox(height: AppSize.s15.h,),
        //     SizedBox(
        //       width: double.infinity,
        //       child: TextFormField(
        //         decoration: InputDecoration(
        //           filled: false,
        //           counterText: "",
        //           fillColor: ColorManager.whiteColor,
        //           contentPadding: const EdgeInsets.only(),
        //           hintText: '',
        //           // suffixIcon: showSuffixIcon ? Icon() : Container(),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffF4B731),
        //                 width: 1),
        //           ),
        //           enabledBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffF4B731),
        //                 width: 1),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             gapPadding: 0.0,
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color:Color(0xffF4B731),
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
        //         ),
        //
        //       ),
        //     ),
        //     SizedBox(height: AppSize.s31.h,),
        //     const Text('Amount',style: TextStyle(
        //       fontSize: 16,
        //       fontWeight:FontWeight.w400 ,
        //       fontFamily: 'Lexend',
        //       color: Color(0xff000000),
        //
        //
        //     ),),
        //     SizedBox(height: AppSize.s26.h,),
        //     SizedBox(
        //       width: double.infinity,
        //       child: TextFormField(
        //         decoration: InputDecoration(
        //           filled: false,
        //           counterText: "",
        //           fillColor: ColorManager.whiteColor,
        //           contentPadding: const EdgeInsets.only(),
        //           hintText: '',
        //           // suffixIcon: showSuffixIcon ? Icon() : Container(),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffE8E8E8),
        //                 width: 1),
        //           ),
        //           enabledBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffE8E8E8),
        //                 width: 1),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             gapPadding: 0.0,
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color:Color(0xffE8E8E8),
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
        //         ),
        //
        //       ),
        //     ),
        //     SizedBox(height: AppSize.s13.h,),
        //     const Text('Description ( Optional)',style: TextStyle(
        //       fontSize: 16,
        //       fontWeight:FontWeight.w400 ,
        //       fontFamily: 'Lexend',
        //       color: Color(0xff000000),
        //
        //
        //     ),),
        //     SizedBox(height: AppSize.s13.h,),
        //     SizedBox(
        //       width: double.infinity,
        //       child: TextFormField(
        //         decoration: InputDecoration(
        //           filled: false,
        //           counterText: "",
        //           fillColor: ColorManager.whiteColor,
        //           contentPadding: const EdgeInsets.only(),
        //           hintText: '',
        //           // suffixIcon: showSuffixIcon ? Icon() : Container(),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffE8E8E8),
        //                 width: 1),
        //           ),
        //           enabledBorder: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color: Color(0xffE8E8E8),
        //                 width: 1),
        //           ),
        //           focusedBorder: OutlineInputBorder(
        //             gapPadding: 0.0,
        //             borderRadius: BorderRadius.circular(12.r),
        //             borderSide: const BorderSide(color:Color(0xffE8E8E8),
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
        //         ),
        //
        //       ),
        //     ),
        //     SizedBox(height: AppSize.s30.h,),
        // SizedBox(
        //     height: 188,
        //     width: double.infinity,
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 13,left: 16,right: 16),
        //       child: Card(
        //
        //         color: const Color(0xffffffff),
        //         shape:  RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(11),
        //           side: const BorderSide(width: 0.5,color: Color(0xffE8E8E8)),
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 18,right: 18,top: 17),
        //           child: Column(
        //             children:   const [
        //               TitleAndAmount(
        //                 title: 'Amount to debit',
        //             amount: 'NGN 100,000',
        //           ),
        //               TitleAndAmount(
        //                 title: 'Amount to credit',
        //                 amount: '125 BTC',
        //               ),
        //               TitleAndAmount(
        //                 title: 'Network fees',
        //                 amount: '0.3 BTC',
        //               ),
        //               TitleAndAmount(
        //                 title: 'Platform fee',
        //                 amount: '#2',
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //     SizedBox(height: AppSize.s9.h,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children:  const [
        //     Text('Total',style: TextStyle(
        //       fontSize: 18,
        //       fontWeight:FontWeight.w400 ,
        //       fontFamily: 'Lexend',
        //       color: Color(0xff000000),
        //
        //
        //     ),),
        //     Text('NGN 100,000',style: TextStyle(
        //       fontSize: 14,
        //       fontWeight:FontWeight.w400 ,
        //       fontFamily: 'Lexend',
        //       color: Color(0xff020202),
        //
        //
        //     ),)
        //   ],
        // ),
        //     CustomElevatedButton(
        //         onTap: (){
        //           openTransactionPinScreen(context);
        //         },
        //         backgroundColor: ColorManager.primaryColor,
        //         textColor: ColorManager.blackTextColor,
        //         title: AppStrings.clickToContinue),
        //     SizedBox(height: AppSize.s30.h,),








            /// na here i go stop


            SizedBox(height: AppSize.s24.h,),

            const CustomTextWithLineHeight(text: AppStrings.recipientBtcAddress,
              fontSize: FontSize.s12,),
            SizedBox(height: AppSize.s8.h,),

            CustomTextField(controller: walletAddressController,
            hint: AppStrings.walletAddress,
              contentPadding: AppSize.s20,),

            SizedBox(height: AppSize.s24.h,),
            CustomElevatedButton(onTap: ()async{
              final qrCode = Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const ScanQrCodeView()));

              print("The code is: $qrCode");
            },
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

class TitleAndAmount extends StatelessWidget {
  final String title,amount;
  const TitleAndAmount({
   required  this.title, required this.amount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(title,style: TextStyle(
          fontSize: 14,
          fontWeight:FontWeight.w400 ,
          fontFamily: 'Lexend',
          color: const Color(0xff000000).withOpacity(0.40),


        ),),
        Text(amount,style: TextStyle(
          fontSize: 14,
          fontWeight:FontWeight.w400 ,
          fontFamily: 'Lexend',
          color: Color(0xff000000).withOpacity(0.69),


        ),)
      ],
    );
  }
}
