import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/models/barang_bekas.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

// ref: https://stackoverflow.com/questions/51161862/how-to-send-an-image-to-an-api-in-dart-flutter
upload(File imageFile) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse("Enter You API Url"),
  );
  Map<String, String> headers = {"Content-type": "multipart/form-data"};
  request.files.add(
    http.MultipartFile(
      'image',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: imageFile.path.split('/').last,
    ),
  );
  request.headers.addAll(headers);
  print("request: " + request.toString());
  var res = await request.send();
  http.Response response = await http.Response.fromStream(res);

  var resJson = jsonDecode(response.body);
  return resJson;
}

Future<File> getImage() async {
  // Pick an image
  final ImagePicker _picker = ImagePicker();
  //TO convert Xfile into file
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  File file = File(image!.path);
  return file;
}

createBarang(
    request, username, judul, deskripsi, foto, lokasi, kategori) async {
  // ref: https://kashifchandio.medium.com/upload-images-to-a-rest-api-with-flutter-using-http-61713964e1c
  // dimana taronya tlg
  // var request = http.MultipartRequest("POST", Uri.parse(urlInsertImage));
  // request.fields["ProductId"] = productId.toString();
  // request.files.add(http.MultipartFile.fromBytes("picture", File(file!.path).readAsBytesSync(),filename: file!.path));
  // var res = await request.send();
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
