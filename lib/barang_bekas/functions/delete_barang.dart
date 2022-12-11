deleteBarang(request, id) async {
  var response = await request.post(
      'https://sayang-dibuang.up.railway.app/barang/$id/delete/mobile/', {});
  return response['message'];
}
