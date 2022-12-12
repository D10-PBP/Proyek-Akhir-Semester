editRequest(
    request, pk, namaBarang, deskripsi, kategori, isAvailable) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/request/$pk/edit/ajax/', {
    "nama_barang": namaBarang,
    "deskripsi": deskripsi,
    "kategori": kategori,
    "available": isAvailable ? "True" : "False"
  });

  return response["message"];
}
