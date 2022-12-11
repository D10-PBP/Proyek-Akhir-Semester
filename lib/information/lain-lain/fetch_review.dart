import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sayang_dibuang_mobile/information/model/review.dart';

Future<List<Review>> fetchAllReview() async {
  var url = Uri.parse('https://sayang-dibuang.up.railway.app/review/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Crowdfund
  List<Review> listReview = [];
  for (var d in data) {
    if (d != null) {
      listReview.add(Review.fromJson(d));
    }
  }

  return listReview;
}
