import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/information/pages/addreview_page.dart';
import 'package:sayang_dibuang_mobile/information/pages/reviewdetail_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  Widget build(BuildContext context) {
    final profile = context.read<CurrentUserProfileModel>();

    return SafeArea(
        child: Scaffold(
            backgroundColor: ThemeColor.sand,
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () =>
                      Provider.of<PageProvider>(context, listen: false).pop(),
                ),
                backgroundColor: ThemeColor.darkGreen,
                shadowColor: Colors.transparent),
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: ThemeColor.darkGreen,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Review",
                        style: TextStyle(
                            fontFamily: "Verona",
                            color: ThemeColor.white,
                            fontSize: 35),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Image.asset(
                              "information/nature.png",
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Expanded(
                              child: Text(
                                '"There is no such thing as "away". When we throw anything away it must go somewhere."- Annie Leonard, Proponent of Sustainability',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: ThemeColor.white),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      if (profile.hasCurrentUser())
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
                          onPressed: () {
                            Provider.of<PageProvider>(context, listen: false)
                                .push(
                                    const ReviewPage(), const AddreviewPage());
                          },
                          child: const Text(
                            "Add Review",
                            style: TextStyle(
                              color: ThemeColor.darkGreen,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Nyoba dulu ya boy
                ListView(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 5.0),
                          child: GestureDetector(
                            onTap: () => Provider.of<PageProvider>(context,
                                    listen: false)
                                .push(const ReviewPage(),
                                    const ReviewdetailPage()),
                            child: Card(
                              color: ThemeColor.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  side: BorderSide(color: ThemeColor.gold)),
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          "icon-profile.png",
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),

                                        // BELOM KELARR
                                        const Text("HALOOOO"),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        color: ThemeColor.gold,
                                      ),
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),

                                      // BELOM KELAR JUGAA
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          children: const [
                                            Text(
                                              "mau turu bos",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "hidupku cuma turu turu turu",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),

                                    // BELOM KELARR
                                    const Text("Dibuat pada tanggal : ")
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ]),
              ]),
            )));
  }
}
