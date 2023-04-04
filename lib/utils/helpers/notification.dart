import 'package:evs_pay_mobile/utils/helpers/navigator.dart';
import 'package:evs_pay_mobile/views/sign_up/sign_up_view.dart';
import 'package:evs_pay_mobile/views/veriffy_email_view/verify_email_view.dart';
import 'package:flutter/material.dart';

void handleNotification(Map? payload) {
  // Navigator.pop(context); message, offer_id

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
    navigator.currentState?.push(
        MaterialPageRoute(builder: ((context) => const VerifyEmailView())));
    print('----------------------------doing chat work----------------------');
  }

  if (isType('trade')) {
    print('----------------------------doing trade work----------------------');

    navigator.currentState
        ?.push(MaterialPageRoute(builder: ((context) => const SignUpView())));
  }
}
