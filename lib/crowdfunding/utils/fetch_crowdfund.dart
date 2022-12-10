import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'dart:convert';

class CrowdfundAPIHandler {
  static Future<dynamic> fetchAllCrowdfunds(CookieRequest request) async {
    final response = await request
        .get('https://sayang-dibuang.up.railway.app/crowdfundings/json/');
    return response;
  }

  static Future<dynamic> editCrowdfund(
      CookieRequest request, int id, Map<String, dynamic> crowdfund) async {
    print(crowdfund);
    final response = await request.post(
        'https://sayang-dibuang.up.railway.app/crowdfundings/edit/mobile/${id}',
        crowdfund);
    return response;
  }
}
