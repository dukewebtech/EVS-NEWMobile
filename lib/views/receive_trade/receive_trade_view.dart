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
