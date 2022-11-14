// To parse this JSON data, do
//
//     final newTradeModel = newTradeModelFromJson(jsonString);

import 'dart:convert';

NewTradeModel newTradeModelFromJson(String str) => NewTradeModel.fromJson(json.decode(str));

String newTradeModelToJson(NewTradeModel data) => json.encode(data.toJson());

class NewTradeModel {
  NewTradeModel({
    this.data,
    this.links,
    this.meta,
  });

  List<NewTradeData>? data;
  Links? links;
  Meta? meta;

  factory NewTradeModel.fromJson(Map<String, dynamic> json) => NewTradeModel(
    data: List<NewTradeData>.from(json["data"].map((x) => NewTradeData.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "links": links!.toJson(),
    "meta": meta!.toJson(),
  };
}

class NewTradeData {
  NewTradeData({
    this.reference,
    this.type,
    this.fee,
    this.amount,
    this.coinValue,
    this.status,
    this.deadline,
    this.createdAt,
    this.confirmedAt,
    this.paymentDocument,
    this.user,
    this.partner,
    this.coin,
    this.offer,
    this.currency,
    this.paymentMethod,
  });

  dynamic reference;
  dynamic type;
  dynamic fee;
  dynamic amount;
  dynamic coinValue;
  dynamic status;
  DateTime? deadline;
  DateTime? createdAt;
  DateTime? confirmedAt;
  dynamic paymentDocument;
  Partner? user;
  Partner? partner;
  Coin? coin;
  Offer? offer;
  Currency? currency;
  NewPaymentMethod? paymentMethod;

  factory NewTradeData.fromJson(Map<String, dynamic> json) => NewTradeData(
    reference: json["reference"],
    type: json["type"],
    fee: json["fee"],
    amount: json["amount"],
    coinValue: json["coin_value"].toDouble(),
    status: json["status"],
    deadline: DateTime.parse(json["deadline"]),
    createdAt: DateTime.parse(json["created_at"]),
    confirmedAt: json["confirmed_at"] == null ? null : DateTime.parse(json["confirmed_at"]),
    paymentDocument: json["payment_document"],
    user: Partner.fromJson(json["user"]),
    partner: Partner.fromJson(json["partner"]),
    coin: Coin.fromJson(json["coin"]),
    offer: Offer.fromJson(json["offer"]),
    currency: Currency.fromJson(json["currency"]),
    paymentMethod: NewPaymentMethod.fromJson(json["payment_method"]),
  );

  Map<String, dynamic> toJson() => {
    "reference": reference,
    "type": type,
    "fee": fee,
    "amount": amount,
    "coin_value": coinValue,
    "status": status,
    "deadline": deadline!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "confirmed_at": confirmedAt == null ? null : confirmedAt!.toIso8601String(),
    "payment_document": paymentDocument,
    "user": user!.toJson(),
    "partner": partner!.toJson(),
    "coin": coin!.toJson(),
    "offer": offer!.toJson(),
    "currency": currency!.toJson(),
    "payment_method": paymentMethod!.toJson(),
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



class Offer {
  Offer({
    this.reference,
    this.type,
    this.minAmount,
    this.maxAmount,
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
  });

  dynamic reference;
  dynamic type;
  dynamic minAmount;
  dynamic maxAmount;
  dynamic location;
  dynamic terms;
  dynamic paymentWindow;
  dynamic profitMargin;
  dynamic pricePerCoin;
  dynamic status;
  dynamic expiryDate;
  dynamic trackLiquidity;
  dynamic trustedPeopleOnly;
  DateTime? createdAt;
  NewPaymentMethod? paymentMethod;
  Currency? currency;
  Coin? coin;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
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
    expiryDate: json["expiry_date"],
    trackLiquidity: json["track_liquidity"],
    trustedPeopleOnly: json["trusted_people_only"],
    createdAt: DateTime.parse(json["created_at"]),
    paymentMethod: NewPaymentMethod.fromJson(json["payment_method"]),
    currency: Currency.fromJson(json["currency"]),
    coin: Coin.fromJson(json["coin"]),
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
    "expiry_date": expiryDate,
    "track_liquidity": trackLiquidity,
    "trusted_people_only": trustedPeopleOnly,
    "created_at": createdAt!.toIso8601String(),
    "payment_method": paymentMethod!.toJson(),
    "currency": currency!.toJson(),
    "coin": coin!.toJson(),
  };
}

class NewPaymentMethod {
  NewPaymentMethod({
    this.name,
    this.code,
  });

  dynamic name;
  dynamic code;

  factory NewPaymentMethod.fromJson(Map<String, dynamic> json) => NewPaymentMethod(
    name: json["name"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "code": code,
  };
}







class Partner {
  Partner({
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

  dynamic id;
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

  factory Partner.fromJson(Map<String, dynamic> json) => Partner(
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

  dynamic address;
  dynamic idCard;

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

