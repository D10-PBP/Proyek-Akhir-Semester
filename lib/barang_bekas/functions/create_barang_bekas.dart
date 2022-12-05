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
  // open a bytestream
  var stream =
      new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();

  // string to uri
  var uri = Uri.parse("https://sayang-dibuang.up.railway.app/");

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file
  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename(imageFile.path));

  // add file to multipart
  request.files.add(multipartFile);

  // send
  var response = await request.send();
  print(response.statusCode);

  // listen for response
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}

Future<File> getImage() async {
  // Pick an image
  final ImagePicker _picker = ImagePicker();
  //TO convert Xfile into file
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  File file = File(image!.path);
  return file;
}

createBarang(request, username, judul, deskripsi, foto) async {
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
    "foto": foto // ini gmn
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
