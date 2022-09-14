// To parse this JSON data, do
//
//     final btcToNairaModel = btcToNairaModelFromJson(jsonString);

import 'dart:convert';

BtcToNairaModel btcToNairaModelFromJson(String str) => BtcToNairaModel.fromJson(json.decode(str));

String btcToNairaModelToJson(BtcToNairaModel data) => json.encode(data.toJson());

class BtcToNairaModel {
  BtcToNairaModel({
    required this.data,
  });

  Data data;

  factory BtcToNairaModel.fromJson(Map<String, dynamic> json) => BtcToNairaModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.rate,
    required this.naira,
  });

  int rate;
  double naira;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    rate: json["rate"],
    naira: json["naira"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "naira": naira,
  };
}
