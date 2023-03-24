import 'dart:convert';
import 'package:evs_pay_mobile/model/notication_model_api.dart';
import 'package:http/http.dart' as http;

import '../../resources/ednpoints.dart';

class NotificationService {
  Future<List<NotificationModelApi?>> getNotifications(
      String token, String tradeReference) async {
    List<NotificationModelApi> notificationsFetched = [];
    String _url = baseURL + "accounts/notifications";
    try {
      final response = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});
      // print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (json.decode(response.body) == null) {
        } else {
          final notifications = notificationModelFromJson(response.body);
          notificationsFetched = notifications;
        }
      } else {
        // print(request
        // .body);
      }
    } catch (e) {
      // print("Cached error: ${e.toString()}");
      // print(e);
      return Future.error(e.toString());
    }
    return notificationsFetched;
  }
}
