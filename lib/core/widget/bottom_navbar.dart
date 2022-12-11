import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import '../../core/theme/theme_color.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.gold,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: GNav(
            gap: 8,
            backgroundColor: ThemeColor.gold,
            color: ThemeColor.sand,
            activeColor: ThemeColor.sand,
            tabBackgroundColor: ThemeColor.darkGreen,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            onTabChange: (index) {
              setState(() {
                Provider.of<PageProvider>(context, listen: false)
                    .changePageIndex(index);
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
              ),
              GButton(
                icon: Icons.dashboard,
              ),
              GButton(
                icon: Icons.handshake_rounded,
              ),
              GButton(
                icon: Icons.group_outlined,
              ),
              GButton(
                icon: Icons.leaderboard_rounded,
              ),
              GButton(
                icon: Icons.account_circle_outlined,
              ),
              GButton(
                icon: Icons.launch,
              ),
            ]),
      ),
    );
  }
}
