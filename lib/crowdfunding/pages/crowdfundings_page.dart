import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/create_crowdfund_page.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/user_crowdfunds.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/all_crowdfunds.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class CrowdfundingsPage extends StatefulWidget {
  const CrowdfundingsPage({super.key});

  @override
  State<CrowdfundingsPage> createState() => _CrowdfundingsPageState();
}

class _CrowdfundingsPageState extends State<CrowdfundingsPage> {
  late Future<dynamic> crowdfunds;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    crowdfunds = CrowdfundAPIHandler.fetchAllCrowdfunds(request);

    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                "Crowdfunding",
                style: TextStyle(
                    fontFamily: "Verona",
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ),

            const SizedBox(
              height: 32,
            ),

            // User Crowdfunds
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Kampanyeku",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<PageProvider>(context, listen: false)
                          .push(widget, CreateCrowdfundPage());
                    },
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                            color: ThemeColor.gold,
                            child: const Icon(
                              Icons.add,
                              color: ThemeColor.white,
                              size: 30,
                            ))),
                  ),
                ],
              ),
            ),

            UserCrowdfunds(
              crowdfunds: crowdfunds,
            ),

            // All Crowdfunds
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Semua Crowdfund",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            AllCrowdfunds(
              crowdfunds: crowdfunds,
            ),
          ],
        ),
      ),
    );
  }
}
