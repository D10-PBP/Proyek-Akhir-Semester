// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) => List<UserProfile>.from(
    json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  UserProfile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.telephone,
    required this.whatsapp,
    required this.line,
    required this.poin,
  });

  User user;
  String telephone;
  String whatsapp;
  String line;
  int poin;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: User.fromJson(json["user"]),
        telephone: json["telephone"],
        whatsapp: json["whatsapp"],
        line: json["line"],
        poin: json["poin"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "telephone": telephone,
        "whatsapp": whatsapp,
        "line": line,
        "poin": poin,
      };
}

class User {
  User({
    required this.id,
    required this.isSuperuser,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  int id;
  bool isSuperuser;
  String username;
  String firstName;
  String lastName;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };
}
