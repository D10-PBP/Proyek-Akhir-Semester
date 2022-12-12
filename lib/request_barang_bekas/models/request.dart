import 'dart:convert';

List<Request> myRequestFromJson(String str) => List<Request>.from(
    json.decode(str).map((x) => Request.fromJson(x)));

String myWatchListToJson(List<Request> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Request {
  Request({
    required this.pk,
    required this.profile,
    required this.namaBarang,
    required this.deskripsi,
    required this.uploadedAt,
    required this.kategori,
    required this.available,
  });

  int pk;
  int profile;
  String namaBarang;
  String deskripsi;
  String uploadedAt;
  String kategori;
  bool available;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        pk: json["pk"],
        profile: json["fields"]["profile"],
        namaBarang: json["fields"]["nama_barang"],
        deskripsi: json["fields"]["deskripsi"],
        uploadedAt: json["fields"]["uploaded_at"],
        kategori: json["fields"]["kategori"],
        available: json["fields"]["available"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "profile": profile,
        "namaBarang": namaBarang,
        "deskripsi": deskripsi,
        "uploadedAt": uploadedAt,
        "kategori": kategori,
        "available": available,
      };
}

class Owner {
  Owner({
    required this.model,
    required this.pk,
    required this.user,
    required this.telephone,
    required this.whatsapp,
    required this.line,
    required this.poin,
  });

  String model;
  int pk;

  int user;
  String telephone;
  String whatsapp;
  String line;
  int poin;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        model: json["model"],
        pk: json["pk"],
        user: json["fields"]["user"],
        telephone: json["fields"]["telephone"],
        whatsapp: json["fields"]["whatsapp"],
        line: json["fields"]["line"],
        poin: json["fields"]["poin"],
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "user": user,
        "telephone": telephone,
        "whatsapp": whatsapp,
        "line": line,
        "poin": poin,
      };
}
