// To parse this JSON data, do
//
//     final paymentMethod = paymentMethodFromJson(jsonString);

import 'dart:convert';

PaymentMethod paymentMethodFromJson(String str) => PaymentMethod.fromJson(json.decode(str));

String paymentMethodToJson(PaymentMethod data) => json.encode(data.toJson());

class PaymentMethod {
  PaymentMethod({
    required this.paymentMethods,
    this.links,
    this.meta,
  });

  List<PaymentMethods> paymentMethods;
  Links? links;
  Meta? meta;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    paymentMethods: List<PaymentMethods>.from(json["data"].map((x) => PaymentMethods.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(paymentMethods.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class PaymentMethods {
  PaymentMethods({
    this.name,
    this.code,
  });

  String? name;
  String? code;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  dynamic first;
  dynamic last;
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

  dynamic currentPage;
  dynamic from;
  dynamic lastPage;
  dynamic path;
  dynamic perPage;
  dynamic to;
  dynamic total;

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
