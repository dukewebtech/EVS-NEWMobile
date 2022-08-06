import 'dart:async';

import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/image_manager.dart';
import '../../../resources/routes_manager.dart';

class VerificationSubmittedView extends StatefulWidget {
  const VerificationSubmittedView({Key? key}) : super(key: key);

  @override
  State<VerificationSubmittedView> createState() => _VerificationSubmittedViewState();
}

class _VerificationSubmittedViewState extends State<VerificationSubmittedView> {
  Timer? _timer;

  _startDelay(){
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }


  _goNext(){
    Navigator.pushReplacementNamed(context, Routes.navScreen);
  }


  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
