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



class TradeViewModel extends ChangeNotifier {
  //NEW
  bool _isLastPage = false;
  int _pageNumber = 0;
   String _url = "http://evspay.com/api/trades";
   bool _error = false;
  bool _loading = false;
  final int numberOfPostsPerRequest = 10;
  final List<TradeData> _trades = [];
  TradesModel? tradesModel;
  final int nextPageTrigger = 3;



  bool get isLastPage => _isLastPage;
  int get pageNumber => _pageNumber;
  String get url => _url;
  bool get error => _error;
  bool get loading => _loading;

  List<TradeData> get trades => _trades;


  TradeViewModel(){
    fetchTrades();
  }

  set setIsLastPage(bool value){
    _isLastPage = value;
    notifyListeners();
  }

  set setError(bool value){
    _error = value;
    notifyListeners();
  }

  set url(String url){
    _url = url;
    notifyListeners();
  }

  set setLoading(bool value){
    _loading = value;
    notifyListeners();
  }





  ///Setter
  bool _isLoading = false;
  String _resMessage = '';

  PaymentMethod? _paymentMethod;
  TransactionHistoryModel? _transactionHistories;

  //For  Offers
  OffersModel? _offer;
  OfferData? _selectedOffer;

  //

  //For  Trades
  TradesModel? _trade;
  TradeData? _selectedTrade;

  //Trades on offer
  TradesOnOfferModel? _tradesOnOffer;


  ///Getter
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;
  PaymentMethod get paymentMethod => _paymentMethod!;
  TransactionHistoryModel get transactionHistories => _transactionHistories!;

  //For Offers
  OffersModel get offer => _offer!;
  OfferData get selectedOffer => _selectedOffer!;

  //For Trade
  TradesModel get trade => _trade!;
  TradeData get selectedTrade => _selectedTrade!;


  //Trades on offer
  TradesOnOfferModel get tradesOnOffer => _tradesOnOffer!;



  //Set selected Trade;
  void setSelectedTrade(TradeData trade){
    _selectedTrade = trade;
    notifyListeners();
  }


  Future<void> fetchTrades() async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    try {
      final response = await http.get(Uri.parse(
        _url,
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );

      // print("Trades Fetched: ${response.body}");
      tradesModel = tradesModelFromJson(response.body);
      final responseHere = tradesModelFromJson(response.body);
      print("Here at mapping successful");
      final postList = responseHere.trades;
      print("Length: ${postList!.length}");

        _isLastPage = postList.length < numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _trades.addAll(postList);

        notifyListeners();
    } catch (e) {
      print("error --> $e");
        _loading = false;
        _error = true;
        notifyListeners();
    }
  }

  //GET Trades
  Future<void> getTrades({
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    // print("Access token $retrievedAccessToken");
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    try {
      final response =
      await http.get(
        Uri.parse("$baseURL${Endpoints.trades}"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },);
      // print("Trades body=====: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _trade = tradesModelFromJson(response.body);
        _resMessage = "";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        // Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _resMessage = "Please try again";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }


  //GET Trades
  Future<void> getTradesOnOffer({
    required BuildContext context,
    required String offerId
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    print("Access token $retrievedAccessToken");
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    try {
      final response =
      await http.get(
        Uri.parse("$baseURL${Endpoints.offers}/$offerId/trades"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },);
      // print("Trades body=====: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _tradesOnOffer = tradesOnOfferModelFromJson(response.body);
        _resMessage = "";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
        openViewTradeScreen(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _resMessage = "Internet connection is not available";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _resMessage = "Please try again";
      _isLoading = false;
      notifyListeners();
      Navigator.pop(context);
      print("exception: $e");
    }
  }
}
