import 'dart:io';

import 'package:evs_pay_mobile/model/user_model/user_profile_model.dart';
import 'package:evs_pay_mobile/resources/ednpoints.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/constants/constants.dart';
import '../../utils/api_status.dart';

class UserProfileService{
  static Future<Object> getUserProfile()async{
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    try{
      var url = Uri.parse("$baseURL${Endpoints.profileEndpoint}");
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $retrievedAccessToken',
        'Content-Type': 'application/json',
      },);
      if(response.statusCode == 200){
        return Success(code: response.statusCode, response: userProfileModelFromJson(response.body));
      }
      return Failure(code: userInvalidCode, errorResponse: "Invalid Response");
    } on HttpException{
      return Failure(code: noInternet, errorResponse: "No Internet");
    } on FormatException{
      return Failure(code: invalidFormat, errorResponse: "Invalid Format");
    }on SocketException{
      return Failure(code: noInternet, errorResponse: "No Internet");
    }
    catch (e){
      return Failure(code: unknownError, errorResponse: "Unknown Error");
    }

  }
}