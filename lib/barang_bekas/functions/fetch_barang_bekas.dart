import 'package:sayang_dibuang_mobile/barang_bekas/models/barang_bekas.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';

Future<List<BarangBekas>> fetchBarangBekas(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/barang/all/mobile/';
  var response = await request.get(
    url,
  );
  var data = response;

  List<BarangBekas> listBarangBekas = [];
  for (var d in data) {
    if (d != null) {
      // print(d);
      listBarangBekas.add(BarangBekas.fromJson(d));
    }
  }
  return listBarangBekas;
}

Future<List<Profile>> fetchOwner(request, id) async {
  var url = "https://sayang-dibuang.up.railway.app/barang/owner/$id/";
  var response = await request.get(
    url,
  );
  var data = response;
  List<Profile> owner = [];
  for (var d in data) {
    if (d != null) {
      Profile profile = Profile.fromJson(d);
      owner.add(profile);
    }
  }
  return owner;
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
    // print(d);
    if (d != null) {
      Lokasi lokasi = Lokasi.fromJson(d);
      listLokasi.add(lokasi.nama);
    }
  }
  return listLokasi;
}
