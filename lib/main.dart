import 'package:evs_pay_mobile/resources/routes_manager.dart';
import 'package:evs_pay_mobile/resources/value_manager.dart';
import 'package:evs_pay_mobile/utils/firebase.dart';
import 'package:evs_pay_mobile/utils/helpers/navigator.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/authentication_view_model.dart';
import 'package:evs_pay_mobile/view_models/authentication_view_model/user_profile_view_model.dart';
import 'package:evs_pay_mobile/view_models/chats_view_model.dart';
import 'package:evs_pay_mobile/view_models/my_ads_view_model.dart';
import 'package:evs_pay_mobile/view_models/nav_screen_view_model.dart';
import 'package:evs_pay_mobile/view_models/trade_view_model.dart';
import 'package:evs_pay_mobile/view_models/wallet_transaction_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'resources/theme_manager.dart';
import 'view_models/dashboard_view_model.dart';
import 'view_models/general_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the incoming message
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp();

  // Register the onBackgroundMessage handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseHandler.init();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthenticationProvider()),
    ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
    ChangeNotifierProvider(create: (_) => EvsPayViewModel()),
    ChangeNotifierProvider(create: (_) => TradeViewModel()),
    ChangeNotifierProvider(create: (_) => MyAdsViewModel()),
    ChangeNotifierProvider(create: (_) => WalletViewModel()),
    ChangeNotifierProvider(create: (_) => TradeViewModel()),
    ChangeNotifierProvider(create: (_) => ChatsViewModel()),
    ChangeNotifierProvider(create: (context) => DashboardViewModel2()),
    ChangeNotifierProvider(create: (_) => NavScreenViewModel()),
  ], child: const MyApp()));

  // whenever the initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(AppSize.designWidth, AppSize.designHeight),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.splashRoute,
              navigatorKey: navigator,
              theme: getApplicationTheme(),
            ));
  }
}
