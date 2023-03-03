import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../resources/value_manager.dart';
import '../../../view_models/authentication_view_model/authentication_view_model.dart';
import '../../../widgets/app_texts/custom_text.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/re_usable_widgets.dart';

class PhoneNumberVerificationView extends StatefulWidget {
  const PhoneNumberVerificationView({Key? key}) : super(key: key);

  @override
  State<PhoneNumberVerificationView> createState() =>
      _PhoneNumberVerificationViewState();
}

class _PhoneNumberVerificationViewState
    extends State<PhoneNumberVerificationView> {
  late StreamController<ErrorAnimationType> errorController;
  TextEditingController textEditingController = TextEditingController();

  String currentText = "";

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: evsPayCustomAppBar(context, AppStrings.back, leadingTap: () {
        Navigator.pop(context);
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppSize.s73.h,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: AppSize.s30.w, right: AppSize.s30.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: AppSize.s287.w,
                        child: const CustomTextWithLineHeight(
                          text: AppStrings.verifyPhone,
                          textColor: ColorManager.blackTextColor,
                          fontSize: FontSize.s30,
                          fontWeight: FontWeightManager.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                          child: CustomTextWithLineHeight(
                        text: AppStrings.confirmPinForApp,
                        textColor: ColorManager.semiBlackTextColor,
                        fontWeight: FontWeightManager.regular,
                        fontSize: FontSize.s14,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s40.h,
                  ),
                  Center(
                    child: CustomTextWithLineHeight(
                      text: AppStrings.verify.toUpperCase(),
                      textColor: ColorManager.lightTextColor,
                      fontWeight: FontWeightManager.light,
                      fontSize: FontSize.s15,
                    ),
                  ),
                  Consumer<AuthenticationProvider>(builder: (ctx, auth, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (auth.resMessage != '') {
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            message: auth.resMessage,
                            backgroundColor: auth.success
                                ? ColorManager.deepGreenColor
                                : ColorManager.primaryColor,
                          ),
                        );

                        ///Clear the response message to avoid duplicate
                        auth.clear();
                      }
                    });
                    return PinCodeTextField(
                      length: 6,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      showCursor: true,
                      hintCharacter: "-",
                      obscuringCharacter: "-",
                      readOnly: false,
                      textStyle: getCustomTextStyle(
                          fontSize: FontSize.s14.sp,
                          textColor: ColorManager.blackTextColor,
                          fontWeight: FontWeight.w700),
                      autoFocus: true,
                      enableActiveFill: true,
                      cursorColor: ColorManager.blackTextColor,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        inactiveColor: ColorManager.inactiveInputFieldColor,
                        errorBorderColor: ColorManager.errorColor,
                        activeColor: ColorManager.primaryColor,
                        selectedColor: ColorManager.primaryColor,
                        borderRadius: BorderRadius.circular(AppSize.s5.r),
                        fieldHeight: AppSize.s48.h,
                        selectedFillColor: ColorManager.whiteColor,
                        inactiveFillColor: ColorManager.whiteColor,
                        fieldWidth: AppSize.s48.w,
                        activeFillColor: ColorManager.whiteColor,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      onCompleted: (v) async {
                        //  Perform conform Pin here
                        auth.verifyPhoneNumberComplete(
                            otp: currentText, context: context);
                      },
                      onChanged: (value) {
                        // print(value);
                        setState(() {
                          currentText = value;
                        });
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    );
                  }),
                  SizedBox(
                    height: AppSize.s50.h,
                  ),
                  CustomElevatedButton(
                      onTap: () {
                        //  Perform confirm pin at button click
                      },
                      backgroundColor: ColorManager.primaryColor,
                      textColor: ColorManager.blackTextColor,
                      title: AppStrings.verify.toUpperCase()),
                  SizedBox(
                    height: AppSize.s18.h,
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
