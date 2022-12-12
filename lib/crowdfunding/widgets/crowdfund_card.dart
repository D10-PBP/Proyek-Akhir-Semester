import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfund_page.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings_page.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class CrowdfundCard extends StatelessWidget {
  dynamic crowdfund;
  dynamic updateCrowdfunds;
  CrowdfundCard(
      {Key? key,
      required this.request,
      required this.crowdfund,
      required this.updateCrowdfunds})
      : super(key: key);

  final CookieRequest request;

  @override
  Widget build(BuildContext context) {
    final profile = context.read<CurrentUserProfileModel>();
    String description = Bidi.stripHtmlIfNeeded(crowdfund['description']);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: ThemeColor.white,
          width: 250,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      crowdfund['title'],
                      style: const TextStyle(
                          fontFamily: "Verona",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    backgroundColor: ThemeColor.sand,
                    color: ThemeColor.darkGreen,
                    value: crowdfund['received'] / crowdfund['target'],
                    minHeight: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Provider.of<PageProvider>(context, listen: false)
                              .pushInTab(
                                  const CrowdfundingsPage(),
                                  CrowdfundPage(
                                    crowdfund: crowdfund,
                                  ));
                        },
                        icon: const FaIcon(FontAwesomeIcons.eye),
                        color: ThemeColor.darkGreen,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (profile.user!.pk == crowdfund['user_id'])
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0)),
                                ),
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 200,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius
                                                        .only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0)),
                                                child: Container(
                                                  color: ThemeColor.sand,
                                                  child: const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Text(
                                                        "Menghapus Crowdfund",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Verona',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16.0),
                                        Center(
                                          child: Column(
                                            children: [
                                              const Text(
                                                  "Apakah kamu yakin ingin menghapus crowdfund ini?"),
                                              const SizedBox(height: 8.0),
                                              GestureDetector(
                                                onTap: () {
                                                  // hit delete endpoint
                                                  int crowdfundId =
                                                      crowdfund['id'];

                                                  CrowdfundAPIHandler
                                                      .deleteCrowdfund(
                                                          request, crowdfundId);

                                                  // close the modal
                                                  Navigator.of(context).pop();
                                                  updateCrowdfunds(request);
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  child: Container(
                                                      color: Colors.red,
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.0,
                                                                vertical: 8.0),
                                                        child: Text("Hapus",
                                                            style: TextStyle(
                                                                color:
                                                                    ThemeColor
                                                                        .sand)),
                                                      )),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: const FaIcon(FontAwesomeIcons.trashCan),
                          color: Colors.red,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
