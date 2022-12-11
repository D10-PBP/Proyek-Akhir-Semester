import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/add_barang_form.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/barang_detail.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

class BerandaBarangPage extends StatefulWidget {
  const BerandaBarangPage({super.key});

  @override
  State<BerandaBarangPage> createState() => _BerandaBarangPageState();
}

class _BerandaBarangPageState extends State<BerandaBarangPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 240,
                decoration: const BoxDecoration(
                  color: ThemeColor.darkGreen,
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "BERANDA BARANG",
                      style: TextStyle(
                          fontFamily: "Verona",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: ThemeColor.gold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "\"One man's trash is another man's treasure.\"",
                      style: TextStyle(
                          // fontFamily: "Verona",
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: ThemeColor.sand),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Live sustainably by reducing your waste. Don't throw away unused things. Post it here!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: ThemeColor.sand),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // if (profile.hasCurrentUser())
                    OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(ThemeColor.sand),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          side: MaterialStateProperty.all(const BorderSide(
                              color: ThemeColor.sand,
                              width: 2.0,
                              style: BorderStyle.solid))),
                      onPressed: Redirect.loginHandler(context,
                          currentWidget: const BerandaBarangPage(),
                          mainWidget: const BerandaBarangPage(),
                          destinationWidget: const CreateBarangBekas()),
                      // onPressed: () {
                      //   Provider.of<PageProvider>(context, listen: false)
                      //       .push(const BerandaBarangPage(),
                      //           const CreateBarangBekas());
                      // },
                      child: const Text(
                        "Upload",
                        style: TextStyle(
                          color: ThemeColor.darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchBarangBekas(request),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // return Text(snapshot.data.length.toString());
                    if (snapshot.data!.length > 0) {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5.0),
                          child: GestureDetector(
                            onTap: () => Provider.of<PageProvider>(context,
                                    listen: false)
                                .push(
                              const BerandaBarangPage(),
                              BarangDetailPage(
                                pk: snapshot.data![index].pk,
                                judul: snapshot.data![index].judul,
                                deskripsi: snapshot.data![index].deskripsi,
                                foto: snapshot.data![index].foto,
                                kategori: snapshot.data![index].kategori,
                                owner: snapshot.data![index].profile,
                              ),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(
                                  color: ThemeColor.darkGreen,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: const Color.fromARGB(
                                          255, 199, 188, 155),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Image.network(
                                        snapshot.data![index].foto),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 15.0),
                                      width: MediaQuery.of(context).size.width,
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data![index].judul,
                                            style: const TextStyle(
                                                fontFamily: "Verona",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              snapshot.data![index].deskripsi,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ThemeColor.gold),
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              // color: ThemeColor.darkGreen,
                                            ),
                                            margin: const EdgeInsets.only(
                                                left: 15.0),
                                            padding: const EdgeInsets.all(
                                                5), //apply padding to all four sides
                                            child: Text(
                                                snapshot.data![index].kategori),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.data!.length == 0) {
                      return const Center(
                        child: Text("Belum ada barang"),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
