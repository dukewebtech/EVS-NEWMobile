import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/app_texts/label_text.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../view_models/authentication_view_model/authentication_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    userNameOrEmailController.text = "fhofu@mailto.plus";
    passwordController.text = "smart001";
    // userNameOrEmailController.text = "henrydukus2016@gmail.com";
    // passwordController.text = "password";
    super.initState();
  }
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
              child: const CustomTextWithLineHeight(
                text: AppStrings.welcome,
                textColor: ColorManager.blackTextColor,
                fontSize: FontSize.s30, fontWeight: FontWeightManager.bold,),),
            ),

            SizedBox(height: AppSize.s58.h,),

            Center(
              child: SizedBox(height: AppSize.s28.h,
              child: const CustomTextWithLineHeight(
                text: AppStrings.loginBack,
                textColor: ColorManager.semiBlackTextColor,
                fontWeight: FontWeightManager.regular, fontSize: FontSize.s18,),),
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
                  
                  InkWell(
                    onTap: (){
                      openRecoverPassword(context);
                    },
                      child: const CustomTextUnderLined(
                        text: AppStrings.forgotPassword,
                        fontSize: FontSize.s15,
                        textColor: ColorManager.labelTextColor,)),

                  SizedBox(height: AppSize.s19.h,),

                  Consumer<AuthenticationProvider>(
                      builder: (ctx, auth, child) {
                        WidgetsBinding.instance.
                        addPostFrameCallback((_) {
                          if (auth.resMessage != '') {
                            showTopSnackBar(
                              context,
                              CustomSnackBar.info(
                                message: auth.resMessage,
                                backgroundColor:
                                ColorManager.primaryColor,
                              ),
                            );

                            ///Clear the response message to avoid duplicate
                            auth.clear();
                          }
                        });
                      return CustomElevatedButton(onTap: (){
                      //  Perform login here
                        if(userNameOrEmailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty){
                          auth.loginUser(
                              email: userNameOrEmailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                        }else{
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.info(
                              message: AppStrings.allFieldsRequired,
                              backgroundColor:
                              ColorManager.primaryColor,
                            ),
                          );
                        }
                      }, backgroundColor: ColorManager.primaryColor,
                          textColor: ColorManager.blackTextColor,
                          title: AppStrings.login.toUpperCase());
                    }
                  ),

                  SizedBox(height: AppSize.s19.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const CustomText(
                        text: AppStrings.donHaveAnAccount,
                        fontSize: FontSize.s18,
                        fontWeight: FontWeightManager.light,
                        textColor: ColorManager.labelTextColor,),
                      SizedBox(width: AppSize.s5.w,),
                      InkWell(
                        onTap: (){
                        //  Navigate to sign up screen
                          openSignUp(context);
                        },
                          child: const CustomText(
                            text: AppStrings.signUp,
                            fontSize: FontSize.s18,
                            fontWeight: FontWeightManager.bold,
                            textColor: ColorManager.primaryColor,)),

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
