import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayang_dibuang_mobile/core/widget/drawer.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class BarangDetailPage extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final String kategori;
  final String owner;
  final String noTelp;
  final String line;
  final String wa;

  const BarangDetailPage(
      {super.key,
      required this.judul,
      required this.deskripsi,
      required this.kategori,
      required this.owner,
      required this.noTelp,
      required this.line,
      required this.wa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.sand,
      body: Stack(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.chevron_left_rounded, size: 35.0),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            margin: new EdgeInsets.only(top: 35),
            padding: new EdgeInsets.all(10.0),
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
                      padding: new EdgeInsets.all(10.0),
                      child: Text("Image HERE"),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(
                        judul,
                        style: TextStyle(
                            fontFamily: "Verona",
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 12.0),
                      child: Text(
                        deskripsi,
                        style: TextStyle(
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
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.all(5), //apply padding to all four sides
                      child: Text(kategori),
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(10),
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: ThemeColor.darkGreen),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(children: [
                        Container(
                          padding: new EdgeInsets.all(15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ThemeColor.darkGreen,
                          ),
                          child: Text(
                            owner,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: ThemeColor.sand,
                              // backgroundColor: ThemeColor.darkGreen
                            ),
                          ),
                        ),
                        Container(
                          padding: new EdgeInsets.all(10),
                          alignment: Alignment.center,
                          color: ThemeColor.sand,
                          child: Text(
                            "Telepon: " + noTelp,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: ThemeColor.darkGreen,
                              // backgroundColor: ThemeColor.darkGreen
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: new EdgeInsets.all(10),
                          alignment: Alignment.center,
                          color: ThemeColor.sand,
                          child: Text(
                            "Line: " + line,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: ThemeColor.darkGreen,
                              // backgroundColor: ThemeColor.darkGreen
                            ),
                          ),
                        ),
                        Divider(),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                            color: ThemeColor.sand,
                          ),
                          padding: new EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text(
                            "Whatsapp: " + wa,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: ThemeColor.darkGreen,
                              // backgroundColor: ThemeColor.darkGreen
                            ),
                          ),
                        ),
                      ]),
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
