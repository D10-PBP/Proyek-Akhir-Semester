import 'package:flutter/material.dart';
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
            onPressed: () => Navigator.pop(context),
          ),
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
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image.asset(
                  "information/team/Cath.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 30,
                height: 200,
              ),
              const Expanded(
                  child: Text(
                "Catherine Angel Robin",
                style: TextStyle(
                    fontFamily: 'Verona',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        "Gibrano Fabien Derenz",
                        style: TextStyle(
                            fontFamily: 'Verona',
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ))),
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.only(right: 50),
                child: Image.asset(
                  "information/team/Gibrano.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image.asset(
                  "information/team/Khansa.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 30,
                height: 200,
              ),
              const Expanded(
                  child: Text(
                "Khansa Jovita",
                style: TextStyle(
                    fontFamily: 'Verona',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Kristo Jeremy Thady Tobing",
                        style: TextStyle(
                            fontFamily: 'Verona',
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ))),
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: Image.asset(
                  "information/team/Kristo.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Image.asset(
                  "information/team/Lyzander.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 30,
                height: 200,
              ),
              const Expanded(
                  child: Text(
                "Lyzander Marciano Andrylie",
                style: TextStyle(
                    fontFamily: 'Verona',
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Text(
                        "Pikatan Arya Bramajati",
                        style: TextStyle(
                            fontFamily: 'Verona',
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ))),
              const SizedBox(
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: Image.asset(
                  "information/team/Pikatan.png",
                  height: 150,
                  width: 150,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
