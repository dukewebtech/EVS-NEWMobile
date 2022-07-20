import 'package:evs_pay_mobile/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const NotificationItem({Key? key, required this.notification}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding:
    EdgeInsets.only(
        left: AppSize.s27.w,
        right: AppSize.s18.w,
        bottom: AppSize.s22.h
    ),
      child: Row(
        children: [
          notification.isRead? const SizedBox(
            height: 20,
            width: 20,
          ) : SvgPicture.asset(AppImages.notificationYellow),
          SizedBox(width: AppSize.s24.w,),
          Expanded(child: Column(
            children: [
              Row(
                children: [
                  CustomTextWithLineHeight(
                    text: notification.userName,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s14,
                    textColor: ColorManager.blackTxtColor,),
                  SizedBox(width: AppSize.s5.w,),
                  CustomTextWithLineHeight(text: notification.intention,
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s14,
                    textColor: ColorManager.blackTxtColor,),
                  SizedBox(width: AppSize.s5.w,),
                  CustomTextWithLineHeight(text: notification.btcValue,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s14,
                    textColor: ColorManager.blackTxtColor,),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextWithLineHeight(
                        text: notification.description,
                        fontSize: FontSize.s12,))],
              ),

              Row(
                children: [
                  Expanded(
                      child: CustomTextWithLineHeight(
                        text: notification.date, fontSize: FontSize.s12,))],
              )
            ],
          ))
        ],
      ),);
  }
}
