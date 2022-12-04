import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/barang_detail.dart';
import 'package:sayang_dibuang_mobile/core/widget/drawer.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class BerandaBarangPage extends StatefulWidget {
  const BerandaBarangPage({super.key});

  @override
  State<BerandaBarangPage> createState() => _BerandaBarangPageState();
}

class _BerandaBarangPageState extends State<BerandaBarangPage> {
  // masi error
  var cardImage =
      const NetworkImage('https://source.unsplash.com/random/800x600?house');
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColor.sand,
        drawer: DrawerClass('Beranda', 1),
        body: Stack(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: Container(
                          decoration: BoxDecoration(
                            color: ThemeColor.darkGreen,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text(
                              "Beranda Barang",
                              style: TextStyle(
                                  color: ThemeColor.sand,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BarangDetailPage(
                                  judul: "Judul",
                                  deskripsi:
                                      "Text largeeeeeeeeeeeeeeeeeeeeeee. Nah lo gmn. Halo nama saya ini. Ini BArang yang saya mw kasih. Kalau kalian butuh barang ini. Lgsg chat sjh thx.",
                                  kategori: "Kategori",
                                  owner: "Owner nama",
                                  noTelp: "087788776655",
                                  line: "owner.line",
                                  wa: "0899887766"))),
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
                                color: ThemeColor.gold,
                              ),
                              padding: new EdgeInsets.all(10.0),
                              child: Text("Image HERE"),
                            ),
                            Flexible(
                              child: Container(
                                padding:
                                    new EdgeInsets.only(top: 25.0, left: 15.0),
                                height: 200,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Judul",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(12.0),
                                      child: Text(
                                        'Text largeeeeeeeeeeeeeeeeeeeeeee. Nah lo gmn. Halo nama saya ini. Ini BArang yang saya mw kasih. Kalau kalian butuh barang ini. Lgsg chat sjh thx.',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
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
                                      child: Text("Kategori"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: new Icon(
                  Icons.menu,
                  size: 35.0,
                  color: ThemeColor.sand,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
