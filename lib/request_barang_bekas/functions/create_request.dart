createRequest(
    request, username, namaBarang, deskripsi, kategori) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/request/upload/ajax/', {
    "username": username,
    "nama_barang": namaBarang,
    "deskripsi": deskripsi,
    "kategori": kategori
  });

  return response["message"];
}