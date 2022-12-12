import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/crowdfund_card.dart';

class AllCrowdfunds extends StatelessWidget {
  Future<dynamic> crowdfunds;
  dynamic updateCrowdfunds;
  AllCrowdfunds(
      {Key? key, required this.crowdfunds, required this.updateCrowdfunds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Expanded(
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
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return CrowdfundCard(
                    updateCrowdfunds: updateCrowdfunds,
                    request: request,
                    crowdfund: snapshot.data[index],
                  );
                },
              );
            }
          }),
    );
  }
}
