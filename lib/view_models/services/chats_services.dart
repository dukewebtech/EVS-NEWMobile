import 'dart:convert';
import 'package:evs_pay_mobile/model/user_model/chat_model.dart';
import 'package:http/http.dart' as http;

import '../../resources/ednpoints.dart';

class ChatService {
  Future<List<Chats?>> getChats(String token, String tradeReference) async {
    List<Chats> chats = [];
    String _url = baseURL + "trades/$tradeReference/chats";
    try {
      final response = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});

      print(response.body);
      // print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (json.decode(response.body) == null) {
          //
        } else {
          final offer = chatModelFromJson(response.body);
          chats = offer.data!;
          print("this are the chat $chats");
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
    return chats;
  }
}
