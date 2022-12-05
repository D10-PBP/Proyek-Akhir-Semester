import 'dart:convert';

List<BarangBekas> myBarangBekasFromJson(String str) => List<BarangBekas>.from(
    json.decode(str).map((x) => BarangBekas.fromJson(x)));

String myWatchListToJson(List<BarangBekas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BarangBekas {
  BarangBekas({
    required this.pk,
    required this.profile,
    required this.foto,
    required this.judul,
    required this.deskripsi,
    required this.uploadedAt,
    required this.lokasi,
    required this.kategori,
    required this.available,
  });

  int pk;
  int profile;
  String foto;
  String judul;
  String deskripsi;
  String uploadedAt;
  String lokasi;
  String kategori;
  bool available;

  factory BarangBekas.fromJson(Map<String, dynamic> json) => BarangBekas(
        pk: json["pk"],
        profile: json["fields"]["profile"],
        foto: json["fields"]["foto"],
        judul: json["fields"]["judul"],
        deskripsi: json["fields"]["deskripsi"],
        uploadedAt: json["fields"]["uploaded_at"],
        lokasi: json["fields"]["lokasi"],
        kategori: json["fields"]["kategori"],
        available: json["fields"]["available"],
      );

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "profile": profile,
        "foto": foto,
        "judul": judul,
        "deskripsi": deskripsi,
        "uploadedAt": uploadedAt,
        "lokasi": lokasi,
        "kategori": kategori,
        "available": available,
      };
}

class Lokasi {
  Lokasi({
    required this.pk,
    required this.nama,
  });
  int pk;
  String nama;

  factory Lokasi.fromJson(Map<String, dynamic> json) =>
      Lokasi(pk: json["pk"], nama: json["fields"]["nama"]);
  Map<String, dynamic> toJson() => {
        "pk": pk,
        "nama": nama,
      };
}

class Kategori {
  Kategori({
    required this.pk,
    required this.jenis,
  });
  int pk;
  String jenis;

  factory Kategori.fromJson(Map<String, dynamic> json) =>
      Kategori(pk: json["pk"], jenis: json["fields"]["jenis"]);
  Map<String, dynamic> toJson() => {
        "pk": pk,
        "jenis": jenis,
      };
}
