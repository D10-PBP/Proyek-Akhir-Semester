import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

class LeaderboardNoUserPage extends StatelessWidget {
  const LeaderboardNoUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16.0),
            child: Text(
              "Leaderboard",
              style: TextStyle(
                  fontFamily: "Verona",
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
          ),

          // Illustrations
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Image
                  Image.asset('assets/crowdfunding/login_asset.png'),

                  // Text
                  const Text(
                    "Login untuk melihat peringkat kamu",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // Button
                  TextButton(
                    onPressed: () {
                      Redirect.pushToLogin(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.darkGreen),
                    ),
                    child: const Text(
                      "Yuk, login!",
                      style: TextStyle(
                          color: ThemeColor.white, fontFamily: 'Verona'),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
