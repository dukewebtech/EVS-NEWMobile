import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/notification_model.dart';
class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          evsPayCustomAppBar(context, AppStrings.notification,
              leadingTap: (){
            Navigator.pop(context);
              },
              isCenterAlign: true),

          SizedBox(height: AppSize.s31.h,),

          Expanded(child: ListView.builder(
            itemCount: notifications.length,
              itemBuilder: (context, index){
              final notification = notifications[index];
            return NotificationItem(notification: notification);
          }))
        ],
      )),
    );
  }
}
