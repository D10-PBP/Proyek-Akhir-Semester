import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class CrowdfundingsNoUserPage extends StatelessWidget {
  const CrowdfundingsNoUserPage({super.key});

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
              "Crowdfunding",
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
                    "Fitur ini dapat digunakan jika kamu sudah login.",
                    style: TextStyle(fontSize: 16),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  // Button
                  TextButton(
                    onPressed: () {},
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
