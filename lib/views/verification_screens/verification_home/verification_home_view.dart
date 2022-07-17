import 'package:evs_pay_mobile/resources/color_manager.dart';
import 'package:evs_pay_mobile/resources/font_manager.dart';
import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/app_texts/custom_text.dart';
import 'package:evs_pay_mobile/widgets/evs_pay_header_widget.dart';
import 'package:evs_pay_mobile/widgets/verification_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationHomeView extends StatelessWidget {
  const VerificationHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s24.w,
            vertical: AppSize.s30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const EvsPayHeaderWidget(),

            SizedBox(height: AppSize.s20.h,),

            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: AppSize.s146.w,
                  child: const CustomText(text: AppStrings.identityVerification,
                    fontWeight: FontWeightManager.bold, fontSize: FontSize.s14,
                    textColor: ColorManager.blackTextColor,),),
                  
                  SizedBox(height: AppSize.s8.h,),
                  
                  SizedBox(
                    width: AppSize.s146.w,
                    child: const CustomTextWithLineHeight(
                      text: AppStrings.proveYouAreInNigeria,
                      fontSize: FontSize.s14,
                      fontWeight: FontWeightManager.medium,
                    alignCenter: true,
                        textColor: ColorManager.blackTextColor),
                  )
                ],
              ),
            ),
            
            SizedBox(height: AppSize.s11.h,),
            
            const CustomTextWithLineHeight(text: AppStrings.nationality,
              fontSize: FontSize.s14,),

            SizedBox(height: AppSize.s23.h,),

            VerificationItemWidget(
              onTap: (){
                openEmailVerificationScreen(context);
              },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.emailVerification,
                isVerified: false,
                subTitle: AppStrings.aUtilityBillToProof),

            SizedBox(height: AppSize.s20.h),
            VerificationItemWidget(
              onTap: (){
                openPhoneNumberVerificationScreen(context);
              },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.phoneNumberVerification,
                subTitle: AppStrings.aUtilityBillToProof),

            SizedBox(height: AppSize.s20.h),
            VerificationItemWidget(
                onTap: (){
                  openProofOfAddressScreen(context);
                },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.address,
                subTitle: AppStrings.aUtilityBillToProof),

            SizedBox(height: AppSize.s20.h),
            VerificationItemWidget(
                onTap: (){
                  openUploadIdScreen(context);
                },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.identityCard,
                subTitle: AppStrings.issuedInYourCountry),

            SizedBox(height: AppSize.s20.h),
            VerificationItemWidget(
                onTap: (){
                  openTakeSelfieScreen(context);
                },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.takeASelfie,
                subTitle: AppStrings.sendALivePicture)

          ],
        ),
      )),
    );
  }
}
