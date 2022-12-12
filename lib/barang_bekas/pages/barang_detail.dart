import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/delete_barang.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/models/barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/edit_barang_form.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class BarangDetailPage extends StatefulWidget {
  final int pk;
  final String judul;
  final String deskripsi;
  final String foto;
  final String kategori;
  final String lokasi;
  final bool available;

  final int owner;

  const BarangDetailPage({
    super.key,
    required this.pk,
    required this.judul,
    required this.deskripsi,
    required this.foto,
    required this.kategori,
    required this.owner,
    required this.lokasi,
    required this.available,
  });

  @override
  State<BarangDetailPage> createState() => _BarangDetailPageState();
}

class _BarangDetailPageState extends State<BarangDetailPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColor.sand,
        body: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 35),
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 450,
                          width: (MediaQuery.of(context).size.width),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: ThemeColor.gold,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Image.network(widget.foto),
                        ),
                        !widget.available
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 450,
                                alignment: Alignment.center,
                                child: const Text(
                                  "NOT AVAILABLE",
                                  style: TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.w900,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 12.0,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        offset: Offset(2.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                      ],
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
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          color: Color.fromARGB(255, 186, 48, 48),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(widget.lokasi),
                      ],
                    ),
                    FutureBuilder<List<Owner>>(
                      future: fetchOwner(request, widget.owner),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: const EdgeInsets.all(10),
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
                                  profile.hasCurrentUser()
                                      ? "Contact Person"
                                      : "Login untuk data owner",
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
                                  profile.hasCurrentUser()
                                      ? "Telepon: ${snapshot.data![0].telephone}"
                                      : "08XXX",
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
                                  profile.hasCurrentUser()
                                      ? "Line: ${snapshot.data![0].line}"
                                      : "XXXXX",
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
                                  profile.hasCurrentUser()
                                      ? "Whatsapp: ${snapshot.data![0].whatsapp}"
                                      : "08XXX",
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
                    if (profile.user?.pk == widget.owner)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              // print(widget.kategori);
                              Provider.of<PageProvider>(context, listen: false)
                                  .pushInTab(
                                      BarangDetailPage(
                                        pk: widget.pk,
                                        judul: widget.judul,
                                        deskripsi: widget.deskripsi,
                                        foto: widget.foto,
                                        kategori: widget.kategori,
                                        lokasi: widget.lokasi,
                                        available: widget.available,
                                        owner: widget.owner,
                                      ),
                                      EditBarangBekas(
                                          pk: widget.pk,
                                          owner: widget.owner,
                                          judul: widget.judul,
                                          deskripsi: widget.deskripsi,
                                          foto: widget.foto,
                                          lokasi: widget.lokasi,
                                          kategori: widget.kategori,
                                          isAvailable: widget.available));
                            },
                            elevation: 2.0,
                            fillColor: ThemeColor.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.edit,
                              size: 35.0,
                              color: ThemeColor.gold,
                            ),
                          ),
                          RawMaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 15,
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        const Center(
                                            child: Text(
                                                'Apa anda yakin ingin menghapus?')),
                                        const SizedBox(height: 20),
                                        TextButton(
                                          onPressed: () {
                                            var pk = widget.pk;
                                            deleteBarang(request, pk);
                                            Navigator.pop(context);
                                            Provider.of<PageProvider>(context,
                                                    listen: false)
                                                .popInTab();
                                          },
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            elevation: 2.0,
                            fillColor: ThemeColor.white,
                            padding: const EdgeInsets.all(15.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.delete,
                              size: 35.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 35.0),
                onPressed: () =>
                    Provider.of<PageProvider>(context, listen: false).pushInTab(
                        BarangDetailPage(
                            pk: widget.pk,
                            judul: widget.judul,
                            deskripsi: widget.deskripsi,
                            foto: widget.foto,
                            kategori: widget.kategori,
                            owner: widget.owner,
                            lokasi: widget.lokasi,
                            available: widget.available),
                        const BerandaBarangPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
