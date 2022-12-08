// To parse this JSON data, do
//
//     final crowdfund = crowdfundFromJson(jsonString);

import 'dart:convert';

List<Crowdfund> crowdfundFromJson(String str) =>
    List<Crowdfund>.from(json.decode(str).map((x) => Crowdfund.fromJson(x)));

String crowdfundToJson(List<Crowdfund> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Crowdfund {
  Crowdfund({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.created,
    required this.received,
    required this.target,
    required this.isAccomplished,
    required this.profile,
  });

  int id;
  int userId;
  String title;
  String description;
  DateTime created;
  int received;
  int target;
  bool isAccomplished;
  Profile profile;

  factory Crowdfund.fromJson(Map<String, dynamic> json) => Crowdfund(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
        received: json["received"],
        target: json["target"],
        isAccomplished: json["is_accomplished"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "created": created.toIso8601String(),
        "received": received,
        "target": target,
        "is_accomplished": isAccomplished,
        "profile": profile.toJson(),
      };

  @override
  String toString() {
    return 'id: ${id} - userId: ${userId}';
  }
}

class Profile {
  Profile({
    required this.id,
    required this.telephone,
    required this.whatsapp,
    required this.line,
    required this.poin,
    required this.user,
  });

  int id;
  String telephone;
  String whatsapp;
  String line;
  int poin;
  User user;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        telephone: json["telephone"],
        whatsapp: json["whatsapp"],
        line: json["line"],
        poin: json["poin"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "telephone": telephone,
        "whatsapp": whatsapp,
        "line": line,
        "poin": poin,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  int id;
  String username;
  String firstName;
  String lastName;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };
}
