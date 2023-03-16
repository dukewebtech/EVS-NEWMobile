import 'package:firebase_messaging/firebase_messaging.dart';

class Firebase {
  final firebaseInstance = FirebaseMessaging.instance;

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
