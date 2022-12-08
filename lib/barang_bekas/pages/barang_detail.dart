import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';

class BarangDetailPage extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final String foto;
  final String kategori;
  final int owner;
  // final String noTelp;
  // final String line;
  // final String wa;
  const BarangDetailPage({
    super.key,
    required this.judul,
    required this.deskripsi,
    required this.foto,
    required this.kategori,
    required this.owner,
    // required this.noTelp,
    // required this.line,
    // required this.wa
  });

  @override
  State<BarangDetailPage> createState() => _BarangDetailPageState();
}

class _BarangDetailPageState extends State<BarangDetailPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: ThemeColor.sand,
      body: Stack(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.chevron_left_rounded, size: 35.0),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      // height sesuai gbr
                      height: 450,
                      width: (MediaQuery.of(context).size.width),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: ThemeColor.gold,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Image.network(widget.foto),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        widget.judul,
                        style: const TextStyle(
                            fontFamily: "Verona",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        widget.deskripsi,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: ThemeColor.gold),
                        borderRadius: BorderRadius.circular(15.0),
                        // color: ThemeColor.darkGreen,
                      ),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(
                          5), //apply padding to all four sides
                      child: Text(widget.kategori),
                    ),
                    FutureBuilder<List<Profile>>(
                      future: fetchOwner(request, widget.owner),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data!;
                          return Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: const EdgeInsets.all(10),
                            // padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(color: ThemeColor.darkGreen),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: ThemeColor.darkGreen,
                                ),
                                child: Text(
                                  widget.owner.toString(),
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: ThemeColor.sand,
                                    // backgroundColor: ThemeColor.darkGreen
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                color: ThemeColor.sand,
                                child: Text(
                                  "Telepon: ${snapshot.data![0].telephone}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: ThemeColor.darkGreen,
                                    // backgroundColor: ThemeColor.darkGreen
                                  ),
                                ),
                              ),
                              const Divider(),
                              Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                color: ThemeColor.sand,
                                child: Text(
                                  "Line: ${snapshot.data![0].line}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: ThemeColor.darkGreen,
                                    // backgroundColor: ThemeColor.darkGreen
                                  ),
                                ),
                              ),
                              const Divider(),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15)),
                                  color: ThemeColor.sand,
                                ),
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                child: Text(
                                  "Whatsapp: ${snapshot.data![0].whatsapp}",
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: ThemeColor.darkGreen,
                                    // backgroundColor: ThemeColor.darkGreen
                                  ),
                                ),
                              ),
                            ]),
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
            ),
          ),
        ],
      ),
    );
  }
}
