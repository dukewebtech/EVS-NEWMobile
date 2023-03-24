import 'package:evs_pay_mobile/model/notication_model_api.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../resources/color_manager.dart';
import '../../resources/font_manager.dart';
import '../../view_models/authentication_view_model/authentication_view_model.dart';
import '../../view_models/dashboard_view_model.dart';
import '../../view_models/services/notification_service.dart';
import '../../widgets/app_texts/custom_text.dart';
import '../../widgets/loading_indicator.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final dashboardViewModel = context.watch<DashboardViewModel2>();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          evsPayCustomAppBar(context, AppStrings.notification, leadingTap: () {
            Navigator.pop(context);
          }, isCenterAlign: true),

          SizedBox(
            height: AppSize.s31.h,
          ),

          Expanded(
            child: FutureBuilder<List<NotificationModelApi?>>(
                future: NotificationService().getNotifications(
                    authProvider.userData.accessToken!,
                    dashboardViewModel.tradeReference),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error Occurred'));
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: AppSize.s96.h,
                            ),
                            Center(
                                child: SvgPicture.asset(
                                    "assets/images/empty_state.svg")),
                            SizedBox(
                              height: AppSize.s49.h,
                            ),

                            const CustomText(
                              text: "You have no notifications yet",
                              textColor: ColorManager.blckColor,
                              fontSize: FontSize.s16,
                            ),
                            SizedBox(
                              height: AppSize.s8.h,
                            ),

                            // SizedBox(
                            //     width: AppSize.s208.w,
                            //     child: const CustomTextNoOverFlow(
                            //         alignment: "center",
                            //         fontSize: FontSize.s13,
                            //         text: "You have no notifications yet"))
                          ],
                        ),
                      );
                    } else {
                      final notifications = snapshot.data!;
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.builder(
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                var notification = notifications[index];

                                print(
                                    "just tring this: ${notification!.userId}");

                                return NotificationItem(
                                    notification: notification);
                              })

                          // ListView.builder(
                          //     itemCount: offers.length,
                          //     physics: const BouncingScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       final chat = offers[index];
                          //
                          //       return Padding(
                          //         padding: EdgeInsets.only(
                          //             bottom: AppSize.s20.h
                          //         ),
                          //         child: Row(
                          //           mainAxisAlignment: chat?.direction == "SEND" ?
                          //           MainAxisAlignment.end : MainAxisAlignment.start,
                          //           children: [
                          //             Container(
                          //               constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                          //               padding: EdgeInsets.symmetric(
                          //                   horizontal: AppSize.s16.w,
                          //                   vertical: AppSize.s8.h
                          //               ),
                          //               decoration: BoxDecoration(
                          //                   color: chat?.direction == "SEND" ?  ColorManager.primaryColor
                          //                       : ColorManager.chatCardColor,
                          //                   borderRadius: BorderRadius.circular(AppSize.s12.r)
                          //               ),
                          //               child: CustomTextNoOverFlow(text: chat?.message,
                          //                 fontSize: FontSize.s12,
                          //                 textColor: ColorManager.blckColor,),
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     }),
                          );
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      child: const LoadingIndicator(),
                    );
                  }
                }),
          ),

          // Expanded(child: ListView.builder(
          //   itemCount: notifications.length,
          //     itemBuilder: (context, index){
          //     final notification = notifications[index];
          //   return NotificationItem(notification: notification);
          // }))
        ],
      )),
    );
  }
}
