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

createReview(request, username, judul, deskripsi) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/review/create/mobile', {
    "username": username,
    "judul": judul,
    "deskripsi": deskripsi,
  });

  return response["message"];
}

// class SearchService {
//   static Future<String> searchDjangoApi(String query) async {
//     String url = 'https://sayang-dibuang.up.railway.app/review/all/';

//     http.Response response = await http.get(Uri.encodeFull(url));

//     return response.body
//   }
// }
