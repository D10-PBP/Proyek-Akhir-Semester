import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/main.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/login.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass(this.currentPage, this.currentIndex, {super.key});
  final String currentPage;
  final int currentIndex;
  // static final int _currentSelected = 0;
  // Kalo mw tambahin drawer bisa lgsg maskin ke list aja Title sama Page Widgetnya
  static final List<String> _listViewData = [
    "Home",
    "Beranda",
    "Login",
  ];
  static final List<Widget> _listViewPages = [
    const MyHomePage(),
    const BerandaBarangPage(),
    const LoginPage(),
  ];
  @override
  State<StatefulWidget> createState() => DrawerClassState();
}

class DrawerClassState extends State<DrawerClass> {
  // int _currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ThemeColor.darkGreen,
      child: Container(
        child: ListView.builder(
          itemCount: DrawerClass._listViewData.length,
          itemBuilder: (context, index) {
            return Container(
              color: widget.currentIndex == index
                  ? ThemeColor.sand
                  : ThemeColor.darkGreen,
              child: ListTile(
                textColor: widget.currentIndex == index
                    ? ThemeColor.darkGreen
                    : ThemeColor.sand,
                title: Text(
                  DrawerClass._listViewData[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DrawerClass._listViewPages[index]),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
