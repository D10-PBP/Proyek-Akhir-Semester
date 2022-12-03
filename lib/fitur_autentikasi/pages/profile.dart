import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/login.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: (context.watch<CurrentUserProfileModel>().hasCurrentUser())
            ? ProfilePageUser()
            : ProfileLogin(),
      ),
    );
  }
}

class ProfilePageUser extends StatelessWidget {
  const ProfilePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(50.0),
            width: (currentWidth > 500) ? 500 : double.infinity,
            height: currentHeight * 7 / 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: ThemeColor.white),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Profil",
                    style: TextStyle(
                        fontFamily: "Verona",
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColor.gold),
                      ),
                      onPressed: () async {
                        await logout(context, request);
                      },
                      child: const SizedBox(
                          height: 40,
                          width: 200,
                          child: Center(
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "PlusJakarta",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ))),
                ],
              ),
            ),
          ),
          const Positioned(
            top: -15,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: ThemeColor.darkGreen,
              child: Icon(
                Icons.account_circle_rounded,
                size: 80,
                color: ThemeColor.white,
              ),
            ),
          )
        ]);
  }
}

class ProfileLogin extends StatelessWidget {
  const ProfileLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(50.0),
      width: (currentWidth > 500) ? 500 : double.infinity,
      height: currentHeight * 7 / 10,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: ThemeColor.white),
      child: const Login(),
    );
  }
}
