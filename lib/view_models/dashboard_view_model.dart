import 'dart:convert';

import 'package:evs_pay_mobile/model/btc_to_naira_model.dart';
import 'package:evs_pay_mobile/model/create_offer_model.dart';
import 'package:evs_pay_mobile/model/init_trade_model.dart';
import 'package:evs_pay_mobile/model/naira_to_btc_model.dart';
import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:evs_pay_mobile/model/trades_model_api.dart';
import 'package:evs_pay_mobile/model/trades_on_offer_model.dart';
import 'package:evs_pay_mobile/model/transaction_history_api_model.dart';
import 'package:evs_pay_mobile/resources/ednpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/dashboard_trade_model.dart';
import '../model/rate_model.dart';
import '../resources/constants/constants.dart';



class DashboardViewModel2 extends ChangeNotifier {


  bool _isBuyTradeLastPage = false;
  int _buyTradePageNumber = 0;

  int _btcValue = 0;
  int get btcValue => _btcValue;

  int _nairaValue = 0;
  int get nairaValue => _nairaValue;

  bool _isSuccessful = false;

  String _btcToBuy = "";
  String get btcToBuy => _btcToBuy;

  String _nairaAmount = "";
  String get nairaAmount => _nairaAmount;

  InitTradeModel? _initTradeModel;
  InitTradeModel get initTradeData => _initTradeModel!;

  String _tradeReference = "";
  String get tradeReference => _tradeReference;


  String _sellUrl = "http://evspay.com/api/offers/?type=buy";
  String _buyUrl = "http://evspay.com/api/offers/?type=sell";

  String initialBuyUrl = "http://evspay.com/api/offers/?type=sell";
  String initialSellUrl = "http://evspay.com/api/offers/?type=buy";

  String _filteredTradeUrl = "http://evspay.com/api/offers/?type=buy";
  String get filteredTradeUrl => _filteredTradeUrl;

  List<DashboardTradeData> _trades = [];
  DashboardTradeModel? tradesModel;

  DashboardTradeModel? filteredTradeModel;


  List<DashboardTradeData> _filteredTrades = [];
  List<DashboardTradeData> get filteredTrades => _filteredTrades;

  DashboardTradeData? _selectedTrade;

  List<DashboardTradeData> _buyTrades = [];
  DashboardTradeModel? buyTradesModel;



  bool get isBuyTradeLastPage => _isBuyTradeLastPage;

  String get sellUrl => _sellUrl;
  String get buyUrl => _buyUrl;

  bool get isSuccessful => _isSuccessful;

  List<DashboardTradeData> get trades => _trades;

  List<DashboardTradeData> get buyTrades => _buyTrades;

  DashboardTradeData get selectedTrade => _selectedTrade!;


  //NEW
  bool _isLastPage = false;
  bool get isLastPage => _isLastPage;

  bool _isLastFilteredPage = false;
  bool get isLastFilteredPage => _isLastFilteredPage;


  int _pageNumber = 0;
  int get pageNumber =>_pageNumber;

  int _filteredTradePageNumber = 0;
  int get filteredTradePageNumber =>_filteredTradePageNumber;

  String _url = "http://evspay.com/api/offers";
  bool _error = false;
  bool _loading = false;
  final int numberOfPostsPerRequest = 10;
  final List<OfferData> _offers = [];
  OffersModel? offerModel;
  NairaToBtcModel? _nairaToBtc;
  final int nextPageTrigger = 3;

  CreateOfferModel? _createOfferModel;

  RateModel? _rate;
  RateModel get rate => _rate!;

  BtcToNairaModel? _btcToNairaModel;
  BtcToNairaModel? get btcNairaModel => _btcToNairaModel;




  String get url => _url;
  bool get error => _error;
  bool get loading => _loading;

  NairaToBtcModel? get nairaToBtc => _nairaToBtc;


  CreateOfferModel get createOfferModel => _createOfferModel!;

  List<OfferData> get offers => _offers;


  DashboardViewModel2(){
    fetchBuyTrades();
    fetchSellTrades();
    fetchFilteredTrades();
  }

  set setIsLastPage(bool value){
    _isLastPage = value;
    notifyListeners();
  }

  void clear() {
    _resMessage = "";
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

  set createOfferModel(CreateOfferModel createOfferModel){
    _createOfferModel = createOfferModel;
    notifyListeners();
  }

  void changeNairaAmount(String amount){
    _nairaAmount = amount;
    notifyListeners();
  }

  void changeBtcAmount(String amount){
    _btcToBuy = amount;
    notifyListeners();
  }

  void changeTradeReference(String newRef){
    _tradeReference = newRef;
    notifyListeners();
  }

  void changePageNumber(int page){
    _pageNumber = page;
    print("Page number: $_pageNumber");
    notifyListeners();
  }

  void changeFilteredPageNumber(int page){
    _filteredTradePageNumber = page;
    print("Page number: $_filteredTradePageNumber");
    notifyListeners();
  }

  void resetBuyTradePageNumber(){
    _buyTradePageNumber = 0;
    _buyUrl = initialBuyUrl;
    print("Buy Trade Page Number: $_buyTradePageNumber");
    notifyListeners();
  }

  void resetSellTradePageNumber(){
    _pageNumber = 0;
    _sellUrl = initialSellUrl;
    print("Buy Trade Page Number: $_buyTradePageNumber");
    notifyListeners();
  }




  ///Setter
  String _resMessage = '';

  TransactionHistoryModel? _transactionHistories;

  //For  Offers
  OffersModel? _offer;
  OfferData? _selectedOffer;

  //

  //For  Trades
  TradesModel? _trade;

  //Trades on offer
  TradesOnOfferModel? _tradesOnOffer;


  ///Getter
  String get resMessage => _resMessage;
  TransactionHistoryModel get transactionHistories => _transactionHistories!;

  //For Offers
  OffersModel get offer => _offer!;
  OfferData get selectedOffer => _selectedOffer!;

  //For Trade
  TradesModel get trade => _trade!;


  //Trades on offer
  TradesOnOfferModel get tradesOnOffer => _tradesOnOffer!;



  //Set selected Trade;
  void setSelectedTrade(DashboardTradeData selectedTrade){
    _selectedTrade = selectedTrade;
    print("${_selectedTrade!.reference}");
    notifyListeners();
  }


  set sellUrl(String url){
    _sellUrl = url;
    notifyListeners();
  }

  set buyUrl(String url){
    _buyUrl = url;
    notifyListeners();
  }



  Future<bool> initTrade(String nairaAmount) async {
    bool isInitiated = false;
    _isSuccessful = false;

    _loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    final body = {
      "amount": nairaAmount,
    };
    try {
      final response = await http.post(Uri.parse(
        "http://evspay.com/api/offers/${_selectedTrade!.reference}/trades/init",
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          },
        body: json.encode(body)
      );

      print("Init trade response: ${response.body} Status code: ${response.statusCode}");
      print("Status code: ${response.statusCode}");

      final decodedResponse = json.decode(response.body);

      _loading = false;
      notifyListeners();
      if(response.statusCode == 200 || response.statusCode == 201){
        _initTradeModel = initTradeModelFromJson(response.body);
        _isSuccessful = true;
        _resMessage = "Trade initiated";
        isInitiated = true;
        _btcValue = 0;

        _tradeReference = _initTradeModel!.data!.reference;
        notifyListeners();
      }else{
        _resMessage = decodedResponse['message'];
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }

    return isInitiated;
  }

  Future<bool> iHavePaidTrade(String tradeReference) async {
    bool isConfirmed = false;
    _isSuccessful = false;

    _loading = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    final body = {

    };
    try {
      final response = await http.put(Uri.parse(
        "http://evspay.com/api/trades/$tradeReference/confirm",
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          },
          body: json.encode(body)
      );

      print("I have paid response: ${response.body} Status code: ${response.statusCode}");
      print("Status code: ${response.statusCode}");

      final decodedResponse = json.decode(response.body);

      _loading = false;
      notifyListeners();
      if(response.statusCode == 200 || response.statusCode == 201){
        _isSuccessful = true;
        isConfirmed = true;
        _resMessage = "Trade Confirmed";

        notifyListeners();
      }else{
        _resMessage = decodedResponse['message'];
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }

    return isConfirmed;
  }

  Future<void> getBtcRate() async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    try {
      final response = await http.get(Uri.parse(
        baseURL + Endpoints.exchangeRate,
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        print("BTC Rate Fetched: ${response.body}");
        _rate = rateModelFromJson(response.body);
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
  }


  Future<int> getNairaToBtcRate(String nairaValue) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    // _btcValue = 0;
    notifyListeners();
    print("BTC Rate Method called");
    try {
      final response = await http.get(Uri.parse(
        baseURL + "services/exchange-rates/$nairaValue/naira-to-btc",
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );
      if(response.statusCode == 200){
        print("Naira To BTC Fetched: ${response.body}");
        _nairaToBtc = nairaToBtcModelFromJson(response.body);
        print("Naia to btc: ${_nairaToBtc!.data.btc}");
          _btcValue = _nairaToBtc!.data.btc.toInt();
          print("Btc value here: $_btcValue");
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }

    return _btcValue;
  }

  Future<int> getBtcToNairaRate(String btc) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    print("BTC To Naira Rate Method called");
    _nairaValue = 0;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(
        baseURL + "services/exchange-rates/$btc/btc-to-naira",
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );

      if(response.statusCode == 200){
        print("BTC To Naira Fetched: ${response.body}");
        _btcToNairaModel = btcToNairaModelFromJson(response.body);
        if(_btcToNairaModel != null){
          _nairaValue = _btcToNairaModel!.data.naira.toInt();
        }
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
    return _nairaValue;
  }

  Future<void> fetchSellTrades({
    String queryParam =  "?type=sell",
    bool isRefresh = false,
}) async {
    print("Method called");
    if(isRefresh){
      _trades = [];
      notifyListeners();
    }
    final prefs = await SharedPreferences.getInstance();
    final String url = "http://evspay.com/api/offers/" + queryParam;
    print("The URL to fetch is: $url");
    notifyListeners();
    final retrievedAccessToken = prefs.getString(accessToken);
    try {
      final response = await http.get(Uri.parse(
        _sellUrl,
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );
      print("Trades Fetched: ${response.body}");
      tradesModel = dashboardTradeModelFromJson(response.body);
      final responseHere = dashboardTradeModelFromJson(response.body);
      print("Here at mapping successful");
      final postList = responseHere.trades;
      print("List length: ${postList!.length}");
      _isLastPage = (postList.length < numberOfPostsPerRequest);
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


  Future<void> fetchFilteredTrades({
    String queryParam =  "?type=sell"
  }) async {
    print("Method called");
    _filteredTrades = [];
    final prefs = await SharedPreferences.getInstance();
    final String url = "http://evspay.com/api/offers/" + queryParam;
    print("The URL to fetch is: $url");
    notifyListeners();
    final retrievedAccessToken = prefs.getString(accessToken);
    try {
      final response = await http.get(Uri.parse(
        url,
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );
      print("Trades Fetched: ${response.body}");
      filteredTradeModel = dashboardTradeModelFromJson(response.body);
      final responseHere = dashboardTradeModelFromJson(response.body);
      print("Here at mapping successful");
      final postList = responseHere.trades;
      print("List length: ${postList!.length}");
      _isLastFilteredPage = (postList.length < numberOfPostsPerRequest);
      _loading = false;
      _filteredTradePageNumber = _filteredTradePageNumber + 1;
      _filteredTrades.addAll(postList);

      notifyListeners();
    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
  }

  Future<void> fetchBuyTrades({bool isRefresh = false}) async {
    print("Method called");
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    if(isRefresh){
    //  empty list
      print("Is refresh action");
      _buyTrades = [];
      notifyListeners();
    }
    try {
      final response = await http.get(Uri.parse(
        _buyUrl,
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          }
      );
      print("Trades Fetched: ${response.body}");
      buyTradesModel = dashboardTradeModelFromJson(response.body);
      final responseHere = dashboardTradeModelFromJson(response.body);
      print("Here at mapping successful");
      final postList = responseHere.trades;
      print("List length: ${postList!.length}");
      _isBuyTradeLastPage = (postList.length < numberOfPostsPerRequest);
      _loading = false;
      _buyTradePageNumber = _buyTradePageNumber + 1;
      _buyTrades.addAll(postList);

      notifyListeners();
    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
  }
}
