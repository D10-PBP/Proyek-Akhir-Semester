import 'package:sayang_dibuang_mobile/request_barang_bekas/models/request.dart';

Future<List<Request>> fetchRequest(request) async {
  var url = 'https://sayang-dibuang.up.railway.app/request/all/mobile/';
  var response = await request.get(
    url,
  );
  var data = response;

  List<Request> listRequest = [];
  for (var d in data) {
    if (d != null) {
      listRequest.add(Request.fromJson(d));
    }
  }
  return listRequest;
}

Future<List<Owner>> fetchOwner(request, id) async {
  var url = "https://sayang-dibuang.up.railway.app/request/owner/$id/";
  var response = await request.get(
    url,
  );
  var data = response;
  List<Owner> owner = [];
  for (var d in data) {
    if (d != null) {
      Owner profile = Owner.fromJson(d);
      owner.add(profile);
    }
  }
  return owner;
}
