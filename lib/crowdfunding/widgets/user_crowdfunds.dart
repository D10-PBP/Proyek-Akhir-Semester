import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/crowdfund_card.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class UserCrowdfunds extends StatefulWidget {
  late Future<dynamic> crowdfunds;
  dynamic updateCrowdfunds;
  UserCrowdfunds(
      {Key? key, required this.crowdfunds, required this.updateCrowdfunds})
      : super(key: key);

  @override
  State<UserCrowdfunds> createState() => _UserCrowdfundsState();
}

class _UserCrowdfundsState extends State<UserCrowdfunds> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();

    return Container(
      height: 250,
      child: FutureBuilder(
          future: widget.crowdfunds,
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
                    return CrowdfundCard(
                        request: request,
                        crowdfund: snapshot.data[index],
                        updateCrowdfunds: widget.updateCrowdfunds);
                  }
                  return const SizedBox();
                },
              );
            }
          }),
    );
  }
}
