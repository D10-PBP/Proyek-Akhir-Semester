import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sayang_dibuang_mobile/information/model/review.dart';

Future<List<Review>> fetchReview(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/review/all/';
  var response = await request.get(
    url,
  );
  var data = response;

  List<Review> listBarangBekas = [];
  for (var d in data) {
    if (d != null) {
      // print(d);
      listBarangBekas.add(Review.fromJson(d));
    }
  }
  return listBarangBekas;
}
