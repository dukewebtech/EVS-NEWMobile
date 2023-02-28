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

  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: AppSize.s27.w, right: AppSize.s18.w, bottom: AppSize.s22.h),
      child: Container(
        // padding: EdgeInsets.only(right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 15),
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 15,
                    backgroundImage: AssetImage(AppImages.btc),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.message,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: const TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            color: Color(0xff737373)),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      const Text(
                        '0.89 BTC',
                        style: TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color(0xff000000)),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "${notification.createdAt!.year}-${notification.createdAt!.month < 10 ? "0${notification.createdAt!.month}" : notification.createdAt!.month}-${notification.createdAt!.month < 10 ? "0${notification.createdAt!.month}" : notification.createdAt!.month}",
                        style: const TextStyle(
                            fontFamily: 'Lexend',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color(0xffA7A7A7)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 108,
            //   width: 15,
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10)),
            //     color: Color(0xffF4B731),
            //   ),
            // ),
          ],
        ),
        height: 85,
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
