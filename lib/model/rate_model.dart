// To parse this JSON data, do
//
//     final rateModel = rateModelFromJson(jsonString);

import 'dart:convert';

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

String rateModelToJson(RateModel data) => json.encode(data.toJson());

class RateModel {
  RateModel({
    required this.data,
  });

  Data data;

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.rate,
  });

  int rate;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rate: json["rate"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
  };
}
