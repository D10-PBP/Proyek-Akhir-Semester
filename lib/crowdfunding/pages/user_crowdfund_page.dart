import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/edit_crowdfund_page.dart';

class UserCrowdfundPage extends StatefulWidget {
  dynamic crowdfund;
  UserCrowdfundPage({super.key, required this.crowdfund});

  @override
  State<UserCrowdfundPage> createState() => _UserCrowdfundPageState();
}

class _UserCrowdfundPageState extends State<UserCrowdfundPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Back Button
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButton(
              onPressed: () {
                Provider.of<PageProvider>(context, listen: false).popInTab();
              },
            ),
            SizedBox(
              width: 4,
            ),
            Text("Crowdfunding",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),

        SizedBox(
          height: 16,
        ),

        // Contents
        Expanded(
          child: Column(
            children: [
              // Title
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        widget.crowdfund['title'],
                        style: const TextStyle(
                            fontFamily: 'Verona',
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // Details
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)),
                  child: Container(
                    width: double.infinity,
                    color: ThemeColor.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Progress
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Progress",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                    "${widget.crowdfund['received']} dari ${widget.crowdfund['target']} benda diperoleh."),

                                const SizedBox(
                                  height: 16,
                                ),
                                // Description
                                const Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Html(
                                    data: "${widget.crowdfund['description']}"),
                              ],
                            ),
                          ),

                          // Button to Contact

                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditCrowdfundPage(
                                                    crowdfund:
                                                        widget.crowdfund)));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ThemeColor.gold),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Edit",
                                      style: TextStyle(
                                        color: ThemeColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
