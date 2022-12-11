// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/information/lain-lain/create_review.dart';
import 'package:sayang_dibuang_mobile/information/pages/review_page.dart';
import 'package:sayang_dibuang_mobile/information/pages/teams.dart';

class AddreviewPage extends StatefulWidget {
  const AddreviewPage({super.key});

  @override
  State<AddreviewPage> createState() => _AddreviewPageState();
}

class _AddreviewPageState extends State<AddreviewPage> {
  final _formKey = GlobalKey<FormState>();

  String judul = '';
  String deskripsi = '';
  // String? username;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.watch<CurrentUserProfileModel>();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () =>
                    Provider.of<PageProvider>(context, listen: false)
                        .popInTab(),
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
                              padding: const EdgeInsets.all(10.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "Contoh: Saya Puas!",
                                  labelText: "Judul",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    judul = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    judul = value!;
                                  });
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Judul tidak boleh kosong!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText:
                                      "Contoh: Sayang Dibuang bagus banget!",
                                  labelText: "Deskripsi",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    deskripsi = value!;
                                  });
                                },
                                onSaved: (String? value) {
                                  setState(() {
                                    deskripsi = value!;
                                  });
                                },
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
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  createReview(request, profile.user?.username,
                                      judul, deskripsi);

                                  Provider.of<PageProvider>(context,
                                          listen: false)
                                      .pushInTab(const AddreviewPage(),
                                          const ReviewPage());
                                }

                                Provider.of<PageProvider>(context,
                                        listen: false)
                                    .popInTab();
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
