import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/create_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/add_kategori.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/add_lokasi.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class CreateBarangBekas extends StatefulWidget {
  const CreateBarangBekas({super.key});

  @override
  State<CreateBarangBekas> createState() => _CreateBarangBekas();
}

class _CreateBarangBekas extends State<CreateBarangBekas> {
  final _formKey = GlobalKey<FormState>();

  String? judul;
  String? deskripsi;
  String? foto;
  File? image;
  String? lokasi;
  String? kategori;
  String? username;

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
                        "UPLOAD BARANG BEKAS",
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
                                  lokasi = data[0];
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
                                  kategori = data[0];
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
                            print("$kategori $lokasi");
                            createBarang(request, profile.user?.username, judul,
                                deskripsi, foto, lokasi, kategori);

                            Provider.of<PageProvider>(context, listen: false)
                                .pushInTab(const CreateBarangBekas(),
                                    const BerandaBarangPage());
                          }
                        },
                        child: const Text(
                          "Upload",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(ThemeColor.sand),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                        style: BorderStyle.solid))),
                            onPressed: () {
                              Provider.of<PageProvider>(context, listen: false)
                                  .pushInTab(const CreateBarangBekas(),
                                      const CreateKategori());
                            },
                            child: const Text(
                              "Tambah Kategori",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 37, 33, 23)),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(ThemeColor.sand),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                side: MaterialStateProperty.all(
                                    const BorderSide(
                                        color: Colors.black,
                                        width: 1.0,
                                        style: BorderStyle.solid))),
                            onPressed: () {
                              Provider.of<PageProvider>(context, listen: false)
                                  .pushInTab(const CreateBarangBekas(),
                                      const CreateLokasi());
                            },
                            child: const Text(
                              "Tambah Lokasi",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 37, 33, 23)),
                            ),
                          ),
                        ],
                      )
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
