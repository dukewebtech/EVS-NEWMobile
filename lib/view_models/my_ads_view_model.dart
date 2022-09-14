import 'dart:convert';
import 'dart:io';
import 'package:evs_pay_mobile/model/create_offer_model.dart';
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



class MyAdsViewModel extends ChangeNotifier {
  //NEW
  bool _isLastPage = false;
  int _pageNumber = 0;
  String _url = "http://evspay.com/api/offers?owner";
  bool _error = false;
  bool _loading = false;
  final int numberOfPostsPerRequest = 10;
  List<OfferData> _offers = [];
  OffersModel? offerModel;
  final int nextPageTrigger = 3;

  CreateOfferModel? _createOfferModel;



  bool get isLastPage => _isLastPage;
  int get pageNumber => _pageNumber;
  String get url => _url;
  bool get error => _error;
  bool get loading => _loading;

  CreateOfferModel get createOfferModel => _createOfferModel!;

  List<OfferData> get offers => _offers;


  MyAdsViewModel(){
    fetchOffers();
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





  ///Setter
  bool _isLoading = false;
  bool _isSuccessful = false;
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
  bool get isSuccessful => _isSuccessful;
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


  Future<void> fetchOffers() async {
    final prefs = await SharedPreferences.getInstance();
    _offers = [];
    notifyListeners();
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

      if(response.statusCode == 200){
        // print("Trades Fetched: ${response.body}");
        offerModel = offersModelFromJson(response.body);
        final responseHere = offersModelFromJson(response.body);
        print("Here at mapping successful");
        final offerList = responseHere.offers;
        print("Length: ${offerList.length}");

        _isLastPage = offerList.length < numberOfPostsPerRequest;
        _loading = false;
        _pageNumber = _pageNumber + 1;
        _offers.addAll(offerList);

        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
  }

  Future<bool> enableOrDisableOffer() async {
    bool isUpdated = false;
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    _loading = true;
    notifyListeners();
    final body = {
      "location": _selectedOffer!.location,
      "type": _selectedOffer!.type,
      "min_amount": _selectedOffer!.minAmount,
      "max_amount": _selectedOffer!.maxAmount,
      "payment_method_code": _selectedOffer!.paymentMethod.code,
      "currency_code": _selectedOffer!.currency!.code,
      "coin_symbol": _selectedOffer!.coin!.symbol,
      "tags": [
        _selectedOffer!.tags
      ],
      "terms": _selectedOffer!.terms,
      "payment_window": _selectedOffer!.paymentWindow,
      "profit_margin": _selectedOffer!.profitMargin,
      "payment_details": "",
      "track_liquidity": _selectedOffer!.trackLiquidity == 1 ? true : false,
      "trusted_people_only": _selectedOffer!.trustedPeopleOnly == 1 ? true : false,
      "expiry_date": _selectedOffer!.expiryDate,
      "status": _selectedOffer!.status
    };
    try {
      final response = await http.put(Uri.parse(
        baseURL + "offers/${_selectedOffer!.reference}"
      ),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          },
        body: json.encode(body),
      );
      print("Status update response: ${response.body}");
      if(response.statusCode == 200 || response.statusCode == 201){
        isUpdated = true;
        _loading = false;
        notifyListeners();
      }

    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }

    return isUpdated;
  }



  //GET Trades on offer
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


//  CREATE OFFER
  Future<bool> createOffer({
    required BuildContext context,
    required CreateOfferModel createOfferModel,
  }) async {
    bool isCreated = false;
    _isSuccessful = false;
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    _isLoading = true;
    notifyListeners();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    try {
      final response =
      await http.post(
        Uri.parse("$baseURL${Endpoints.offers}"),
        body: json.encode(createOfferModel.toJson()),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },);
      print("Trades body=====: ${response.body} Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        _resMessage = "Offer created successfully";
        _isLoading = false;
        _isSuccessful = true;
        isCreated = true;
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
      print("Create Offer Exception: $e");
    }
    return isCreated;
  }
}
