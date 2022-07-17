import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/image_manager.dart';

class VerificationSubmittedView extends StatelessWidget {
  const VerificationSubmittedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Center(child: SvgPicture.asset(AppImages.congratulations)),

          SizedBox(height: AppSize.s70.h,),
          
          const CustomTextWithLineHeight(text: AppStrings.submitted,
            textColor: ColorManager.blackTextColor,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s24,
          )
        ],
      )),
    );
  }
}
