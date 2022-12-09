import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

// DestinationWidget hanya dapat diakses oleh pengguna yang telah terautentikasi
class DestinationWidget extends StatelessWidget {
  const DestinationWidget({super.key});

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
          const Text("Halaman Pertama Demo", style: TextStyle(fontSize: 32)),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
              ),
              // onPressed: Redirect.loginHandler(context),
              onPressed: Redirect.loginHandler(context,
                  currentWidget: const DestinationWidget(),
                  mainWidget: const MainWidget(),
                  destinationWidget: const DestinationWidgetTwo()),
              child: const Text(
                "Button ke DestinationWidgetTwo",
                style: TextStyle(color: ThemeColor.white),
              ))
        ],
      ),
    )));
  }
}

// DestinationWidgetTwo hanya dapat diakses oleh pengguna yang telah terautentikasi
class DestinationWidgetTwo extends StatelessWidget {
  const DestinationWidgetTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
      child: Container(
        color: ThemeColor.white,
        alignment: Alignment.center,
        child: const Text("Halaman Kedua Demo", style: TextStyle(fontSize: 32)),
      ),
    ));
  }
}

// Main Widget dapat diakses oleh publik
// Main Widget befungsi sebagai widget yang ditampilkan ketika pengguna tidak terautentikasi
class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

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
                // onPressed: Redirect.loginHandler(context),
                onPressed: Redirect.loginHandler(context,
                    currentWidget: const MainWidget(),
                    mainWidget: const MainWidget(),
                    destinationWidget: const DestinationWidget()),
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
