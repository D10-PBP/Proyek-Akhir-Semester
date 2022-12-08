import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/fetch_crowdfund.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/user_crowdfunds.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/widgets/all_crowdfunds.dart';

class CrowdfundingsPage extends StatelessWidget {
  CrowdfundingsPage({super.key});
  Future<List<Crowdfund>> crowdfunds = fetchAllCrowdfunds();

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Kampanyeku",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
