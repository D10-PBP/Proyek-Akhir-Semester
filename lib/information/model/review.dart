// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  Review({
    required this.username,
    required this.judul,
    required this.deskripsi,
    required this.created,
    required this.pk,
  });

  String username;
  String judul;
  String deskripsi;
  DateTime created;
  int pk;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        username: json["username"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        created: DateTime.parse(json["created"]),
        pk: json["pk"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "judul": judul,
        "deskripsi": deskripsi,
        "created": created.toIso8601String(),
        "pk": pk,
      };
}
