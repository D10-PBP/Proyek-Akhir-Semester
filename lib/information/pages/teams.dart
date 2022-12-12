import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.sand,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Provider.of<PageProvider>(context, listen: false).popInTab();
              }),
          backgroundColor: ThemeColor.darkGreen,
          shadowColor: Colors.transparent),
      body: ListView(
        // padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            color: ThemeColor.darkGreen,
            child: const Text(
              "Teams",
              style: TextStyle(
                  fontFamily: "Verona",
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Catherine Angel Robin",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Cath.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Gibrano Fabien Derenz",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Gibrano.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Khansa Jovita",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Khansa.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Kristo Jeremy Thady Tobing",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Kristo.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Lyzander Marciano Andrylie",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Lyzander.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                      child: Padding(
                          padding: EdgeInsets.only(left: 50),
                          child: Text(
                            "Pikatan Arya Bramajati",
                            style: TextStyle(
                                fontFamily: 'Verona',
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )))),
              const SizedBox(
                height: 200,
              ),
              Expanded(
                  child: SizedBox(
                      child: Padding(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  "assets/information/team/Pikatan.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ))),
            ],
          ),
        ],
      ),
    );
  }
}
