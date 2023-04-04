import 'package:evs_pay_mobile/utils/helpers/navigator.dart';
import 'package:evs_pay_mobile/utils/helpers/notification.dart';
import 'package:evs_pay_mobile/utils/local_notification_service.dart';
import 'package:evs_pay_mobile/views/veriffy_email_view/verify_email_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

late final LocalNotificationService service;

LocalNotificationService localNotificationService = LocalNotificationService();

class FirebaseHandler {
  final firebaseInstance = FirebaseMessaging.instance;
  void onNotificationListener(String? payload) {
    print('--------------- i was here ------------');
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');
      navigator.currentState?.push(
          MaterialPageRoute(builder: ((context) => const VerifyEmailView())));
    }
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNotificationListener);

  static Future<void> init() async {
    Future backgroundMsgHandler(RemoteMessage message) async {
      if (message.data['message']) {
        navigator.currentState?.push(
            MaterialPageRoute(builder: ((context) => const VerifyEmailView())));
      }
      print('bckground1 called');

      // print(message);
    }

    //Background
    FirebaseMessaging.onBackgroundMessage(backgroundMsgHandler);

    //onLaunch
    /**
       * When the app is completely closed (not in the background) 
       * and opened directly from the push notification
       */
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      handleNotification(event?.data);
    });

    //onMessage
    /**
       * When the app is open and it receives a push notification
       */
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      //implement local notificatinon show

      // localNotificationService.showNotification(
      //     id: 2,
      //     title: message.messageId.toString(),
      //     body: message.data.toString());

      print('bckground2 called');
      localNotificationService.showNotificationWithPayload(
          id: 3, title: 'payload', body: message.data.toString(), payload: '');
    });

    //onResume
    /**
       * When the app is in the background and is opened directly 
       * from the push notification.
       */
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotification(message.data);
    });
  }

  Future<String?> getToken() async {
    var token = await firebaseInstance.getToken().then((token) {
      return token;
    });

    return token;
  }

  void grantPermission() async {
    NotificationSettings settings = await firebaseInstance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }
}
