// To parse this JSON data, do
//
//     final dashboardTradeModel = dashboardTradeModelFromJson(jsonString);

import 'dart:convert';

DashboardTradeModel dashboardTradeModelFromJson(String str) =>
    DashboardTradeModel.fromJson(json.decode(str));

String dashboardTradeModelToJson(DashboardTradeModel data) =>
    json.encode(data.toJson());

class DashboardTradeModel {
  DashboardTradeModel({
    this.trades,
    this.links,
    this.meta,
  });

  List<DashboardTradeData>? trades;
  Links? links;
  Meta? meta;

  factory DashboardTradeModel.fromJson(Map<String, dynamic> json) =>
      DashboardTradeModel(
        trades: List<DashboardTradeData>.from(
            json["data"].map((x) => DashboardTradeData.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(trades!.map((x) => x.toJson())),
        "links": links!.toJson(),
        "meta": meta!.toJson(),
      };
}

class DashboardTradeData {
  DashboardTradeData({
    this.reference,
    this.type,
    this.minAmount,
    this.maxAmount,
    // this.tags,
    this.location,
    this.terms,
    this.paymentWindow,
    this.profitMargin,
    this.pricePerCoin,
    this.status,
    this.expiryDate,
    this.trackLiquidity,
    this.trustedPeopleOnly,
    this.createdAt,
    this.paymentMethod,
    this.currency,
    this.coin,
    this.user,
  });

  String? reference;
  dynamic type;
  dynamic minAmount;
  dynamic maxAmount;
  // List<String> tags;
  dynamic location;
  dynamic terms;
  dynamic paymentWindow;
  dynamic profitMargin;
  dynamic pricePerCoin;
  dynamic status;
  DateTime? expiryDate;
  dynamic trackLiquidity;
  dynamic trustedPeopleOnly;
  DateTime? createdAt;
  PaymentMethod? paymentMethod;
  Currency? currency;
  Coin? coin;
  User? user;

  factory DashboardTradeData.fromJson(Map<String, dynamic> json) =>
      DashboardTradeData(
        reference: json["reference"],
        type: json["type"],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
        location: json["location"],
        terms: json["terms"],
        paymentWindow: json["payment_window"],
        profitMargin: json["profit_margin"],
        pricePerCoin: json["price_per_coin"].toDouble(),
        status: json["status"],
        expiryDate: DateTime.parse(json["expiry_date"]),
        trackLiquidity: json["track_liquidity"],
        trustedPeopleOnly: json["trusted_people_only"],
        createdAt: DateTime.parse(json["created_at"]),
        paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
        currency: Currency.fromJson(json["currency"]),
        coin: Coin.fromJson(json["coin"]),
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "type": type,
        "min_amount": minAmount,
        "max_amount": maxAmount,
        "location": location,
        "terms": terms,
        "payment_window": paymentWindow,
        "profit_margin": profitMargin,
        "price_per_coin": pricePerCoin,
        "status": status,
        "expiry_date": expiryDate!.toIso8601String(),
        "track_liquidity": trackLiquidity,
        "trusted_people_only": trustedPeopleOnly,
        "created_at": createdAt!.toIso8601String(),
        "payment_method": paymentMethod!.toJson(),
        "currency": currency!.toJson(),
        "coin": coin!.toJson(),
        "user": user!.toJson(),
      };
}

class Coin {
  Coin({
    this.name,
    this.symbol,
  });

  dynamic name;
  dynamic symbol;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Currency {
  Currency({
    this.name,
    this.code,
    this.symbol,
  });

  dynamic name;
  dynamic code;
  dynamic symbol;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        code: json["code"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "symbol": symbol,
      };
}

class PaymentMethod {
  PaymentMethod({
    this.name,
    this.code,
  });

  dynamic name;
  dynamic code;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.username,
    this.type,
    this.documents,
    this.email,
    this.emailVerified,
    this.phone,
    this.phoneVerified,
    this.homeVerified,
    this.idcardVerified,
    this.bio,
    this.photo,
  });

  int? id;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic username;
  dynamic type;
  Documents? documents;
  dynamic email;
  dynamic emailVerified;
  dynamic phone;
  dynamic phoneVerified;
  dynamic homeVerified;
  dynamic idcardVerified;
  dynamic bio;
  dynamic photo;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        username: json["username"],
        type: json["type"],
        documents: Documents.fromJson(json["documents"]),
        email: json["email"],
        emailVerified: json["email_verified"],
        phone: json["phone"],
        phoneVerified: json["phone_verified"],
        homeVerified: json["home_verified"],
        idcardVerified: json["idcard_verified"],
        bio: json["bio"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "username": username,
        "type": type,
        "documents": documents!.toJson(),
        "email": email,
        "email_verified": emailVerified,
        "phone": phone,
        "phone_verified": phoneVerified,
        "home_verified": homeVerified,
        "idcard_verified": idcardVerified,
        "bio": bio,
        "photo": photo,
      };
}

class Documents {
  Documents({
    required this.address,
    required this.idCard,
  });

  bool address;
  bool idCard;

  factory Documents.fromJson(Map<String, dynamic> json) => Documents(
        address: json["address"],
        idCard: json["id_card"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "id_card": idCard,
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
