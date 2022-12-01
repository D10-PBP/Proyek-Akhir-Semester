import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.gold,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: GNav(
            gap: 8,
            backgroundColor: ThemeColor.gold,
            color: ThemeColor.sand,
            activeColor: ThemeColor.sand,
            tabBackgroundColor: ThemeColor.darkGreen,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            tabs: [
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
    );
  }
}
