import 'dart:convert';
import 'package:evs_pay_mobile/resources/ednpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/constants/constants.dart';

class ChatsViewModel extends ChangeNotifier {
  String _tradeReference = "";
  String get tradeReference => _tradeReference;

  void changeTradeReference(String tradeRef) {
    _tradeReference = tradeRef;
    notifyListeners();
  }

  Future<bool> sendMessage(
      String chat, String tradeReference, String? file) async {
    bool isSent = false;

    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    final String url = baseURL + "trades/$tradeReference/chats/send-message";
    final body = {
      "message": chat,
      "attachment": file,
    };
    try {
      final response = await http.post(
          Uri.parse(
            url,
          ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));

      print("-------> chat was called");

      print(
          "Send chat response: ${response.body} Status code: ${response.statusCode}");
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSent = true;
        notifyListeners();
      }
    } catch (e) {
      print("error --> $e");

      notifyListeners();
    }

    return isSent;
  }
}
