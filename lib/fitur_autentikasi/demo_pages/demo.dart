import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

import '../providers/current_user_profile.dart';

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
              onPressed: Redirect.loginHandler(context,
                  currentWidget: const DestinationWidget(),
                  mainWidget: const MainWidget(),
                  destinationWidget: const DestinationWidgetTwo()),
              child: const Text(
                "Button ke DestinationWidgetTwo",
                style: TextStyle(color: ThemeColor.white),
              )),
          IconButton(
              icon: const Icon(Icons.arrow_back, color: ThemeColor.darkGreen),
              onPressed: () => context.read<PageProvider>().popInTab()),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Halaman Kedua Demo", style: TextStyle(fontSize: 32)),
            IconButton(
              icon: const Icon(Icons.arrow_back, color: ThemeColor.darkGreen),
              onPressed: () => context.read<PageProvider>().popInTab(),
            ),
          ],
        ),
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

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

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
          const Text("Login Message", style: TextStyle(fontSize: 32)),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
              ),
              onPressed: Redirect.loginHandler(context,
                  currentWidget: const MessagePage(),
                  mainWidget: const MessagePage(),
                  destinationWidget: const DestinationWidget()),
              child: const Text(
                "Login untuk Akses Fitur",
                style: TextStyle(color: ThemeColor.white),
              ))
        ],
      ),
    )));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Perhatikan widget yang di-return bisa tidak harus Column
    // Penggunaan Column di sini hanya untuk mempermudah
    return Column(children: [
      Consumer<CurrentUserProfileModel>(
        builder: (context, profile, child) {
          return Text(profile.user!.poin.toString());
        },
      ), // tipe data poin adalah int
    ]);
  }
}
