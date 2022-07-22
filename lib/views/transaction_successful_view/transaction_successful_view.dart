import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/image_manager.dart';
import '../../widgets/custom_app_bar.dart';

class TransactionSuccessfulView extends StatelessWidget {
  const TransactionSuccessfulView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.close,
        leadingTap: (){
            openNavScreen(context);
        }
      ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Center(child: SvgPicture.asset(AppImages.congratulations)),

          SizedBox(height: AppSize.s70.h,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: '0.24 BTC ',
                style: TextStyle(
                    color: ColorManager.primaryColor,
                  fontSize: FontSize.s20,
                  fontFamily: FontConstants.fontFamily,
                  fontWeight: FontWeightManager.semiBold
                ),
                children: <TextSpan>[
                  TextSpan(text: "Successfully sent to wallet address  ",
                    style: TextStyle(
                        color: ColorManager.blackTextColor,
                        fontSize: FontSize.s20,
                        fontFamily: FontConstants.fontFamily,
                        fontWeight: FontWeightManager.semiBold
                    ),),
                  TextSpan(text: AppStrings.walletID,
                      style: TextStyle(
                      color: ColorManager.primaryColor,
                      fontSize: FontSize.s20,
                      fontFamily: FontConstants.fontFamily,
                      fontWeight: FontWeightManager.regular
                  ),),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
