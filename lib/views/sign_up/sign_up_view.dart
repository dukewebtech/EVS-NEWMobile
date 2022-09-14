import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/app_texts/label_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/custom_text_field.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../view_models/authentication_view_model/authentication_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final userNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final userEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: evsPayCustomAppBar(
          context, AppStrings.back,
          leadingTap: (){
            Navigator.pop(context);
          }),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s73.h,),

            Center(
              child: SizedBox(height: AppSize.s54.h,
                child: const CustomTextWithLineHeight(text: AppStrings.signUp, textColor: ColorManager.blackTextColor, fontSize: FontSize.s30, fontWeight: FontWeightManager.bold,),),
            ),

            SizedBox(height: AppSize.s58.h,),

            Center(
              child: SizedBox(height: AppSize.s28.h,
                child: const CustomTextWithLineHeight(text: AppStrings.createYourEvsAccount, textColor: ColorManager.semiBlackTextColor, fontWeight: FontWeightManager.regular, fontSize: FontSize.s18,),),
            ),

            SizedBox(height: AppSize.s40.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
              child: Column(
                children: [
                  const LabelText(text: AppStrings.userName),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: userNameController,
                    hint: AppStrings.userName,
                  ),

                  SizedBox(height: AppSize.s40.h,),

                  const LabelText(text: AppStrings.email),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: userEmailController,
                    hint: AppStrings.email,
                  ),



                  SizedBox(height: AppSize.s40.h,),

                  const LabelText(text: AppStrings.phone),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: phoneNumberController,
                    hint: AppStrings.phoneNumber,
                    maxLength: 14,
                    isNumbers: true,
                  ),

                  SizedBox(height: AppSize.s40.h,),

                  const LabelText(text: AppStrings.password),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: passwordController,
                    hint: AppStrings.password,
                    obSecureText: true,
                  ),

                  SizedBox(height: AppSize.s40.h,),

                  const LabelText(text: AppStrings.confirmPassword),
                  SizedBox(height: AppSize.s5.h,),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hint: AppStrings.confirmPassword,
                    obSecureText: true,
                  ),

                  SizedBox(height: AppSize.s38.h,),


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
                        //  Perform sign up here
                        if(userNameController.text.trim().isNotEmpty &&
                            userEmailController.text.trim().isNotEmpty &&
                        passwordController.text.trim().isNotEmpty &&
                        confirmPasswordController.text.trim().isNotEmpty &&
                        phoneNumberController.text.trim().isNotEmpty
                        ){
                          auth.registerUser(
                              email: userEmailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context,
                              phone: phoneNumberController.text.trim(),
                              username: userNameController.text);
                        }else if(
                        passwordController.text.trim()
                            != confirmPasswordController.text.trim()
                        ){
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.info(
                              message: AppStrings.passwordMismatch,
                              backgroundColor:
                              ColorManager.primaryColor,
                            ),
                          );
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

                      }, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.signUp.toUpperCase());
                    }
                  ),

                  SizedBox(height: AppSize.s18.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      const CustomText(text: AppStrings.alreadyHaveAnAccount, fontSize: FontSize.s18, fontWeight: FontWeightManager.light, textColor: ColorManager.labelTextColor,),
                      SizedBox(width: AppSize.s5.w,),
                      InkWell(
                        onTap: (){
                          openLoginScreen(context);
                        },
                          child: const CustomText(text: AppStrings.signIn, fontSize: FontSize.s18, fontWeight: FontWeightManager.bold, textColor: ColorManager.primaryColor,)),

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
