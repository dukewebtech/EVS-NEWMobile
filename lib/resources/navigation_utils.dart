
import 'package:evs_pay_mobile/resources/routes_manager.dart';
import 'package:flutter/material.dart';


void openLoginScreen(BuildContext context) async{
  Navigator.pushReplacementNamed(context, Routes.loginScreen);
}

void openSignUp(BuildContext context) async{
  Navigator.pushNamed(context, Routes.signUpScreen);
}

void openVerifyEmail(BuildContext context) async{
  Navigator.pushNamed(context, Routes.verifyEmail);
}


void openRecoverPassword(BuildContext context) async{
  Navigator.pushNamed(context, Routes.recoverPassword);
}

void openSetupPin(BuildContext context) async{
  Navigator.pushNamed(context, Routes.setupPin);
}

void openConfirmTransactionPin(BuildContext context) async{
  Navigator.pushNamed(context, Routes.confirmTransactionPin);
}

void openNavScreen(BuildContext context) async{
  Navigator.pushNamedAndRemoveUntil(context, Routes.navScreen, (route) => false);
}

void openSecuritySettingsScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.securitySettingsScreen);
}

void openNotificationsSettingsScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.notificationsSettingsScreen);
}

void openNotificationsScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.notificationsScreen);
}

void openEditProfileScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.editProfileScreen);
}

//VERIFICATION SCREENS
void openVerificationHomeView(BuildContext context) async{
  Navigator.pushNamed(context, Routes.verificationHome);
}

void openProofOfAddressScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.proofOfAddressScreen);
}

void openUploadIdScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.uploadIdScreen);
}

void openTakeSelfieScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.takeASelfieScreen);
}

void openVerificationSubmittedScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.verificationSubmittedScreen);
}

void openPhoneNumberVerificationScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.phoneVerification);
}

void openEmailVerificationScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.emailVerification);
}

void openSendTradeScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.sendTradeView);
}

void openReceiveTradeScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.receiveTradeView);
}

void openTransactionPinScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.transactionPinView);
}

void openTransactionSuccessfulScreen(BuildContext context) async{
  Navigator.pushNamed(context, Routes.transactionSuccessfulView);
}

