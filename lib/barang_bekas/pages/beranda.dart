import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/functions/fetch_barang_bekas.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/add_barang_form.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/barang_detail.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings.dart';

class BerandaBarangPage extends StatefulWidget {
  const BerandaBarangPage({super.key});

  @override
  State<BerandaBarangPage> createState() => _BerandaBarangPageState();
}

class _BerandaBarangPageState extends State<BerandaBarangPage> {
  // masi error
  // var cardImage =
  // const NetworkImage('https://source.unsplash.com/random/800x600?house');

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    // TODO: implement build
    return FutureBuilder(
      future: fetchBarangBekas(request),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // return Text(snapshot.data.length.toString());
          if (snapshot.data!.length > 0) {
            return Stack(
              children: [
                ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 5.0),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BarangDetailPage(
                            judul: snapshot.data![index].judul,
                            deskripsi: snapshot.data![index].deskripsi,
                            foto: snapshot.data![index].foto,
                            kategori: snapshot.data![index].kategori,
                            // owner: snapshot.data![index].profile
                            //     .toString(), // ini baru pk gitu
                            owner: "Test",
                            noTelp: "099",
                            line: "pooh",
                            wa: "0899",
                          ),
                        ),
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(
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
                                color: Color.fromARGB(255, 199, 188, 155),
                              ),
                              padding: new EdgeInsets.only(left: 10, right: 10),
                              child: Image.network(snapshot.data![index].foto),
                            ),
                            Flexible(
                              child: Container(
                                padding:
                                    new EdgeInsets.only(top: 25.0, left: 15.0),
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: Column(
                                  children: [
                                    Text(
                                      snapshot.data![index].judul,
                                      style: TextStyle(
                                          fontFamily: "Verona",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        snapshot.data![index].deskripsi,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: ThemeColor.gold),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        // color: ThemeColor.darkGreen,
                                      ),
                                      margin: EdgeInsets.only(left: 15.0),
                                      padding: EdgeInsets.all(
                                          5), //apply padding to all four sides
                                      child:
                                          Text(snapshot.data![index].kategori),
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
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateBarangBekas()),
                      );
                    },
                    elevation: 2.0,
                    fillColor: ThemeColor.gold,
                    child: Icon(
                      Icons.add,
                      size: 35.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            );
          } else if (snapshot.data!.length == 0) {
            return Center(
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
    );
  }
}
