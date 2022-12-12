import 'package:pbp_django_auth/pbp_django_auth.dart';

class CrowdfundAPIHandler {
  static Future<dynamic> fetchAllCrowdfunds(CookieRequest request) async {
    final response = await request
        .get('https://sayang-dibuang.up.railway.app/crowdfundings/json/');
    return response;
  }

  static Future<dynamic> createCrowdfund(
      CookieRequest request, Map<String, dynamic> crowdfund) async {
    final response = await request.post(
        'https://sayang-dibuang.up.railway.app/crowdfundings/create/mobile',
        crowdfund);
    return response;
  }

  static Future<dynamic> editCrowdfund(
      CookieRequest request, int id, Map<String, dynamic> crowdfund) async {
    final response = await request.post(
        'https://sayang-dibuang.up.railway.app/crowdfundings/edit/mobile/$id',
        crowdfund);
    return response;
  }

  static Future<dynamic> deleteCrowdfund(CookieRequest request, int id) async {
    final response = await request.post(
        'https://sayang-dibuang.up.railway.app/crowdfundings/delete/$id',
        {'csrfmiddlewaretoken': request.cookies['csrftoken']});
    return response;
  }

  static Future<dynamic> addUserPointWhenContacting(
      CookieRequest request, int id) async {
    final response = await request.post(
        'https://sayang-dibuang.up.railway.app/crowdfundings/add-point-when-contacting/$id',
        {'csrfmiddlewaretoken': request.cookies['csrftoken']});
    return response;
  }
}
