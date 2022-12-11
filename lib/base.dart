import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/widget/bottom_navbar.dart';
import 'core/theme/theme_color.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
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
          body: Provider.of<PageProvider>(context).getCurrentPage(),

          // the bottom navbar
          bottomNavigationBar: const BottomNavbar()),
    );
  }
}
