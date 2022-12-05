import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sayang_dibuang_mobile/barang_bekas/models/barang_bekas.dart';

Future<List<BarangBekas>> fetchBarangBekas(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/barang/all/?search=';
  var response = await request.get(
    url,
  );
  var data = response;

  List<BarangBekas> listBarangBekas = [];
  for (var d in data) {
    if (d != null) {
      listBarangBekas.add(BarangBekas.fromJson(d));
    }
  }
  return listBarangBekas;
}

Future<List<String>> fetchKategori(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/barang/kategori/';
  var response = await request.get(
    url,
  );
  var data = response;
  List<String> listKategori = [];
  for (var d in data) {
    if (d != null) {
      Kategori kat = Kategori.fromJson(d);
      listKategori.add(kat.jenis);
    }
  }
  return listKategori;
}

Future<List<String>> fetchLokasi(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/barang/lokasi/';
  var response = await request.get(
    url,
  );
  var data = response;
  List<String> listLokasi = [];
  for (var d in data) {
    print(d);
    if (d != null) {
      Lokasi lokasi = Lokasi.fromJson(d);
      listLokasi.add(lokasi.nama);
    }
  }
  return listLokasi;
}

// Future<List<Lokasi>> fetchLokasi(request) async {
//   var url = Uri.parse('https://sayang-dibuang.up.railway.app/lokasi/');
//   var response = await request.get(
//     url,
//     headers: {
//       "Access-Control-Allow-Origin": "*",
//       "Content-Type": "application/json",
//     },
//   );
//   var data = jsonDecode(utf8.decode(response.bodyBytes));
//   List<Lokasi> listLokasi = [];
//   for (var d in data) {
//     if (d != null) {
//       listLokasi.add(Lokasi.fromJson(d));
//     }
//   }
//   return listLokasi;
// }
