import 'dart:html';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/information/pages/addreview_page.dart';

class ReviewdetailPage extends StatefulWidget {
  const ReviewdetailPage({super.key});

  @override
  State<ReviewdetailPage> createState() => _ReviewdetailPageState();
}

class _ReviewdetailPageState extends State<ReviewdetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: ThemeColor.white,
          body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 1000,
                child: Card(
                    color: ThemeColor.sand,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        side: BorderSide(color: ThemeColor.gold)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back,
                                    color: ThemeColor.gold),
                                onPressed: () => Provider.of<PageProvider>(
                                        context,
                                        listen: false)
                                    .pop(),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "icon-profile.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),

                                // BELOM KELARR
                                const Text(
                                  "Cie penasaran",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: ThemeColor.white,
                                  child: Padding(
                                      padding: const EdgeInsets.all(25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            "ini kaga jelas banget",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "sadlkdlshdhlashduahld",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )))),
                          const SizedBox(height: 10),

                          // BELOM KELARRR
                          const Text("DIBUAT PADA TANGGAL : "),
                          const SizedBox(height: 10),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(ThemeColor.gold),
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                              ),
                            ),

                            // delete nya blom
                            onPressed: () {
                              Provider.of<PageProvider>(context, listen: false)
                                  .push(const ReviewdetailPage(),
                                      const AddreviewPage());
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(
                                color: ThemeColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ]),
          )),
    );
  }
}
