import 'dart:convert';

import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:http/http.dart' as http;

import '../../resources/ednpoints.dart';


class MyAdsService {
  Future<List<OfferData?>> getMyAds(String token) async {
    List<OfferData> myAds = [];
    String _url = baseURL + "offers?owner";
    try {
      final response = await http
          .get(Uri.parse(_url), headers: {'Authorization': 'Bearer $token'});
      // print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (json.decode(response.body) == null) {
        } else {
          final offer = offersModelFromJson(response.body);
          myAds = offer.offers;
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
    return myAds;
  }
}
