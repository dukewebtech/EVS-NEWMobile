// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.data,
  });

  Data? data;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data!.toJson(),
  };
}

class Data {
  Data({
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

  dynamic id;
  dynamic firstName;
  dynamic middleName;
  dynamic lastName;
  dynamic username;
  dynamic type;
  Documents? documents;
  dynamic email;
  bool? emailVerified;
  dynamic phone;
  bool? phoneVerified;
  bool? homeVerified;
  bool? idCardVerified;
  dynamic bio;
  dynamic photo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
