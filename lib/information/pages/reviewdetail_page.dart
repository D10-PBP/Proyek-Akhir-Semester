// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
// import 'package:sayang_dibuang_mobile/information/lain-lain/deletereview.dart';

class ReviewdetailPage extends StatefulWidget {
  final String username;
  final String judul;
  final String deskripsi;
  final DateTime created;
  final int pk;

  const ReviewdetailPage({
    super.key,
    required this.username,
    required this.judul,
    required this.deskripsi,
    required this.created,
    required this.pk,
  });
  @override
  State<ReviewdetailPage> createState() => _ReviewdetailPageState();
}

class _ReviewdetailPageState extends State<ReviewdetailPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();

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
                                    .popInTab(),
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/icon-profile.png",
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  widget.username,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
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
                                        children: [
                                          Text(
                                            widget.judul,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            widget.deskripsi,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )))),
                          const SizedBox(height: 10),
                          // if (profile.user?.pk == widget.username)
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     RawMaterialButton(
                          //       onPressed: () {
                          //         showDialog(
                          //           context: context,
                          //           builder: (_) {
                          //             return Dialog(
                          //               shape: RoundedRectangleBorder(
                          //                 borderRadius:
                          //                     BorderRadius.circular(10),
                          //               ),
                          //               elevation: 15,
                          //               child: ListView(
                          //                 padding: const EdgeInsets.only(
                          //                     top: 20, bottom: 20),
                          //                 shrinkWrap: true,
                          //                 children: <Widget>[
                          //                   const Center(
                          //                       child: Text(
                          //                           'Apa anda yakin ingin menghapus?')),
                          //                   const SizedBox(height: 20),
                          //                   TextButton(
                          //                     onPressed: () {
                          //                       var pk = widget.pk;
                          //                       deleteReview(request, pk);
                          //                       Navigator.popInTab(context);
                          //                       Provider.of<PageProvider>(
                          //                               context,
                          //                               listen: false)
                          //                           .popInTabp();
                          //                     },
                          //                     child: const Text('Hapus'),
                          //                   ),
                          //                 ],
                          //               ),
                          //             );
                          //           },
                          //         );
                          //       },
                          //       elevation: 2.0,
                          //       fillColor: ThemeColor.white,
                          //       padding: const EdgeInsets.all(15.0),
                          //       shape: const CircleBorder(),
                          //       child: const Icon(
                          //         Icons.delete,
                          //         size: 35.0,
                          //         color: Colors.red,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // OutlinedButton(
                          //   style: ButtonStyle(
                          //     backgroundColor:
                          //         MaterialStateProperty.all(ThemeColor.gold),
                          //     padding: MaterialStateProperty.all<EdgeInsets>(
                          //       const EdgeInsets.symmetric(
                          //           horizontal: 20, vertical: 15),
                          //     ),
                          //   ),

                          //   // delete nya blom
                          //   onPressed: () {
                          //     Provider.of<PageProvider>(context,
                          //             listen: false)
                          //         .pushInTab(const TeamPage(),
                          //             const AddreviewPage());
                          //   },
                          //   child: const Text(
                          //     "Delete",
                          //     style: TextStyle(
                          //       color: ThemeColor.white,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    )),
              )
            ]),
          )),
    );
  }
}
