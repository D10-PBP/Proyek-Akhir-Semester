import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings_page.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:flutter_html/flutter_html.dart';

import '../pages/user_crowdfund_page.dart';

class UserCrowdfunds extends StatelessWidget {
  Future<dynamic> crowdfunds;

  UserCrowdfunds({Key? key, required this.crowdfunds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = context.read<CurrentUserProfileModel>();

    return Container(
      height: 210,
      child: FutureBuilder(
          future: crowdfunds,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                  child: CircularProgressIndicator(
                color: ThemeColor.gold,
              ));
            }
            if (!snapshot.hasData) {
              return Column(
                children: const [
                  Text(
                    "Tidak ada crowdfund :(",
                    style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                // physics: to remove bouncing effect on the edges after scrolling
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  if (snapshot.data[index]['user_id'] == profile.user!.pk) {
                    return GestureDetector(
                      onTap: () {
                        print('taptaptap');
                        Provider.of<PageProvider>(context, listen: false).push(
                            const CrowdfundingsPage(),
                            UserCrowdfundPage(
                              crowdfund: snapshot.data[index],
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            color: ThemeColor.white,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index]['title'],
                                    style: const TextStyle(
                                        fontFamily: "Verona", fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Html(
                                      data: snapshot.data[index]
                                          ['description']),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        child: Container(
                                            color: ThemeColor.darkGreen,
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0,
                                                  vertical: 8.0),
                                              child: Text("Lihat",
                                                  style: TextStyle(
                                                      color: ThemeColor.sand)),
                                            )),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              );
            }
          }),
    );
  }
}
