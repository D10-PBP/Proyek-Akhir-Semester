import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/widget/drawer.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.sand,
      drawer: DrawerClass('Information', 1),
      body: Stack(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Container(
              padding: new EdgeInsets.all(10.0),
              child: Center(
                child: Text("Test"),
              ))
        ],
      ),
    );
  }
}
