import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/verification_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../resources/color_manager.dart';
import '../../../view_models/authentication_view_model/authentication_view_model.dart';

class VerificationHomeView extends StatelessWidget {
  const VerificationHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
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
                if(authProvider.userData.user!.emailVerified!){
                  showTopSnackBar(
                    context,
                    const CustomSnackBar.info(
                      message: AppStrings.emailVerified,
                      backgroundColor:
                      ColorManager.blueColor,
                    ),
                  );
                }else{
                  openEmailVerificationScreen(context);
                }

              },
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.emailVerification,
                isVerified: authProvider.userData.user!.emailVerified!,
                subTitle: AppStrings.aUtilityBillToProof),

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
                return VerificationItemWidget(
                  onTap: (){

                    if(authProvider.userData.user!.phoneVerified!){
                      showTopSnackBar(
                        context,
                        const CustomSnackBar.info(
                          message: AppStrings.phoneVerified,
                          backgroundColor:
                          ColorManager.blueColor,
                        ),
                      );
                    }else{
                      auth.verifyPhoneNumberInit(
                          phoneNumber: auth.userData.user!.phone!,
                          context: context);
                    }

                  },
                    iconName: AppImages.verificationItemsIcon,
                    title: AppStrings.phoneNumberVerification,
                    isVerified: authProvider.userData.user!.phoneVerified!,
                    subTitle: AppStrings.aUtilityBillToProof);
              }
            ),

            SizedBox(height: AppSize.s20.h),
            VerificationItemWidget(
                onTap: (){
                  if(authProvider.userData.user!.homeVerified!){
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.info(
                        message: AppStrings.addressVerified,
                        backgroundColor:
                        ColorManager.blueColor,
                      ),
                    );
                  }else{
                    openProofOfAddressScreen(context);
                  }
                },
                iconName: AppImages.verificationItemsIcon,
                isVerified: authProvider.userData.user!.homeVerified!,
                title: AppStrings.address,
                subTitle: AppStrings.aUtilityBillToProof),

            VerificationItemWidget(
                onTap: (){
                  if(authProvider.userData.user!.idCardVerified!){
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.info(
                        message: AppStrings.idVerified,
                        backgroundColor:
                        ColorManager.blueColor,

                      ),
                    );
                  }else{
                    openUploadIdScreen(context);
                  }

                },
                isVerified: authProvider.userData.user!.idCardVerified!,
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.identityCard,
                subTitle: AppStrings.issuedInYourCountry),

            VerificationItemWidget(
                onTap: (){
                  if(authProvider.userData.user!.photo != null){
                    showTopSnackBar(
                      context,
                      const CustomSnackBar.info(
                        message: AppStrings.selfieVerified,
                        backgroundColor:
                        ColorManager.blueColor,
                      ),
                    );
                  }else{
                    openTakeSelfieScreen(context);
                  }
                },
                isVerified: authProvider.userData.user!.photo != null,
                iconName: AppImages.verificationItemsIcon,
                title: AppStrings.takeAShot,
                subTitle: AppStrings.sendALivePicture)

          ],
        ),
      )),
    );
  }
}
