import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/app_texts/label_text.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final userNameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s73.h,),

            Center(
              child: SizedBox(height: AppSize.s54.h,
                child: const CustomTextWithLineHeight(text: AppStrings.welcome, textColor: ColorManager.blackTextColor, fontSize: FontSize.s30, fontWeight: FontWeightManager.bold,),),
            ),

            SizedBox(height: AppSize.s58.h,),

            Center(
              child: SizedBox(height: AppSize.s28.h,
                child: const CustomTextWithLineHeight(text: AppStrings.loginBack, textColor: ColorManager.semiBlackTextColor, fontWeight: FontWeightManager.regular, fontSize: FontSize.s18,),),
            ),

            SizedBox(height: AppSize.s40.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
              child: Column(
                children: [
                  const LabelText(text: AppStrings.userNameOrEmail),
                  SizedBox(height: AppSize.s5.h,),

                  CustomTextField(
                    controller: userNameOrEmailController,
                    hint: AppStrings.userNameOrEmail,
                  ),

                  SizedBox(height: AppSize.s32.h,),

                  const LabelText(text: AppStrings.password),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: passwordController,
                    hint: AppStrings.password,
                    obSecureText: true,
                  ),

                  SizedBox(height: AppSize.s32.h,),

                  const CustomTextUnderLined(text: AppStrings.forgotPassword, fontSize: FontSize.s15, textColor: ColorManager.labelTextColor,),

                  SizedBox(height: AppSize.s19.h,),

                  CustomElevatedButton(onTap: (){
                    //  Perform login here

                  }, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.login.toUpperCase()),

                  SizedBox(height: AppSize.s19.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const CustomText(text: AppStrings.donHaveAnAccount, fontSize: FontSize.s18, fontWeight: FontWeightManager.light, textColor: ColorManager.labelTextColor,),
                      SizedBox(width: AppSize.s5.w,),
                      const CustomText(text: AppStrings.signUp, fontSize: FontSize.s18, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor,),

                    ],
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
