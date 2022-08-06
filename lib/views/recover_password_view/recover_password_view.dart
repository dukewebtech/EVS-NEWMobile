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
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../view_models/authentication_view_model/authentication_view_model.dart';

class RecoverPasswordView extends StatefulWidget {
  const RecoverPasswordView({Key? key}) : super(key: key);

  @override
  State<RecoverPasswordView> createState() => _RecoverPasswordViewState();
}

class _RecoverPasswordViewState extends State<RecoverPasswordView> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: evsPayCustomAppBar(
          context, AppStrings.back,
        leadingTap: (){
            Navigator.pop(context);
        }
      ),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s108.h,),
            Center(
              child: SizedBox(height: AppSize.s54.h,
                child: const CustomTextWithLineHeight(text: AppStrings.recoverMyPassword, textColor: ColorManager.blackTextColor, fontSize: FontSize.s28, fontWeight: FontWeightManager.bold,),),
            ),
            SizedBox(height: AppSize.s23.h,),
            Center(
              child: SizedBox(width: AppSize.s315.h,
                child: CustomTextWithLineHeight(text: AppStrings.enterTheEmailAddress, textColor: ColorManager.lightTextColor, fontWeight: FontWeightManager.regular, fontSize: FontSize.s14,),),
            ),
            SizedBox(height: AppSize.s33.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s30.w),
              child: Column(
                children: [
                  CustomTextField(
                    controller: emailController,
                    hint: AppStrings.email,
                  ),
                  SizedBox(height: AppSize.s32.h,),
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
                                backgroundColor: auth.success ?
                                ColorManager.deepGreenColor :
                                ColorManager.primaryColor,
                              ),
                            );

                            ///Clear the response message to avoid duplicate
                            auth.clear();
                          }
                        });
                      return CustomElevatedButton(onTap: (){
                        //  Perform login here
                        if(emailController.text.trim().isNotEmpty){
                          auth.recoverPassword(
                              email: emailController.text.trim(),
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
                      }, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.recoverMyPassword.toUpperCase());
                    }
                  ),
                  SizedBox(height: AppSize.s19.h,),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
