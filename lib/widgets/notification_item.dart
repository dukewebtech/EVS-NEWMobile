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
              ),
              /// this is the widget for the notification
              // Container(
              //   child: Stack(
              //     children:  [
              //       const Positioned(
              //           left: 13,
              //           top: 20,
              //           child:  CircleAvatar(
              //             backgroundColor: Colors.red,
              //           )),
              //       Positioned(
              //         top: 12,
              //         left: 70,
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: const [
              //             Text('Someone just sent you',style: TextStyle(
              //                 fontFamily: 'Lexend',
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 16,
              //                 color: Color(0xff737373)
              //             ),),
              //             SizedBox(
              //               height: 2,
              //             ),
              //             Text('0.89 BTC',style:  TextStyle(
              //                 fontFamily: 'Lexend',
              //                 fontWeight: FontWeight.w600,
              //                 fontSize:20,
              //                 color: Color(0xff000000)
              //             ),),
              //             SizedBox(
              //               height: 2,
              //             ),
              //             Text('2022 - 12 - 34',style:  TextStyle(
              //                 fontFamily: 'Lexend',
              //                 fontWeight: FontWeight.w400,
              //                 fontSize: 11,
              //                 color: Color(0xffA7A7A7)
              //             ),),
              //
              //           ],
              //         ),
              //       ),
              //       Positioned(
              //         left: -10,
              //         child: SizedBox(
              //           height: 108,
              //           width: 20,
              //           child: Card(
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //             color: Colors.blue,
              //           ),
              //         ),
              //       ),
              //
              //     ],
              //   ),
              //   height: 80,
              //   decoration: BoxDecoration(
              //       color: Color(0xffF4B731).withOpacity(0.5),
              //       borderRadius: BorderRadius.circular(12)
              //
              //   ),),
            ],
          ))
        ],
      ),);
  }
}
