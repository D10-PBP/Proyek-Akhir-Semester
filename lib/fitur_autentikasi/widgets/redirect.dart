import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/redirect_login.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/dialog.dart';

class Redirect extends StatelessWidget {
  const Redirect(
      {super.key, required this.mainWidget, required this.loginMessageWidget});

  final Widget mainWidget;
  final Widget loginMessageWidget;

  static pushToLogin(BuildContext context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RedirectLogin()));
    };
  }

  static loginHandler(BuildContext context,
      {String message = "Anda harus login untuk mengakses fitur ini"}) {
    return () {
      redirectDialog(context, message, pushToLogin(context), "Login");
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserProfileModel>(
      builder: ((context, profile, child) {
        return (profile.hasCurrentUser()) ? mainWidget : loginMessageWidget;
      }),
    );
  }
}
