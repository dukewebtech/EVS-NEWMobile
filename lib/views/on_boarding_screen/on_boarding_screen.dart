import 'package:dots_indicator/dots_indicator.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../resources/color_manager.dart';
import '../../resources/constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
                left: 78,
                top:0,
                child: Image.asset(AppImages.greenEth,height: 60,width: 60,)),
            Positioned(
                left: 0,
                top: 10,
                child: Image.asset(AppImages.btc,height: 60,width: 60,)),
            Positioned(
                right: 180,
                top: 56,
                child: Image.asset(AppImages.purpleStack,height: 60,width: 60,)),
            Positioned(
                right: 55,
                top: 26,
                child: Image.asset(AppImages.ligthBlue,height: 60,width: 60,)),
            Positioned(
                left: 86,
                top: 138,
                child: Image.asset(AppImages.movie,height: 60,width: 60,)),
            Positioned(
                right: 0,
                top: 240,
                child: Image.asset(AppImages.fakeBtc,height: 60,width: 60,)),
            Positioned(
                left: 32,
                top: 254,
                child: Image.asset(AppImages.group,height: 60,width: 60,)),
            Positioned(
              left: 30,
              bottom: 80,
              child: Column(
                children: [
                  SizedBox(
                      width: 287.h,
                      child: const CustomTextWithLineHeight(
                        alignCenter: true,
                        text: 'Trade Cryptocurrency from anywhere around the world.', fontWeight: FontWeightManager.bold, fontSize: FontSize.s24, textColor: Color.fromRGBO(81, 81, 81, 1),)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 283.h,
                      child: const CustomTextWithLineHeight(
                        alignCenter: true,
                        text:'Easy, fast, trusted', fontWeight: FontWeightManager.regular, fontSize: FontSize.s20, textColor: Color(0xff696969),)),
                  Center(
                    child: Column(
                      children: [


                        SizedBox(height: AppSize.s33.h,),
                        CustomElevatedButton(onTap: ()async{
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool(showOnBoarding, false);
                          openLoginScreen(context);
                        }, backgroundColor: const Color(0xffF4B731), textColor: Color(0xff1D1D1D), title: 'Get started'),


                        SizedBox(height: AppSize.s25.h,),
                        SizedBox(height: AppSize.s20.h,
                          child: InkWell(
                              onTap: ()async{
                                final prefs = await SharedPreferences.getInstance();
                                prefs.setBool(showOnBoarding, false);
                                openLoginScreen(context);
                              },
                              child: const CustomText(text: AppStrings.skip, textColor: Color(0xff343434), fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,)),),


                        SizedBox(height: AppSize.s50.h,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),

      ),
    );
  }
}








