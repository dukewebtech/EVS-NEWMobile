import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../resources/value_manager.dart';
import 'package:share_plus/share_plus.dart';

class ReceiveTradeView extends StatelessWidget {
  const ReceiveTradeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    

    void shareCode() async {
      Share.share(
        authProvider.walletData.data![0].receivableAddress!.address!,
      );
    }

    return Scaffold(
      // appBar: evsPayCustomAppBar(
      //     context, AppStrings.receive, isCenterAlign: true,
      //     leadingTap: (){
      //       Navigator.pop(context);
      //     }
      // ),
      body: SafeArea(

          /// i have inserted the receive trade logic
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s26.w),
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
                    'Receive',
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
              height: AppSize.s54.h,
            ),
            const Center(
              child: Text('Scan this QR Code receive\n bitcoin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Lexend',
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              height: AppSize.s13.h,
            ),
            Center(
              child: SizedBox(
                height: 250,
                width: 280,
                child: Padding(
                  padding: const EdgeInsets.only(top: 13, left: 16, right: 16),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13)),
                    color: Colors.grey.shade200,
                    child: Center(
                      child: QrImage(
                        backgroundColor: const Color(0xfff6f6f6),
                        data: authProvider.walletData.data!.isEmpty
                            ? "0.00"
                            : authProvider.walletData.data![0]
                                .receivableAddress!.address!,
                        version: QrVersions.auto,
                        size: AppSize.s200.h,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s28.h,
            ),
            SizedBox(
              height: 62,
              width: 347,
              child: Padding(
                padding: const EdgeInsets.only(top: 14, left: 15, right: 15),
                child: Card(
                  elevation: 0.5,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Text(
                        authProvider.walletData.data!.isEmpty
                            ? "No address"
                            : authProvider.walletData.data![0]
                                .receivableAddress!.address!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Lexend',
                          color: Color(0xff6D6D6D),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppSize.s28.h,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF6F6F6),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                          text: authProvider.walletData.data![0]
                              .receivableAddress!.address!));
                      showTopSnackBar(
                        context,
                        CustomSnackBar.info(
                          message:
                              "Copied ${authProvider.walletData.data![0].receivableAddress!.address!}",
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Text('Copy',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Lexend',
                              color: Color(0xff6D6D6D),
                            )),
                        SizedBox(
                          width: AppSize.s6.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.copy,
                            color: Color(0xff6D6D6D),
                            size: 18,
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  width: 28,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF6F6F6),
                    ),
                    onPressed: () {
                      shareCode();
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Share',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Lexend',
                            color: Color(0xff6D6D6D),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.s6.w,
                        ),
                        const Icon(
                          Icons.share,
                          color: Color(0xff6D6D6D),
                          size: 18,
                        )
                      ],
                    )),
              ],
            ),

            /// na here i go stop

            SizedBox(
              height: AppSize.s80.h,
            ),
            //
            // Center(
            //   child: SizedBox(
            //     width: AppSize.s186.w,
            //     child: CustomTextWithLineHeight(
            //         text: AppStrings.scanThisQrCode,
            //       fontSize: FontSize.s20,
            //         fontWeight: FontWeightManager.semiBold,
            //       textColor: ColorManager.lightTextColor,
            //       alignCenter: true,
            //     ),
            //   ),
            // ),
            //
            // SizedBox(height: AppSize.s39.h,),
            //
            // Center(
            //   child: QrImage(
            //     data: authProvider.walletData.data!.isEmpty? "0.00" : authProvider.walletData.data![0].receivableAddress!.address!,
            //     version: QrVersions.auto,
            //     size: AppSize.s250.h,
            //   ),
            // ),
            //
            // SizedBox(height: AppSize.s66.h,),
            //
            // const Center(child: CustomTextWithLineHeight(
            //     text: AppStrings.walletAddress)),
            //
            // Center(child: CustomTextWithLineHeight(
            //     text: authProvider.walletData.data!.isEmpty? "No address" : authProvider.walletData.data![0].receivableAddress!.address!,
            // fontSize: FontSize.s12, fontWeight: FontWeightManager.bold,)),
            //
            // SizedBox(height: AppSize.s54.h,),
            //
            // Row(
            //   children: [
            //     CustomElevatedButton(
            //         onTap: (){
            //           Clipboard.setData(ClipboardData(text: authProvider.walletData.data![0].receivableAddress!.address!));
            //           showTopSnackBar(
            //             context,
            //             CustomSnackBar.info(
            //               message: "Copied ${authProvider.walletData.data![0].receivableAddress!.address!}",
            //             ),
            //           );
            //         },
            //         backgroundColor: ColorManager.walletGreenColor,
            //         textColor: ColorManager.whiteColor,
            //         fontSize: FontSize.s10,
            //         width: AppSize.s165,
            //         fontWeight: FontWeightManager.regular,
            //         title: AppStrings.copyAddressToClipboard),
            //     SizedBox(width: AppSize.s40.w,),
            //     CustomElevatedButton(
            //         onTap: (){},
            //         backgroundColor: ColorManager.walletGreenColor,
            //         textColor: ColorManager.whiteColor,
            //         fontSize: FontSize.s10,
            //         width: AppSize.s114,
            //         fontWeight: FontWeightManager.regular,
            //         title: AppStrings.saveQrCode)
            //   ],
            // )
          ],
        ),
      )),
    );
  }
}
