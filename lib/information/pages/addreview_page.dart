import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/information/pages/teams.dart';

class AddreviewPage extends StatefulWidget {
  const AddreviewPage({super.key});

  @override
  State<AddreviewPage> createState() => _AddreviewPageState();
}

class _AddreviewPageState extends State<AddreviewPage> {
  final _formKey = GlobalKey<FormState>();

  String? judul;
  String? deskripsi;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () =>
                    Provider.of<PageProvider>(context, listen: false).pop(),
              ),
              backgroundColor: ThemeColor.darkGreen,
              shadowColor: Colors.transparent),
          backgroundColor: ThemeColor.white,
          body: Center(
            child: Stack(children: [
              const SizedBox(height: 20),
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
                              "UPLOAD REVIEW",
                              style: TextStyle(
                                  fontFamily: "Verona",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: ThemeColor.gold),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              // Menggunakan padding sebesar 8 pixels
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Contoh: Saya Puas!",
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
                                      "Contoh: Sayang Dibuang bagus banget!",
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
                            const SizedBox(height: 30),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    ThemeColor.darkGreen),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 16),
                                ),
                              ),
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   createBarang(request, profile.user?.username,
                                //       judul, deskripsi, foto, lokasi, kategori);

                                //   Provider.of<PageProvider>(context,
                                //           listen: false)
                                //       .push(const CreateBarangBekas(),
                                //           const BerandaBarangPage());
                                // }
                                Provider.of<PageProvider>(context,
                                        listen: false)
                                    .pop();
                              },
                              child: const Text(
                                "Upload",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ))),
              )
            ]),
          )),
    );
  }
}
