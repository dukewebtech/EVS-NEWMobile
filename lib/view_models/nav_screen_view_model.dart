import 'dart:convert';
import 'dart:io';
import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:evs_pay_mobile/model/trades_model_api.dart';
import 'package:evs_pay_mobile/model/trades_on_offer_model.dart';
import 'package:evs_pay_mobile/model/transaction_history_api_model.dart';
import 'package:evs_pay_mobile/model/user_model/api_payment_method_model.dart';
import 'package:evs_pay_mobile/resources/ednpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../widgets/loading_indicator.dart';
import '../resources/constants/constants.dart';
import '../resources/navigation_utils.dart';



class NavScreenViewModel extends ChangeNotifier {
  //NEW
  int _selectedPage = 0;





  int get selectedPage => _selectedPage;

  void updateSelectedPage(int newPageNumber){
    _selectedPage = newPageNumber;
    notifyListeners();
  }
}
