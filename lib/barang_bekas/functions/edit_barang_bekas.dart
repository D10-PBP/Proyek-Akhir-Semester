editBarang(
    request, pk, judul, deskripsi, foto, lokasi, kategori, isAvailable) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/barang/$pk/edit/ajax/', {
    "foto": foto,
    "judul": judul,
    "deskripsi": deskripsi,
    "lokasi": lokasi,
    "kategori": kategori,
    "available": isAvailable ? "True" : "False"
  });

  return response["message"];
}
