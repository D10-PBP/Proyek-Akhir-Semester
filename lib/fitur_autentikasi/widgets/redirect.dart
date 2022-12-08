import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/redirect_login.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class Redirect extends StatelessWidget {
  const Redirect({super.key, required this.anotherWidget});

  final Widget anotherWidget;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentUserProfileModel>(
      builder: ((context, profile, child) {
        return (profile.hasCurrentUser())
            ? anotherWidget
            : const RedirectLogin();
      }),
    );
  }
}
