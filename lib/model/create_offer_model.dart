// To parse this JSON data, do
//
//     final createTradrModel = createTradrModelFromJson(jsonString);

import 'dart:convert';

CreateOfferModel createOfferModelFromJson(String str) => CreateOfferModel.fromJson(json.decode(str));

String createOfferModelToJson(CreateOfferModel data) => json.encode(data.toJson());

class CreateOfferModel {
  CreateOfferModel({
    required this.location,
    required this.type,
    required this.minAmount,
    required this.maxAmount,
    required this.paymentMethodCode,
    required this.currencyCode,
    required this.coinSymbol,
    required this.tags,
    required this.terms,
    required this.paymentWindow,
    required this.profitMargin,
    required this.paymentDetails,
    required this.trackLiquidity,
    required this.trustedPeopleOnly,
    required this.expiryDate,
  });

  String location;
  String type;
  int minAmount;
  int maxAmount;
  String paymentMethodCode;
  String currencyCode;
  String coinSymbol;
  List<String> tags;
  String terms;
  int paymentWindow;
  int profitMargin;
  String paymentDetails;
  bool trackLiquidity;
  bool trustedPeopleOnly;
  DateTime expiryDate;

  factory CreateOfferModel.fromJson(Map<String, dynamic> json) => CreateOfferModel(
    location: json["location"],
    type: json["type"],
    minAmount: json["min_amount"],
    maxAmount: json["max_amount"],
    paymentMethodCode: json["payment_method_code"],
    currencyCode: json["currency_code"],
    coinSymbol: json["coin_symbol"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    terms: json["terms"],
    paymentWindow: json["payment_window"],
    profitMargin: json["profit_margin"],
    paymentDetails: json["payment_details"],
    trackLiquidity: json["track_liquidity"],
    trustedPeopleOnly: json["trusted_people_only"],
    expiryDate: DateTime.parse(json["expiry_date"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "type": type,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "payment_method_code": paymentMethodCode,
    "currency_code": currencyCode,
    "coin_symbol": coinSymbol,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "terms": terms,
    "payment_window": paymentWindow,
    "profit_margin": profitMargin,
    "payment_details": paymentDetails,
    "track_liquidity": trackLiquidity,
    "trusted_people_only": trustedPeopleOnly,
    "expiry_date": expiryDate.toIso8601String(),
  };
}
