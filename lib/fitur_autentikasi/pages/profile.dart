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
      child: Center(child: Consumer<CurrentUserProfileModel>(
        builder: ((context, profile, child) {
          return (profile.hasCurrentUser())
              ? const ProfilePageUser()
              : const ProfileLogin();
        }),
      )),
    );
  }
}

class ProfilePageUser extends StatelessWidget {
  const ProfilePageUser({super.key});

  final mounted = true;

  Widget tableProfile(CurrentUserProfileModel profile) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(),
        1: FixedColumnWidth(10),
        2: FlexColumnWidth(),
      },
      border: const TableBorder(
          horizontalInside: BorderSide(
              width: 1, color: Colors.grey, style: BorderStyle.solid)),
      children: [
        tableProfileRow("Username", profile.user!.username),
        tableProfileRow("Email", profile.user!.email),
        tableProfileRow("Poin", profile.user!.poin.toString()),
        tableProfileRow("Nama Lengkap", profile.user!.fullname),
        tableProfileRow("Nomor Telepon", profile.user!.telephone),
        tableProfileRow("Nomor Whatsapp", profile.user!.whatsapp),
        tableProfileRow("ID Line", profile.user!.line),
      ],
    );
  }

  TableRow tableProfileRow(String name, String value) {
    return TableRow(children: [
      Text(name),
      const Text(':'),
      Text(value),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();
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
                  tableProfile(profile),
                  const SizedBox(height: 20),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ThemeColor.darkGreen),
                      ),
                      onPressed: () async {
                        final response = await logout(context, request);
                        if (!mounted) return;
                        if (!context
                            .read<CurrentUserProfileModel>()
                            .hasCurrentUser()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 15,
                                child: SizedBox(
                                  width: 300,
                                  height: 150,
                                  child: Center(
                                    child: ListView(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      shrinkWrap: true,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              response,
                                              textAlign: TextAlign.center,
                                            )),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Kembali'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
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
