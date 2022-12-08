import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/create_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

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
  // data: di bwh ini diambil dari user
  String? username;
  String? noTelp;
  String? line;
  String? wa;

  // ImagePicker picker = ImagePicker();
  // Future getImage() async {
  //   var selectedImg = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     image = File(selectedImg!.path);
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
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
                          // TODO:
                          createBarang(request, username, judul, deskripsi,
                              foto, lokasi, kategori);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BerandaBarangPage(),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Upload",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.chevron_left_rounded, size: 35.0),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
