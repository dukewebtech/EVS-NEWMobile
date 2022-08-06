// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

RegistrationErrorModel registrationErrorModelFromJson(String str) => RegistrationErrorModel.fromJson(json.decode(str));

String registrationErrorModelToJson(RegistrationErrorModel data) => json.encode(data.toJson());

class RegistrationErrorModel {
  RegistrationErrorModel({
    this.message,
    this.errors,
  });

  String? message;
  Errors? errors;

  factory RegistrationErrorModel.fromJson(Map<String, dynamic> json) => RegistrationErrorModel(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors!.toJson(),
  };
}

class Errors {
  Errors({
    this.firstName,
    this.lastName,
    this.username,
  });

  List<String>? firstName;
  List<String>? lastName;
  List<String>? username;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    firstName: List<String>.from(json["first_name"].map((x) => x)),
    lastName: List<String>.from(json["last_name"].map((x) => x)),
    username: List<String>.from(json["username"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "first_name": List<dynamic>.from(firstName!.map((x) => x)),
    "last_name": List<dynamic>.from(lastName!.map((x) => x)),
    "username": List<dynamic>.from(username!.map((x) => x)),
  };
}
