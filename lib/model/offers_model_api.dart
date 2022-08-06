// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'dart:convert';

OffersModel offersModelFromJson(String str) => OffersModel.fromJson(json.decode(str));

String offersModelToJson(OffersModel data) => json.encode(data.toJson());

class OffersModel {
  OffersModel({
   required this.offers,
    required this.links,
    required this.meta,
  });

  List<OfferData> offers;
  Links links;
  Meta meta;

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
    offers: List<OfferData>.from(json["data"].map((x) => OfferData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(offers.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class OfferData {
  OfferData({
    required this.reference,
    required this.type,
    required this.minAmount,
    required this.maxAmount,
    required this.tags,
    required this.location,
    required this.terms,
    this.paymentWindow,
    this.profitMargin,
    this.pricePerCoin,
    this.status,
    this.expiryDate,
    this.trackLiquidity,
    this.trustedPeopleOnly,
    this.createdAt,
    required this.paymentMethod,
    this.currency,
    this.coin,
    this.user,
  });

  String reference;
  String type;
  int minAmount;
  int maxAmount;
  List<String> tags;
  String location;
  String terms;
  int? paymentWindow;
  int? profitMargin;
  int? pricePerCoin;
  String? status;
  DateTime? expiryDate;
  int? trackLiquidity;
  int? trustedPeopleOnly;
  DateTime? createdAt;
  OfferPaymentMethod paymentMethod;
  Currency? currency;
  Coin? coin;
  User? user;

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
    reference: json["reference"],
    type: json["type"],
    minAmount: json["min_amount"],
    maxAmount: json["max_amount"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    location: json["location"],
    terms: json["terms"],
    paymentWindow: json["payment_window"],
    profitMargin: json["profit_margin"],
    pricePerCoin: json["price_per_coin"],
    status: json["status"],
    expiryDate: DateTime.parse(json["expiry_date"]),
    trackLiquidity: json["track_liquidity"],
    trustedPeopleOnly: json["trusted_people_only"],
    createdAt: DateTime.parse(json["created_at"]),
    paymentMethod: OfferPaymentMethod.fromJson(json["payment_method"]),
    currency: Currency.fromJson(json["currency"]),
    coin: Coin.fromJson(json["coin"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "type": type,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "location": location,
    "terms": terms,
    "payment_window": paymentWindow,
    "profit_margin": profitMargin,
    "price_per_coin": pricePerCoin,
    "status": status,
    "expiry_date": "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
    "track_liquidity": trackLiquidity,
    "trusted_people_only": trustedPeopleOnly,
    "created_at": createdAt!.toIso8601String(),
    "payment_method": paymentMethod.toJson(),
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

class Currency {
  Currency({
    this.name,
    this.code,
    this.symbol,
  });

  String? name;
  String? code;
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

class OfferPaymentMethod {
  OfferPaymentMethod({
    this.name,
    this.code,
  });

  String? name;
  String? code;

  factory OfferPaymentMethod.fromJson(Map<String, dynamic> json) => OfferPaymentMethod(
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
  String? firstName;
  dynamic middleName;
  String? lastName;
  String? username;
  String? type;
  Documents? documents;
  String? email;
  bool? emailVerified;
  String? phone;
  bool? phoneVerified;
  bool? homeVerified;
  bool? idcardVerified;
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
    this.address,
    this.idCard,
  });

  bool? address;
  bool? idCard;

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
