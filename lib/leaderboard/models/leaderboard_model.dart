// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.username,
    required this.poin,
    required this.status,
  });

  String username;
  int poin;
  int status;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        poin: json["poin"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "poin": poin,
        "status": status,
      };
}
