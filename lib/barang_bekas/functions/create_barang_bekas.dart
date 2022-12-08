import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/models/barang_bekas.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

createBarang(
    request, username, judul, deskripsi, foto, lokasi, kategori) async {
  var response =
      await request.post('https://sayang-dibuang.up.railway.app/upload/ajax/', {
    // TODO: body
    "username": username,
    "judul": judul,
    "deskripsi": deskripsi,
    "foto": foto, // ini gmn
    "lokasi": lokasi,
    "kategori": kategori,
  });
  return response['status'];
}

createKategori(request, jenis) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/add/kategori/', {
    "jenis": jenis,
  });
  return response['status'];
}

createLokasi(request, nama) async {
  var response =
      await request.post('https://sayang-dibuang.up.railway.app/add/lokasi/', {
    "nama": nama,
  });
  return response['status'];
}
