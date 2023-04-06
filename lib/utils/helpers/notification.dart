import 'package:evs_pay_mobile/utils/firebase.dart';
import 'package:evs_pay_mobile/utils/helpers/navigator.dart';
import 'package:evs_pay_mobile/utils/local_notification_service.dart';
import 'package:evs_pay_mobile/views/nav_screen_views/trade_view/trade_view_copy.dart';
import 'package:flutter/material.dart';

void listenToNotification() =>
    service.onNotificationClick.stream.listen(onNotificationListener);

void onNotificationListener(String? payload) {
  print('--------------- i was here ------------');
  if (payload != null && payload.isNotEmpty) {
    print('payload $payload');
    navigator.currentState?.push(MaterialPageRoute(
        builder: ((context) => const TradeViewCopy(page: 1))));
  }
}

LocalNotificationService localNotificationService = LocalNotificationService();

void handleNotification(Map? payload) {
  // Navigator.pop(context); message, offer_id
  // print(payload);

  bool isType(String type) {
    Map check = {
      'chat': 'message',
      'trade': 'offer_id',
    };

    if (payload!.containsKey(check[type])) {
      return true;
    }
    return false;
  }

  if (isType('chat')) {
    //do this
    navigator.currentState?.push(MaterialPageRoute(
        builder: ((context) => const TradeViewCopy(page: 1))));
    print('----------------------------doing chat work----------------------');
  }

  if (isType('trade')) {
    print('----------------------------doing trade work----------------------');

    navigator.currentState?.push(MaterialPageRoute(
        builder: ((context) => const TradeViewCopy(page: 1))));
  }
}

void handleForegroundNotification(Map? payload) {
  // Navigator.pop(context); message, offer_id
  // print(payload);

  bool isType(String type) {
    Map check = {
      'chat': 'message',
      'trade': 'offer_id',
    };

    if (payload!.containsKey(check[type])) {
      return true;
    }
    return false;
  }

  if (isType('chat')) {
    print('---------------------------- na m deyssssss----------------------');
    //do this

    localNotificationService.showNotificationWithPayload(
        payload: 'payload Naviga',
        id: 1,
        title: payload!['recipient_id'].toString(),
        body: payload['message'].toString());
    // navigator.currentState?.push(MaterialPageRoute(
    //     builder: ((context) => const TradeViewCopy(page: 1))));
  }

  if (isType('trade')) {
    print('----------------------------doing trade work----------------------');
    localNotificationService.showNotificationWithPayload(
      payload: 'payload Naviga',
      id: 2,
      title: "Trade Request",
      body:
          "You've a new trade request of N${payload!['amount'].toString()} from ${payload['partner_id'].toString()}",
    );

    // navigator.currentState?.push(MaterialPageRoute(
    //     builder: ((context) => const TradeViewCopy(page: 1))));
  }
}
