import 'package:evs_pay_mobile/resources/image_manager.dart';
import 'package:evs_pay_mobile/resources/navigation_utils.dart';
import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/widgets/custom_app_bar.dart';
import 'package:evs_pay_mobile/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: evsPayCustomAppBar(context, AppStrings.settings,
          isCenterAlign: true, showLeading: false),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.s28.r),
        child: Column(
          children: [
            SettingsItem(
                onTap: () {
                  openSecuritySettingsScreen(context);
                },
                iconName: AppImages.lock,
                itemName: AppStrings.security),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {
                  openNotificationsSettingsScreen(context);
                },
                iconName: AppImages.notificationIcon,
                itemName: AppStrings.notifications),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {},
                iconName: AppImages.transactionIcon,
                itemName: AppStrings.transactions),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {
                  openVerificationHomeView(context);
                },
                iconName: AppImages.verificationIcon,
                itemName: AppStrings.verification),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {
                  openEditProfileScreen(context);
                },
                iconName: AppImages.profileIcon,
                itemName: AppStrings.profile),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {},
                iconName: AppImages.termsOfService,
                itemName: AppStrings.termsPfService),
            SizedBox(
              height: AppSize.s25.h,
            ),
            SettingsItem(
                onTap: () {
                  _showMyDialog(context);

                  // openLoginScreen(context);
                },
                iconName: AppImages.infoIcon,
                itemName: AppStrings.signOut),
            SizedBox(
              height: AppSize.s40.h,
            ),
          ],
        ),
      )),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: const Text(
          'Sign Out',
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Color(0xff000000),
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Would you like to approve of this log-out?',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  color: Colors.grey.shade800,
                  // color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              openLoginScreen(context);
            },
          ),
          TextButton(
            child: const Text('Decline'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
