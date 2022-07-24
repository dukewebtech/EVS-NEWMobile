import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/verification_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationHomeView extends StatelessWidget {
  const VerificationHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            evsPayCustomAppBar(
                context, AppStrings.verification,
                isCenterAlign: true,
                leadingTap: (){
                  Navigator.pop(context);
                }),

            SizedBox(height: AppSize.s24.h,),

            VerificationItemWidget(
              onTap: (){
                openEmailVerificationScreen(context);
              },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.emailVerification,
                isVerified: true,
                subTitle: AppStrings.aUtilityBillToProof),

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

            VerificationItemWidget(
                onTap: (){
                  openUploadIdScreen(context);
                },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.identityCard,
                subTitle: AppStrings.issuedInYourCountry),

            VerificationItemWidget(
                onTap: (){
                  openTakeSelfieScreen(context);
                },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.takeAShot,
                subTitle: AppStrings.sendALivePicture)

          ],
        ),
      )),
    );
  }
}
