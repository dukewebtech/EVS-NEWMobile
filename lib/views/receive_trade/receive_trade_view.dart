import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/custom_app_bar.dart';

class ReceiveTradeView extends StatelessWidget {
  const ReceiveTradeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.receive, isCenterAlign: true,
          leadingTap: (){
            Navigator.pop(context);
          }
      ),
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s26.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

        //        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_outlined, color: Color(0xff292D32),)),
        //         SizedBox(width: AppSize.s8.w,),
        //   const Text('Buy BTC',style: TextStyle(
        //           fontSize: 20,
        //           fontWeight:FontWeight.w700 ,
        //           fontFamily: 'Lexend',
        //           color: Color(0xff424242),
        //
        //
        //         ),),
        //     SizedBox(height: AppSize.s54.h,),
        //                   const Text('Scan this QR Code receive bitcoin',style: TextStyle(
        //                     fontSize: 20,
        //                     fontWeight:FontWeight.w400 ,
        //                     fontFamily: 'Lexend',
        //                     color: Color(0xff000000),
        //
        //
        //                   ), textAlign: TextAlign.center),
        //     SizedBox(height: AppSize.s13.h,),
        // SizedBox(
        //     height: 283,
        //     width: 313,
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 13,left: 16,right: 16),
        //       child: Card(
        //
        //         color: const Color(0xffF6F6F6),
        //         child: Center(
        //           child: QrImage(
        //             data: authProvider.walletData.data!.isEmpty? "0.00" : authProvider.walletData.data![0].receivableAddress!.address!,
        //             version: QrVersions.auto,
        //             size: AppSize.s250.h,
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        //     SizedBox(height: AppSize.s28.h,),
        //     const SizedBox(
        //       height: 52,
        //       width: 313,
        //       child: Padding(
        //         padding: EdgeInsets.only(top: 14,left: 20,right: 20),
        //         child: Card(
        //
        //           color: Color(0xffF6F6F6),
        //           child: Center(
        //             child: Text('0x63802792790427902huhkfjkhjfhjf',style: TextStyle(
        //               fontSize: 16,
        //               fontWeight:FontWeight.w400 ,
        //               fontFamily: 'Lexend',
        //               color: Color(0xff6D6D6D),
        //
        //
        //             ),),
        //
        //           ),
        //         ),
        //       ),
        //     ),
        //     SizedBox(height: AppSize.s28.h,),
        //
        //     Row(
        //       children: [
        //         ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: const Color(0xffF6F6F6),
        //           ),
        //             onPressed: (){}, child: Row(
        //           children: [
        //             const Text('Copy',style: TextStyle(
        //               fontSize: 16,
        //               fontWeight:FontWeight.w400 ,
        //               fontFamily: 'Lexend',
        //               color: Color(0xff6D6D6D),
        //
        //
        //             )),
        //             SizedBox(height: AppSize.s11.h,),
        //             const Icon(Icons.copy,color: Color(0xff6D6D6D),)
        //           ],
        //         )),
        //         ElevatedButton(
        //             style: ElevatedButton.styleFrom(
        //               backgroundColor: const Color(0xffF6F6F6),
        //             ),
        //             onPressed: (){}, child: Row(
        //           children: [
        //             const Text('Share',style:TextStyle(
        //               fontSize: 16,
        //               fontWeight:FontWeight.w400 ,
        //               fontFamily: 'Lexend',
        //               color: Color(0xff6D6D6D),
        //
        //
        //             ) ,),
        //             SizedBox(height: AppSize.s11.h,),
        //             const Icon(Icons.share,color: Color(0xff6D6D6D),)
        //           ],
        //         )),
        //       ],
        //     ),











            /// na here i go stop

            SizedBox(height: AppSize.s80.h,),

            Center(
              child: SizedBox(
                width: AppSize.s186.w,
                child: CustomTextWithLineHeight(
                    text: AppStrings.scanThisQrCode,
                  fontSize: FontSize.s20,
                    fontWeight: FontWeightManager.semiBold,
                  textColor: ColorManager.lightTextColor,
                  alignCenter: true,
                ),
              ),
            ),

            SizedBox(height: AppSize.s39.h,),

            Center(
              child: QrImage(
                data: authProvider.walletData.data!.isEmpty? "0.00" : authProvider.walletData.data![0].receivableAddress!.address!,
                version: QrVersions.auto,
                size: AppSize.s250.h,
              ),
            ),

            SizedBox(height: AppSize.s66.h,),

            const Center(child: CustomTextWithLineHeight(
                text: AppStrings.walletAddress)),

            Center(child: CustomTextWithLineHeight(
                text: authProvider.walletData.data!.isEmpty? "No address" : authProvider.walletData.data![0].receivableAddress!.address!,
            fontSize: FontSize.s12, fontWeight: FontWeightManager.bold,)),

            SizedBox(height: AppSize.s54.h,),

            Row(
              children: [
                CustomElevatedButton(
                    onTap: (){
                      Clipboard.setData(ClipboardData(text: authProvider.walletData.data![0].receivableAddress!.address!));
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message: "Copied ${authProvider.walletData.data![0].receivableAddress!.address!}",
                        ),
                      );
                    },
                    backgroundColor: ColorManager.walletGreenColor,
                    textColor: ColorManager.whiteColor,
                    fontSize: FontSize.s10,
                    width: AppSize.s165,
                    fontWeight: FontWeightManager.regular,
                    title: AppStrings.copyAddressToClipboard),
                SizedBox(width: AppSize.s40.w,),
                CustomElevatedButton(
                    onTap: (){},
                    backgroundColor: ColorManager.walletGreenColor,
                    textColor: ColorManager.whiteColor,
                    fontSize: FontSize.s10,
                    width: AppSize.s114,
                    fontWeight: FontWeightManager.regular,
                    title: AppStrings.saveQrCode)
              ],
            )




          ],
        ),
      )),
    );
  }
}
