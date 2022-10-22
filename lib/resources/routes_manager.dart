

import 'package:evs_pay_mobile/resources/strings_manager.dart';
import 'package:evs_pay_mobile/views/buy_trade_view/buy_trade_view.dart';
import 'package:evs_pay_mobile/views/chat_screen/chat_screen.dart';
import 'package:evs_pay_mobile/views/confirm_buy_screen/confirm_buy_screen.dart';
import 'package:evs_pay_mobile/views/confirm_sell_trade_view/confirm_sell_trade_view.dart';
import 'package:evs_pay_mobile/views/edit_offer_view/edit_offer_view.dart';
import 'package:evs_pay_mobile/views/edit_profile_view/edit_profile_view.dart';
import 'package:evs_pay_mobile/views/login_screen/login_screen.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/nav_screen_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/settings/settings_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/create_offer_view.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/view_offer_view.dart';
import 'package:evs_pay_mobile/views/notification_settings/notification_settings_view.dart';
import 'package:evs_pay_mobile/views/notifications/nottifications_view.dart';
import 'package:evs_pay_mobile/views/on_boarding_screen/on_boarding_screen.dart';
import 'package:evs_pay_mobile/views/receive_trade/receive_trade_view.dart';
import 'package:evs_pay_mobile/views/recover_password_view/recover_password_view.dart';
import 'package:evs_pay_mobile/views/security_settings/security_settings_view.dart';
import 'package:evs_pay_mobile/views/sell_view/sell_view.dart';
import 'package:evs_pay_mobile/views/send_trade/send_trade_view.dart';
import 'package:evs_pay_mobile/views/setup_pin_view/confirm_transaction_pin.dart';
import 'package:evs_pay_mobile/views/setup_pin_view/set_up_transaction_pin.dart';
import 'package:evs_pay_mobile/views/sign_up/sign_up_view.dart';
import 'package:evs_pay_mobile/views/transaction_pin_view/transaction_pin_view.dart';
import 'package:evs_pay_mobile/views/transaction_successful_view/transaction_successful_view.dart';
import 'package:evs_pay_mobile/views/veriffy_email_view/verify_email_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/email_verification_view/email_verification_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/phone_number_verification/phone_number_verification_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/proof_of_address_view/proof_of_address_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/take_a_selfie_view/take_a_selfie_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/upload_id_view/upload_id_view.dart';
import 'package:evs_pay_mobile/views/verification_screens/verification_submitted_view/verification_submitted_view.dart';
import 'package:evs_pay_mobile/views/verify_account_to_trade_view/verify_account_to_trade_screen.dart';
import 'package:flutter/material.dart';

import '../views/splash_view/splash_view.dart';
import '../views/verification_screens/verification_home/verification_home_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const loginScreen = "/login_screen";
  static const onBoardingScreen = "/on_boarding_screen";
  static const signUpScreen = "/sign_up_view";
  static const verifyEmail = "/verify_email";
  static const recoverPassword = "/recover_password";
  static const navScreen = "/nav_screen";
  static const setupPin = "/setup_pin";
  static const confirmTransactionPin = "/confirm_transaction_pin";
  static const securitySettingsScreen = "/security_settings_screen";
  static const notificationsScreen = "/notification_screen";
  static const notificationsSettingsScreen = "/notifications_settings_screen";
  static const editProfileScreen = "/edit_profile_screen";
  static const verificationHome = "/verification_home";
  static const proofOfAddressScreen = "/proof_of_address_screen";
  static const uploadIdScreen = "/upload_id_screen";
  static const takeASelfieScreen = "/takeASelfieScreen";
  static const verificationSubmittedScreen = "/verification_submitted_screen";
  static const phoneVerification = "/phone_verification";
  static const emailVerification = "/email_verification";
  static const sendTradeView = "/send_trade_view";
  static const receiveTradeView = "/receive_trade_view";
  static const transactionPinView = "/transaction_pin_view";
  static const transactionSuccessfulView = "/transaction_successful";
  static const viewTradeScreen = "/view_trade_screen";
  static const createOffer = "/create_offer";
  static const sellView = "/sell_view";
  static const buyTradeView = "/buy_trade_view";
  static const editOfferView = "/edit_offer_view";
  static const confirmBuyTrade = "/confirm_buy_trade";
  static const confirmSellTrade = "/confirm_sell_trade";
  static const chatScreen = "/chat_screen";
  static const settingsScreen = "/settings_screen";
  static const verifyAccountScreen =  "/verify_account_screen";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.recoverPassword:
        return MaterialPageRoute(builder: (_) => const RecoverPasswordView());
      case Routes.verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailView());
      case Routes.navScreen:
        return MaterialPageRoute(builder: (_) => const NavScreenView());
      case Routes.setupPin:
        return MaterialPageRoute(builder: (_) => const SetupPin());
      case Routes.confirmTransactionPin:
        return MaterialPageRoute(builder: (_) => const ConfirmTransactionPin());
      case Routes.securitySettingsScreen:
        return MaterialPageRoute(builder: (_) => const SecuritySettingsView());
      case Routes.notificationsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case Routes.notificationsSettingsScreen:
        return MaterialPageRoute(builder: (_) => const NotificationSettings());
      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileView());
      case Routes.verificationHome:
        return MaterialPageRoute(builder: (_) => const VerificationHomeView());
      case Routes.proofOfAddressScreen:
        return MaterialPageRoute(builder: (_) => const ProofOfAddressView());
      case Routes.uploadIdScreen:
        return MaterialPageRoute(builder: (_) => const UploadIdView());
      case Routes.takeASelfieScreen:
        return MaterialPageRoute(builder: (_) => const TakeASelfieView());
      case Routes.verificationSubmittedScreen:
        return MaterialPageRoute(builder: (_) => const VerificationSubmittedView());
      case Routes.phoneVerification:
        return MaterialPageRoute(builder: (_) => const PhoneNumberVerificationView());
      case Routes.emailVerification:
        return MaterialPageRoute(builder: (_) => const EmailVerificationView());
      case Routes.sendTradeView:
        return MaterialPageRoute(builder: (_) => const SendTradeView());
      case Routes.receiveTradeView:
        return MaterialPageRoute(builder: (_) => const ReceiveTradeView());
      case Routes.transactionPinView:
        return MaterialPageRoute(builder: (_) => const TransactionPinView());
      case Routes.transactionSuccessfulView:
        return MaterialPageRoute(builder: (_) => const TransactionSuccessfulView());
      case Routes.viewTradeScreen:
        return MaterialPageRoute(builder: (_) => const ViewOfferView());
      case Routes.createOffer:
        return MaterialPageRoute(builder: (_) => const CreateOfferView());
      case Routes.editOfferView:
        return MaterialPageRoute(builder: (_) => const EditOfferView());
      case Routes.sellView:
        return MaterialPageRoute(builder: (_) => const SellView());
      case Routes.buyTradeView:
        return MaterialPageRoute(builder: (_) => const BuyTradeView());
      case Routes.confirmBuyTrade:
        return MaterialPageRoute(builder: (_) => const ConfirmBuyScreen());
      case Routes.confirmSellTrade:
        return MaterialPageRoute(builder: (_) => const ConfirmSellTradeScreen());
      case Routes.chatScreen:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.verifyAccountScreen:
        return MaterialPageRoute(builder: (_) => const VerifyAccountToTradeScreen());

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
