// To parse this JSON data, do
//
//     final transactionHistoryModel = transactionHistoryModelFromJson(jsonString);

import 'dart:convert';

TransactionHistoryModel transactionHistoryModelFromJson(String str) => TransactionHistoryModel.fromJson(json.decode(str));

String transactionHistoryModelToJson(TransactionHistoryModel data) => json.encode(data.toJson());

class TransactionHistoryModel {
  TransactionHistoryModel({
    this.data,
    this.links,
    this.meta,
  });

  List<TransactionHistoryData>? data;
  Links? links;
  Meta? meta;

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) => TransactionHistoryModel(
    data: List<TransactionHistoryData>.from(json["data"].map((x) => TransactionHistoryData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class TransactionHistoryData {
  TransactionHistoryData({
    this.transactionReference,
    this.receiverWalletAddress,
    this.senderWalletAddress,
    this.type,
    this.value,
    this.state,
    this.action,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  String? transactionReference;
  String? receiverWalletAddress;
  String? senderWalletAddress;
  dynamic type;
  double? value;
  dynamic state;
  dynamic action;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory TransactionHistoryData.fromJson(Map<String, dynamic> json) => TransactionHistoryData(
    transactionReference: json["transaction_reference"],
    receiverWalletAddress: json["receiver_wallet_address"],
    senderWalletAddress: json["sender_wallet_address"],
    type: json["type"],
    value: json["value"].toDouble(),
    state: json["state"],
    action: json["action"],
    description: json["description"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "transaction_reference": transactionReference,
    "receiver_wallet_address": receiverWalletAddress,
    "sender_wallet_address": senderWalletAddress,
    "type": type,
    "value": value,
    "state": state,
    "action": action,
    "description": description,
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
  String? next;

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

