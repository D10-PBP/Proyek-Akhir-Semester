import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/create_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/edit_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/barang_detail.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class EditBarangBekas extends StatefulWidget {
  const EditBarangBekas(
      {super.key,
      required this.pk,
      required this.owner,
      required this.judul,
      required this.deskripsi,
      required this.foto,
      required this.kategori,
      required this.lokasi,
      required this.isAvailable});

  final int pk;
  final int owner;
  final String judul;
  final String deskripsi;
  final String foto;
  final String kategori;
  final String lokasi;
  final bool isAvailable;

  @override
  State<EditBarangBekas> createState() => _EditBarangBekas();
}

class _EditBarangBekas extends State<EditBarangBekas> {
  final _formKey = GlobalKey<FormState>();

  int? pk;
  String? judul;
  String? deskripsi;
  String? foto;
  String? lokasi;
  String? kategori;
  bool? isAvailable;
  @override
  void initState() {
    super.initState();
    pk = widget.pk;
    judul = widget.judul;
    deskripsi = widget.deskripsi;
    foto = widget.foto;
    lokasi = widget.lokasi;
    kategori = widget.kategori;
    isAvailable = widget.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        "EDIT BARANG BEKAS",
                        style: TextStyle(
                            fontFamily: "Verona",
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: ThemeColor.gold),
                      ),
                      Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          initialValue: judul,
                          decoration: InputDecoration(
                            hintText: "Contoh: Karton Aqua",
                            labelText: "Judul",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              judul = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              judul = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Judul tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: deskripsi,
                          decoration: InputDecoration(
                            hintText:
                                "Contoh: Karton sebanyak 2 lusin. Kondisi pristine.",
                            labelText: "Deskripsi",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              deskripsi = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              deskripsi = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Deskripsi tidak boleh kosong!';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        // Menggunakan padding sebesar 8 pixels
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          initialValue: foto,
                          decoration: InputDecoration(
                            hintText: "Contoh: www.blabla.jpg",
                            labelText: "Image URL",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              foto = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              foto = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Image URL tidak boleh kosong!';
                            } else if (!value.startsWith("http")) {
                              return 'Image URL harus sebuah link dengan http/https';
                            }
                            return null;
                          },
                        ),
                      ),
                      CheckboxListTile(
                        title: const Text('Available'),
                        value: isAvailable,
                        onChanged: (bool? value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FutureBuilder<List<String>>(
                              future: fetchLokasi(request),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!;
                                  return DropdownButton(
                                    // Initial Value
                                    value: lokasi ?? data[0],

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: data.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        lokasi = newValue!;
                                      });
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            FutureBuilder<List<String>>(
                              future: fetchKategori(request),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var data = snapshot.data!;
                                  return DropdownButton(
                                    // Initial Value
                                    value: kategori ?? data[0],

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items: data.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        kategori = newValue!;
                                      });
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColor.darkGreen),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            editBarang(request, pk, judul, deskripsi, foto,
                                lokasi, kategori, isAvailable);

                            // Provider.of<PageProvider>(context, listen: false)
                            //     .popInTab();
                            Provider.of<PageProvider>(context, listen: false)
                                .push(
                                    EditBarangBekas(
                                      pk: widget.pk,
                                      judul: widget.judul,
                                      deskripsi: widget.deskripsi,
                                      foto: widget.foto,
                                      lokasi: widget.lokasi,
                                      kategori: widget.kategori,
                                      isAvailable: widget.isAvailable,
                                      owner: widget.owner,
                                    ),
                                    BarangDetailPage(
                                      pk: widget.pk,
                                      judul: judul!,
                                      deskripsi: deskripsi!,
                                      foto: foto!,
                                      lokasi: lokasi!,
                                      kategori: kategori!,
                                      available: isAvailable!,
                                      owner: widget.owner,
                                    ));
                          }
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 35.0),
                onPressed: () =>
                    Provider.of<PageProvider>(context, listen: false)
                        .popInTab(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
