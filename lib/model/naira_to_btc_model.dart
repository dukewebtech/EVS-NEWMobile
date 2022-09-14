// To parse this JSON data, do
//
//     final nairaToBtcModel = nairaToBtcModelFromJson(jsonString);

import 'dart:convert';

NairaToBtcModel nairaToBtcModelFromJson(String str) => NairaToBtcModel.fromJson(json.decode(str));

String nairaToBtcModelToJson(NairaToBtcModel data) => json.encode(data.toJson());

class NairaToBtcModel {
  NairaToBtcModel({
    required this.data,
  });

  Data data;

  factory NairaToBtcModel.fromJson(Map<String, dynamic> json) => NairaToBtcModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.rate,
    required this.btc,
  });

  int rate;
  double btc;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rate: json["rate"],
    btc: json["btc"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "btc": btc,
  };
}
