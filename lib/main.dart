import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings.dart';

import 'core/theme/theme_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayang Dibuang',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'PlusJakarta'),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  final String title = 'Sayang Dibuang App';

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      CrowdfundingsPage(), // nanti diganti sama Home
      BerandaBarangPage(),
      BerandaBarangPage(), // nanti diganti sama Request
      CrowdfundingsPage(),
      CrowdfundingsPage(), // nanti diganti sama Leaderboard
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark),
      child: Scaffold(
          // background color
          backgroundColor: ThemeColor.sand,

          // the screen
          body: pages[currentIndex],

          // the bottom navbar
          bottomNavigationBar: Container(
            color: ThemeColor.gold,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: GNav(
                  gap: 8,
                  backgroundColor: ThemeColor.gold,
                  color: ThemeColor.sand,
                  activeColor: ThemeColor.sand,
                  tabBackgroundColor: ThemeColor.darkGreen,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  onTabChange: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  tabs: const [
                    GButton(
                      icon: Icons.home_rounded,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.dashboard,
                      text: 'Beranda',
                    ),
                    GButton(
                      icon: Icons.handshake_rounded,
                      text: 'Request',
                    ),
                    GButton(
                      icon: Icons.group_outlined,
                      text: 'Crowdfunding',
                    ),
                    GButton(
                      icon: Icons.leaderboard_rounded,
                      text: 'Leaderboard',
                    ),
                  ]),
            ),
          )),
    );
  }
}
