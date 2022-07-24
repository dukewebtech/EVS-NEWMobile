import 'dart:async';

import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/re_usable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../resources/styles_manager.dart';

class SetupPin extends StatefulWidget {
  const SetupPin({Key? key}) : super(key: key);

  @override
  State<SetupPin> createState() => _SetupPinState();
}

class _SetupPinState extends State<SetupPin> {

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
      appBar: evsPayCustomAppBar(
          context, AppStrings.back,leadingTap: (){
        Navigator.pop(context);
      }),
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSize.s73.h,),

            Padding(
              padding: EdgeInsets.only(left: AppSize.s30.w, right: AppSize.s30.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: AppSize.s287.w,
                        child: const CustomTextWithLineHeight(text: AppStrings.setUpTransactionPin, textColor: ColorManager.blackTextColor, fontSize: FontSize.s30, fontWeight: FontWeightManager.bold,),),
                    ],
                  ),
                  Row(
                    children: const [
                      SizedBox(
                          child: CustomTextWithLineHeight(text: AppStrings.setUpPinForApp, textColor: ColorManager.semiBlackTextColor, fontWeight: FontWeightManager.regular, fontSize: FontSize.s14,)),
                    ],
                  ),

                  SizedBox(height: AppSize.s40.h,),

                  Center(
                    child: CustomTextWithLineHeight(text: AppStrings.pin, textColor: ColorManager.lightTextColor, fontWeight: FontWeightManager.light, fontSize: FontSize.s15,),
                  ),

                  PinCodeTextField(
                    length: 4,
                    obscureText: true,
                    keyboardType: TextInputType.none,
                    animationType: AnimationType.fade,
                    showCursor: true,
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
                      openConfirmTransactionPin(context);
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
                  ),

                  SizedBox(height: AppSize.s50.h,),
                  CustomElevatedButton(onTap: (){
                    //  route to confirm transaction screen
                    openConfirmTransactionPin(context);
                  }, backgroundColor: ColorManager.primaryColor, textColor: ColorManager.blackTextColor, title: AppStrings.clickToContinue.toUpperCase()),



                  SizedBox(height: AppSize.s18.h,)
                ],
              ),
            ),



          ],
        ),
      )),
    );
  }
}
