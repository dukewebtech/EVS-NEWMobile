// To parse this JSON data, do
//
//     final initOfferModel = initOfferModelFromJson(jsonString);

import 'dart:convert';

InitTradeModel initTradeModelFromJson(String str) => InitTradeModel.fromJson(json.decode(str));

String initTradeModelToJson(InitTradeModel data) => json.encode(data.toJson());

class InitTradeModel {
  InitTradeModel({
    this.data,
  });

  Data? data;

  factory InitTradeModel.fromJson(Map<String, dynamic> json) => InitTradeModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
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
  dynamic confirmedAt;
  dynamic paymentDocument;
  Partner? user;
  Partner? partner;
  Coin? coin;
  Offer? offer;
  Currency? currency;
  PaymentMethod? paymentMethod;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reference: json["reference"],
    type: json["type"],
    fee: json["fee"],
    amount: json["amount"],
    coinValue: json["coin_value"].toDouble(),
    status: json["status"],
    deadline: DateTime.parse(json["deadline"]),
    createdAt: DateTime.parse(json["created_at"]),
    confirmedAt: json["confirmed_at"],
    paymentDocument: json["payment_document"],
    user: Partner.fromJson(json["user"]),
    partner: Partner.fromJson(json["partner"]),
    coin: Coin.fromJson(json["coin"]),
    offer: Offer.fromJson(json["offer"]),
    currency: Currency.fromJson(json["currency"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
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
    "confirmed_at": confirmedAt,
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
  DateTime? expiryDate;
  dynamic trackLiquidity;
  dynamic trustedPeopleOnly;
  DateTime? createdAt;
  PaymentMethod? paymentMethod;
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
    expiryDate: DateTime.parse(json["expiry_date"]),
    trackLiquidity: json["track_liquidity"],
    trustedPeopleOnly: json["trusted_people_only"],
    createdAt: DateTime.parse(json["created_at"]),
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
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
    "expiry_date": "${expiryDate!.year.toString().padLeft(4, '0')}-${expiryDate!.month.toString().padLeft(2, '0')}-${expiryDate!.day.toString().padLeft(2, '0')}",
    "track_liquidity": trackLiquidity,
    "trusted_people_only": trustedPeopleOnly,
    "created_at": createdAt!.toIso8601String(),
    "payment_method": paymentMethod!.toJson(),
    "currency": currency!.toJson(),
    "coin": coin!.toJson(),
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
  bool? idcardVerified;
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
    "bio": bio == null ? null : bio,
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
