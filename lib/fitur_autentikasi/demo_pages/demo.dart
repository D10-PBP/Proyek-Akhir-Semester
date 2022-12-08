import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

class AuthenticatedWidget extends StatelessWidget {
  const AuthenticatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        color: ThemeColor.white,
        alignment: Alignment.center,
        child: const Text("Halaman Utama Demo", style: TextStyle(fontSize: 32)),
      ),
    ));
  }
}

class LoginMessageWidget extends StatelessWidget {
  const LoginMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        color: ThemeColor.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Halaman Login Demo",
              style: TextStyle(fontSize: 32),
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
                ),
                onPressed: Redirect.loginHandler(context),
                child: const Text(
                  "Button Redirect Login",
                  style: TextStyle(color: ThemeColor.white),
                ))
          ],
        ),
      ),
    ));
  }
}
