import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/functions/delete_request.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/functions/edit_request.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/functions/fetch_request.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/models/request.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/request_barang_bekas/pages/edit_request_form.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class RequestDetailPage extends StatefulWidget {
  final int pk;
  final String namaBarang;
  final String deskripsi;
  final String kategori;
  final bool available;

  final int owner;

  const RequestDetailPage({
    super.key,
    required this.pk,
    required this.namaBarang,
    required this.deskripsi,
    required this.kategori,
    required this.owner,
    required this.available,
  });

  @override
  State<RequestDetailPage> createState() => _RequestDetailPageState();
}

class _RequestDetailPageState extends State<RequestDetailPage> {
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
                    !widget.available
                      ? Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15.0),
                          // color: ThemeColor.darkGreen,
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(
                            5), //apply padding to all four sides
                        child: const Text("PENDING", style: TextStyle(color: Colors.white, fontSize: 25)),
                      )
                      : Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.0),
                          // color: ThemeColor.darkGreen,
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(
                            5), //apply padding to all four sides
                        child: const Text("FULFILLED", style: TextStyle(color: Colors.white, fontSize: 25)),
                      ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        widget.namaBarang,
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
                                      RequestDetailPage(
                                        pk: widget.pk,
                                        namaBarang: widget.namaBarang,
                                        deskripsi: widget.deskripsi,
                                        kategori: widget.kategori,
                                        available: widget.available,
                                        owner: widget.owner,
                                      ),
                                      EditRequest(
                                          pk: widget.pk,
                                          owner: widget.owner,
                                          namaBarang: widget.namaBarang,
                                          deskripsi: widget.deskripsi,
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
                                            deleteRequest(request, pk);
                                            Navigator.pop(context);
                                            Provider.of<PageProvider>(context,
                                                    listen: false)
                                                .pop();
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
                        RequestDetailPage(
                            pk: widget.pk,
                            namaBarang: widget.namaBarang,
                            deskripsi: widget.deskripsi,
                            kategori: widget.kategori,
                            owner: widget.owner,
                            available: widget.available),
                        const BerandaRequestPage()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
