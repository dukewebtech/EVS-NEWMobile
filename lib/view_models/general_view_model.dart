import 'dart:convert';
import 'dart:io';

import 'package:evs_pay_mobile/model/send_btc_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:evs_pay_mobile/model/trades_model_api.dart';
import 'package:evs_pay_mobile/model/trades_on_offer_model.dart';
import 'package:evs_pay_mobile/model/transaction_history_api_model.dart';
import 'package:evs_pay_mobile/model/user_model/api_payment_method_model.dart';
import 'package:evs_pay_mobile/resources/ednpoints.dart';

import '../../widgets/loading_indicator.dart';
import '../resources/constants/constants.dart';
import '../resources/navigation_utils.dart';

class EvsPayViewModel extends ChangeNotifier {
  ///Setter
  bool _isLoading = false;
  bool _success = false;
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
  bool get success => _success;
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

  //Set selected Offer;
  void setSelectedOffer(OfferData offer) {
    _selectedOffer = offer;
    notifyListeners();
  }

  //Set selected Trade;
  void setSelectedTrade(TradeData trade) {
    _selectedTrade = trade;
    notifyListeners();
  }

   void clear() {
    _resMessage = "";
    notifyListeners();
  }

  //GET PAYMENT METHODS
  void getPaymentMethods({
    required BuildContext context,
  }) async {
    _isLoading = true;
    _success = false;
    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.paymentMethods}"),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("Response body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _paymentMethod = paymentMethodFromJson(response.body);
        _isLoading = false;
        _success = true;
        _resMessage = "";
        notifyListeners();
        // Navigator.pop(context);

      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
        final userNameError = res['errors']['email'][0] ?? "";
        _resMessage = "${res['message']}$userNameError";
        _isLoading = false;
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      } else {
        final res = json.decode(response.body);
        _resMessage = res['message'];
        _isLoading = false;
        _success = false;
        notifyListeners();
        // Navigator.pop(context);
      }
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }

  Future<bool> enableOrDisableOffer(BuildContext context) async {
    bool isUpdated = false;
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    _isLoading = true;

    print("Selected offer status: ${selectedOffer.status}");
    notifyListeners();
    final body = {
      "location": _selectedOffer!.location,
      "type": _selectedOffer!.type,
      "min_amount": _selectedOffer!.minAmount,
      "max_amount": _selectedOffer!.maxAmount,
      "payment_method_code": _selectedOffer!.paymentMethod.code,
      "currency_code": _selectedOffer!.currency!.code,
      "coin_symbol": _selectedOffer!.coin!.symbol,
      "tags": _selectedOffer!.tags,
      "terms": _selectedOffer!.terms,
      "payment_window": _selectedOffer!.paymentWindow,
      "profit_margin": _selectedOffer!.profitMargin,
      "payment_details": "",
      "track_liquidity": _selectedOffer!.trackLiquidity == 1 ? true : false,
      "trusted_people_only":
          _selectedOffer!.trustedPeopleOnly == 1 ? true : false,
      "expiry_date": _selectedOffer!.expiryDate.toString(),
      "status": _selectedOffer!.status == "ACTIVE" ? "INACTIVE" : "ACTIVE"
    };

    // print("Payload: $body");
    try {
      final response = await http.put(
        Uri.parse(baseURL + "offers/${_selectedOffer!.reference}"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },
        body: json.encode(body),
      );
      print("Status update response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        isUpdated = true;
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print("error --> $e");
      _isLoading = false;
      notifyListeners();
    }
    return isUpdated;
  }

  //GET TRANSACTION HISTORY
  Future<void> getTransactionHistory({
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    _isLoading = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    try {
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.transactionHistory}"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _transactionHistories = transactionHistoryModelFromJson(response.body);
        _resMessage = "";
        _isLoading = false;
        notifyListeners();
        Navigator.pop(context);
      } else if (response.statusCode == 422) {
        final res = json.decode(response.body);
        print("$res");
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

  //GET offers
  Future<void> getOffers({
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
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.offers}"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },
      );
      // print("offers body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        //first check for the user role
        _offer = offersModelFromJson(response.body);
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
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.trades}"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },
      );
      print("Trades body=====: ${response.body}");
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
  Future<void> getTradesOnOffer(
      {required BuildContext context, required String offerId}) async {
    final prefs = await SharedPreferences.getInstance();
    final retrievedAccessToken = prefs.getString(accessToken);
    _isLoading = true;
    print("$baseURL${Endpoints.offers}/$offerId/trades");
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    try {
      final response = await http.get(
        Uri.parse("$baseURL${Endpoints.offers}/$offerId/trades"),
        headers: {
          'Authorization': 'Bearer $retrievedAccessToken',
          'Content-Type': 'application/json',
        },
      );
      print("Trades body=====: ${response.body}");
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

  //sendBTC

  Future<void> sendBTC(
      {required BuildContext context,
      required String walletAdresss,
      required double amount,
      required password,
      required String? description}) async {
    final prefs = await SharedPreferences.getInstance();
    _isLoading = true;
    _success = false;
    showDialog(
        context: context,
        builder: (BuildContext context) => const LoadingIndicator());
    notifyListeners();

    final retrievedAccessToken = prefs.getString(accessToken);

    final body = {
      "destination_address": walletAdresss,
      "amount": amount,
      "password": password,
      " description": description,
    };
    try {
      // http://evspay.com/api/
      final response = await http.post(
          Uri.parse(
              "http://evspay.com/api/btc/wallets/transactions/transfer-funds"),
          headers: {
            'Authorization': 'Bearer $retrievedAccessToken',
            'Content-Type': 'application/json',
          },
          body: json.encode(body));
      print("send btc response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // final sendbtc = SendBTCModel.fromJson(body);
        _isLoading = false;
        _success = true;
        _resMessage = "Successful";
        notifyListeners();
        Navigator.pop(context);
      } else if (response.statusCode == 400) {
        // final res = json.decode(response.body);
        // print("$res");
        _isLoading = false;
         _resMessage = "UnSuccessful";
        _success = false;
        notifyListeners();
        Navigator.pop(context);
      }
      notifyListeners();
    } on SocketException catch (_) {
      _isLoading = false;
      _success = false;
      _resMessage = "Internet connection is not available";
      notifyListeners();
      Navigator.pop(context);
    } catch (e) {
      _isLoading = false;
      _success = false;
      _resMessage = "Please try again";
      notifyListeners();
      Navigator.pop(context);
      // print("exception: $e");
    }
  }
}
