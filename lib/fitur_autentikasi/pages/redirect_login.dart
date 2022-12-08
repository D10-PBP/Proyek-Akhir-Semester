import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/login.dart';

class RedirectLogin extends StatelessWidget {
  const RedirectLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: ThemeColor.darkGreen,
          shadowColor: Colors.transparent),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(20),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            width: (currentWidth > 500) ? 500 : double.infinity,
            height: currentHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: ThemeColor.white),
            child: const Login(),
          ),
        ),
      ),
      backgroundColor: ThemeColor.darkGreen,
    );
  }
}
