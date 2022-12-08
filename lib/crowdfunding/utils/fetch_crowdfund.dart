import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';

Future<List<Crowdfund>> fetchAllCrowdfunds() async {
  var url =
      Uri.parse('https://sayang-dibuang.up.railway.app/crowdfundings/json/');
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
  List<Crowdfund> listCrowdfund = [];
  for (var d in data) {
    if (d != null) {
      listCrowdfund.add(Crowdfund.fromJson(d));
    }
  }

  return listCrowdfund;
}
