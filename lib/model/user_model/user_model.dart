// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.accessToken ,
    this.tokenType,
    this.expiresIn,
    this.lastSeen,
    this.twoFactorEnabled,
    this.user,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;
  DateTime? lastSeen;
  bool? twoFactorEnabled;
  User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    lastSeen: DateTime.parse(json["last_seen"]),
    twoFactorEnabled: json["two_factor_enabled"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "last_seen": lastSeen!.toIso8601String(),
    "two_factor_enabled": twoFactorEnabled,
    "user": user!.toJson(),
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
    this.idCardVerified,
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
  bool? idCardVerified;
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
    idCardVerified: json["idcard_verified"],
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
    "idcard_verified": idCardVerified,
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
