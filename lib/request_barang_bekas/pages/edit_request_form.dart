import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/functions/edit_request.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/pages/request_detail.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class EditRequest extends StatefulWidget {
  const EditRequest(
      {super.key,
      required this.pk,
      required this.owner,
      required this.namaBarang,
      required this.deskripsi,
      required this.kategori,
      required this.isAvailable});

  final int pk;
  final int owner;
  final String namaBarang;
  final String deskripsi;
  final String kategori;
  final bool isAvailable;

  @override
  State<EditRequest> createState() => _EditRequest();
}

class _EditRequest extends State<EditRequest> {
  final _formKey = GlobalKey<FormState>();

  int? pk;
  String? namaBarang;
  String? deskripsi;
  String? kategori;
  bool? isAvailable;
  @override
  void initState() {
    super.initState();
    pk = widget.pk;
    namaBarang = widget.namaBarang;
    deskripsi = widget.deskripsi;
    kategori = widget.kategori;
    isAvailable = widget.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                        "EDIT REQUEST",
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
                          initialValue: namaBarang,
                          decoration: InputDecoration(
                            hintText: "Contoh: Botol Plastik 2 Liter",
                            labelText: "Nama Barang",
                            // Menambahkan circular border agar lebih rapi
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          // Menambahkan behavior saat nama diketik
                          onChanged: (String? value) {
                            setState(() {
                              namaBarang = value!;
                            });
                          },
                          // Menambahkan behavior saat data disimpan
                          onSaved: (String? value) {
                            setState(() {
                              namaBarang = value!;
                            });
                          },
                          // Validator sebagai validasi form
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama barang tidak boleh kosong!';
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
                            hintText: "Contoh: Botol untuk eksperimen roket.",
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
                      CheckboxListTile(
                        title: const Text('Fulfilled'),
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
                            editRequest(request, pk, namaBarang, deskripsi,
                                kategori, isAvailable);

                            // Provider.of<PageProvider>(context, listen: false)
                            //     .popInTab();
                            Provider.of<PageProvider>(context, listen: false)
                                .push(
                                    EditRequest(
                                      pk: widget.pk,
                                      namaBarang: widget.namaBarang,
                                      deskripsi: widget.deskripsi,
                                      kategori: widget.kategori,
                                      isAvailable: widget.isAvailable,
                                      owner: widget.owner,
                                    ),
                                    RequestDetailPage(
                                      pk: widget.pk,
                                      namaBarang: namaBarang!,
                                      deskripsi: deskripsi!,
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
