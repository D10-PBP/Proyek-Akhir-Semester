// To parse this JSON data, do
//
//     final errorMessage = errorMessageFromJson(jsonString);

import 'dart:convert';

ErrorMessage errorMessageFromJson(String str) =>
    ErrorMessage.fromJson(json.decode(str));

String errorMessageToJson(ErrorMessage data) => json.encode(data.toJson());

class ErrorMessage {
  ErrorMessage({
    this.password2,
    this.email,
    this.username,
    this.telephone,
    this.whatsapp,
  });

  List<Information>? password2;
  List<Information>? email;
  List<Information>? username;
  List<Information>? telephone;
  List<Information>? whatsapp;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        password2: json["password2"] == null
            ? null
            : List<Information>.from(
                json["password2"].map((x) => Information.fromJson(x))),
        email: json["email"] == null
            ? null
            : List<Information>.from(
                json["email"].map((x) => Information.fromJson(x))),
        username: json["username"] == null
            ? null
            : List<Information>.from(
                json["username"].map((x) => Information.fromJson(x))),
        telephone: json["telephone"] == null
            ? null
            : List<Information>.from(
                json["telephone"].map((x) => Information.fromJson(x))),
        whatsapp: json["whatsapp"] == null
            ? null
            : List<Information>.from(
                json["whatsapp"].map((x) => Information.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "password2": password2 == null
            ? null
            : List<dynamic>.from(password2!.map((x) => x.toJson())),
        "email": email == null
            ? null
            : List<dynamic>.from(email!.map((x) => x.toJson())),
        "username": username == null
            ? null
            : List<dynamic>.from(username!.map((x) => x.toJson())),
        "telephone": telephone == null
            ? null
            : List<dynamic>.from(telephone!.map((x) => x.toJson())),
        "whatsapp": whatsapp == null
            ? null
            : List<dynamic>.from(whatsapp!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    String errorSumarry = "";

    errorSumarry += (username != null) ? "${username![0].message!}\n" : "";
    errorSumarry += (password2 != null) ? "${password2![0].message!}\n" : "";
    errorSumarry += (email != null) ? "${email![0].message!}\n" : "";
    errorSumarry += (telephone != null) ? "${telephone![0].message!}\n" : "";
    errorSumarry += (whatsapp != null) ? "${whatsapp![0].message!}\n" : "";

    return errorSumarry;
  }
}

class Information {
  Information({
    this.message,
    this.code,
  });

  String? message;
  String? code;

  factory Information.fromJson(Map<String, dynamic> json) => Information(
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
      };
}
