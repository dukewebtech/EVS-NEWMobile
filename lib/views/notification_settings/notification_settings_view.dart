import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../resources/font_manager.dart';
import '../../resources/image_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/value_manager.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/custom_app_bar.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  bool isNewTradeRequest = true;
  bool isNewDispute = true;
  bool isNewOnlinePayment = true;
  bool isOnlineEscrowRelease = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(
          context, AppStrings.notificationSettings,
          leadingTap: (){
            Navigator.pop(context);
          },
          isCenterAlign: true),

      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: AppSize.s24.w, vertical: AppSize.s24.h),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: AppStrings.newTradeRequest, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,),
                        SizedBox(
                            width: AppSize.s229.w,
                            child: const CustomTextWithLineHeight(text: AppStrings.receiveNotificationOfNewTrade, fontSize: FontSize.s10, textColor: Color.fromRGBO(133, 133, 133, 1),))
                      ],
                    ),),
                    InkWell(
                        onTap: (){
                          setState(() {
                            isNewTradeRequest = !isNewTradeRequest;
                          });
                        },
                        child: SvgPicture.asset(isNewTradeRequest ? AppImages.toggleOn : AppImages.toggleOff)),
                  ],
                ),
                SizedBox(height: AppSize.s14.h,),
                Image.asset(AppImages.divider),
              ],
            ),
            SizedBox(height: AppSize.s14.h,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: AppStrings.newDisputes, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,),
                        SizedBox(
                            width: AppSize.s229.w,
                            child: const CustomTextWithLineHeight(text: AppStrings.receiveNotificationsOfNewDisputes, fontSize: FontSize.s10, textColor: Color.fromRGBO(133, 133, 133, 1),))
                      ],
                    ),),

                    InkWell(
                        onTap: (){
                          setState(() {
                            isNewDispute = !isNewDispute;
                          });
                        },
                        child: SvgPicture.asset(isNewDispute ? AppImages.toggleOn : AppImages.toggleOff)),

                  ],
                ),

                SizedBox(height: AppSize.s14.h,),
                Image.asset(AppImages.divider),
              ],
            ),
            SizedBox(height: AppSize.s14.h,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: AppStrings.newOnlinePayment, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,),
                        SizedBox(
                            width: AppSize.s229.w,
                            child: const CustomTextWithLineHeight(text: AppStrings.receiveNotificationsOfNewOnlinePayments, fontSize: FontSize.s10, textColor: Color.fromRGBO(133, 133, 133, 1),))
                      ],
                    ),),

                    InkWell(
                        onTap: (){
                          setState(() {
                            isNewOnlinePayment = !isNewOnlinePayment;
                          });
                        },
                        child: SvgPicture.asset(isNewOnlinePayment ? AppImages.toggleOn : AppImages.toggleOff)),

                  ],
                ),

                SizedBox(height: AppSize.s14.h,),
                Image.asset(AppImages.divider),
              ],
            ),
            SizedBox(height: AppSize.s14.h,),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(text: AppStrings.onlineEscrowRelease, fontWeight: FontWeightManager.medium, fontSize: FontSize.s16,),
                        SizedBox(
                            width: AppSize.s229.w,
                            child: const CustomTextWithLineHeight(text: AppStrings.receiveNotificationsOfNewOnlineEscrowReleases, fontSize: FontSize.s10, textColor: Color.fromRGBO(133, 133, 133, 1),))
                      ],
                    ),),
                    InkWell(
                        onTap: (){
                          setState(() {
                            isOnlineEscrowRelease = !isOnlineEscrowRelease;
                          });
                        },
                        child: SvgPicture.asset(isOnlineEscrowRelease ? AppImages.toggleOn : AppImages.toggleOff)),
                  ],
                ),
                SizedBox(height: AppSize.s14.h,),
                Image.asset(AppImages.divider),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
