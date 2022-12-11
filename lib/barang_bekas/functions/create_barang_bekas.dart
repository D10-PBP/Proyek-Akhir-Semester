createBarang(
    request, username, judul, deskripsi, foto, lokasi, kategori) async {
  var response = await request
      .post('https://sayang-dibuang.up.railway.app/barang/upload/ajax/', {
    "username": username,
    "foto": foto,
    "judul": judul,
    "deskripsi": deskripsi,
    "lokasi": lokasi,
    "kategori": kategori
  });

  return response["message"];
}

createKategori(request, jenis) async {
  var response = await request.post(
      'https://sayang-dibuang.up.railway.app/barang/add/kategori/m/',
      {"jenis": jenis});
  return response['status'];
}

createLokasi(request, nama) async {
  var response = await request.post(
      'https://sayang-dibuang.up.railway.app/barang/add/lokasi/m/',
      {"nama": nama});
  return response['status'];
}
