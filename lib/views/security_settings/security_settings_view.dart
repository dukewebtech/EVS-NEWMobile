import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/font_manager.dart';
import '../../widgets/app_texts/custom_text.dart';

class SecuritySettingsView extends StatefulWidget {
  const SecuritySettingsView({Key? key}) : super(key: key);

  @override
  State<SecuritySettingsView> createState() => _SecuritySettingsViewState();
}

class _SecuritySettingsViewState extends State<SecuritySettingsView> {
  bool isTwoFactorAuth = true;
  bool isAllowBioMetric = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(context, AppStrings.securitySettings,
          isCenterAlign: true, leadingTap: () {
        Navigator.pop(context);
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSize.s24.w, vertical: AppSize.s24.h),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: AppStrings.twoFactorAuth,
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s16,
                          ),
                          SizedBox(
                              width: AppSize.s229.w,
                              child: const CustomTextWithLineHeight(
                                text: AppStrings.with2StepVerification,
                                fontSize: FontSize.s10,
                                textColor: Color.fromRGBO(133, 133, 133, 1),
                              ))
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isTwoFactorAuth = !isTwoFactorAuth;
                          });
                        },
                        child: SvgPicture.asset(isTwoFactorAuth
                            ? AppImages.toggleOn
                            : AppImages.toggleOff)),
                  ],
                ),
                SizedBox(
                  height: AppSize.s24.h,
                ),
                Image.asset(AppImages.divider),
              ],
            ),
            SizedBox(
              height: AppSize.s14.h,
            ),
            InkWell(
              onTap: () {
                openRecoverPassword(context);
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: AppStrings.changePassword,
                              fontWeight: FontWeightManager.medium,
                              fontSize: FontSize.s16,
                            ),
                            SizedBox(
                                width: AppSize.s229.w,
                                child: const CustomTextWithLineHeight(
                                  text: AppStrings
                                      .receiveNotificationsOfNewOnlinePayments,
                                  fontSize: FontSize.s10,
                                  textColor: Color.fromRGBO(133, 133, 133, 1),
                                ))
                          ],
                        ),
                      ),
                      SvgPicture.asset(AppImages.forwardArrowSvg),
                    ],
                  ),
                  SizedBox(
                    height: AppSize.s24.h,
                  ),
                  Image.asset(AppImages.divider),
                ],
              ),
            ),
            SizedBox(
              height: AppSize.s14.h,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: AppStrings.allowBioMetrics,
                            fontWeight: FontWeightManager.medium,
                            fontSize: FontSize.s16,
                          ),
                          SizedBox(
                              width: AppSize.s229.w,
                              child: const CustomTextWithLineHeight(
                                text: AppStrings
                                    .receiveNotificationsOfNewOnlineEscrowReleases,
                                fontSize: FontSize.s10,
                                textColor: Color.fromRGBO(133, 133, 133, 1),
                              ))
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          setState(() {
                            isAllowBioMetric = !isAllowBioMetric;
                          });
                        },
                        child: SvgPicture.asset(isAllowBioMetric
                            ? AppImages.toggleOn
                            : AppImages.toggleOff)),
                  ],
                ),
                SizedBox(
                  height: AppSize.s24.h,
                ),
                Image.asset(AppImages.divider),
              ],
            ),
            SizedBox(
              height: AppSize.s14.h,
            ),
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             const CustomText(text: AppStrings.changePin, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,),
            //             SizedBox(
            //                 width: AppSize.s229.w,
            //                 child: const CustomTextWithLineHeight(text: AppStrings.changeTransactionPin, fontSize: FontSize.s10, textColor: Color.fromRGBO(133, 133, 133, 1),))
            //           ],
            //         ),),
            //         SvgPicture.asset(AppImages.forwardArrowSvg),
            //       ],
            //     ),
            //     SizedBox(height: AppSize.s24.h,),
            //     Image.asset(AppImages.divider),
            //   ],
            // ),
          ],
        ),
      )),
    );
  }
}
