import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({Key? key}) : super(key: key);

  @override
  State<EmailVerificationView> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  final emailEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.back,
      leadingTap: (){
            Navigator.pop(context);
      }),

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height:
              AppSize.s108.h,
            ),

            const CustomTextWithLineHeight(text: AppStrings.emailVerification,
              fontWeight: FontWeightManager.bold, fontSize: FontSize.s30,
              textColor: ColorManager.blackTextColor,),

            SizedBox(height: AppSize.s10.h,),

            SizedBox(
              width: 314,
              child: CustomTextWithLineHeight(
                text: AppStrings.enterTheEmailAddress,
                fontWeight: FontWeightManager.regular, fontSize: FontSize.s14,
                textColor: ColorManager.lightTextColor, alignCenter: true,),
            ),

            SizedBox(height: AppSize.s33.h,),

            CustomTextField(
              hint: AppStrings.email,
              controller: emailEditingController,
              contentPadding: AppSize.s15.h,
            ),

            SizedBox(height: AppSize.s23.h,),

            CustomElevatedButton(onTap: (){},
                backgroundColor: ColorManager.primaryColor,
                textColor: ColorManager.blackTextColor,
                title: AppStrings.resendVerification.toUpperCase())
          ],
        ),
      )),
    );
  }
}
