import 'package:evs_pay_mobile/model/notication_model_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/image_manager.dart';
import '../resources/value_manager.dart';
import 'app_texts/custom_text.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModelApi notification;
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
          SvgPicture.asset(AppImages.notificationYellow),
          SizedBox(width: AppSize.s24.w,),
          Expanded(child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CustomTextWithLineHeight(
                      text: notification.message,
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s14,
                      textColor: ColorManager.blackTxtColor,),
                  ),
                  SizedBox(width: AppSize.s5.w,),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: CustomTextWithLineHeight(
                        text: "${notification.createdAt!.year}-${notification.createdAt!.month < 10 ? "0${notification.createdAt!.month}" : notification.createdAt!.month}-${notification.createdAt!.month < 10 ? "0${notification.createdAt!.month}" : notification.createdAt!.month}", fontSize: FontSize.s12,))],
              )
            ],
          ))
        ],
      ),);
  }
}
