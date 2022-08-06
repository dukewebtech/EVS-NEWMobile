import 'package:evs_pay_mobile/model/offers_model_api.dart';
import 'package:evs_pay_mobile/model/trades_model_api.dart';
import 'package:evs_pay_mobile/model/trades_on_offer_model.dart';
import 'package:evs_pay_mobile/model/transaction_history_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/constants/constants.dart';



class WalletViewModel extends ChangeNotifier {
  //NEW
  bool _isLastPage = false;
  int _pageNumber = 0;
  String _url = "http://evspay.com/api/btc/wallets/transactions";
  bool _error = false;
  bool _loading = false;
  final int numberOfPostsPerRequest = 10;
  final List<TransactionHistoryData> _transactionHist = [];
  TransactionHistoryModel? transactionHistoryModel;
  final int nextPageTrigger = 3;



  bool get isLastPage => _isLastPage;
  int get pageNumber => _pageNumber;
  String get url => _url;
  bool get error => _error;
  bool get loading => _loading;

  List<TransactionHistoryData> get transactions => _transactionHist;


  WalletViewModel(){
    fetchTransactions();
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


  Future<void> fetchTransactions() async {
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
      transactionHistoryModel = transactionHistoryModelFromJson(response.body);
      final responseHere = transactionHistoryModelFromJson(response.body);
      print("Here at mapping successful");
      final transactionList = responseHere.data!;
      print("Length: ${transactionList.length}");

      _isLastPage = transactionList.length < numberOfPostsPerRequest;
      _loading = false;
      _pageNumber = _pageNumber + 1;
      _transactionHist.addAll(transactionList);

      notifyListeners();
    } catch (e) {
      print("error --> $e");
      _loading = false;
      _error = true;
      notifyListeners();
    }
  }

}
