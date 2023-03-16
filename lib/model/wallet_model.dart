// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  WalletModel({
    this.data,
    this.links,
    this.meta,
  });

  List<WalletData>? data;
  Links? links;
  Meta? meta;

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        data: List<WalletData>.from(
            json["data"].map((x) => WalletData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class WalletData {
  WalletData({
    this.walletId,
    this.balance,
    this.confirmedBalance,
    this.spendableBalance,
    this.createdAt,
    this.updatedAt,
    this.coin,
    this.receivableAddress,
  });

  String? walletId;
  dynamic balance;
  dynamic confirmedBalance;
  dynamic spendableBalance;
  DateTime? createdAt;
  DateTime? updatedAt;
  Coin? coin;
  ReceivableAddress? receivableAddress;

  factory WalletData.fromJson(Map<String, dynamic> json) => WalletData(
        walletId: json["walletId"],
        balance: json["balance"],
        confirmedBalance: json["confirmed_balance"],
        spendableBalance: json["spendable_balance"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        coin: Coin.fromJson(json["coin"]),
        receivableAddress:
            ReceivableAddress.fromJson(json["receivableAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "walletId": walletId,
        "balance": balance,
        "confirmed_balance": confirmedBalance,
        "spendable_balance": spendableBalance,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "coin": coin!.toJson(),
        "receivableAddress": receivableAddress!.toJson(),
      };
}

class Coin {
  Coin({
    this.name,
    this.symbol,
  });

  String? name;
  String? symbol;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class ReceivableAddress {
  ReceivableAddress({
    this.address,
    this.label,
    this.receivable,
    this.createdAt,
    this.updatedAt,
  });

  String? address;
  dynamic label;
  bool? receivable;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ReceivableAddress.fromJson(Map<String, dynamic> json) =>
      ReceivableAddress(
        address: json["address"],
        label: json["label"],
        receivable: json["receivable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "label": label,
        "receivable": receivable,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}
