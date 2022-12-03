import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings.dart';

import 'core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CookieRequest()),
        ChangeNotifierProvider(create: (_) => CurrentUserProfileModel()),
      ],
      child: MaterialApp(
        title: 'Sayang Dibuang',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
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
