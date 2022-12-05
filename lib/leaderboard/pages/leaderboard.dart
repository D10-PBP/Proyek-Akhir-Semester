import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/leaderboard/models/leaderboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  Future<List<User>> fetchUser() async {
    var url =
        Uri.parse('https://sayang-dibuang.up.railway.app/leaderboard/json/');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    var users = jsonDecode(utf8.decode(response.bodyBytes));

    List<User> listUser = [];
    for (var i in users) {
      if (i != null) {
        listUser.add(User.fromJson(i));
      }
    }
    return listUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text("Leaderboard",
              style: TextStyle(
                fontFamily: "Verona",
                fontWeight: FontWeight.bold,
                fontSize: 32,
              )),
          const Text("Here are our top gainers",
              style: TextStyle(
                fontFamily: "PlusJakarta",
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 50.0,
            width: 320.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xFFD9D9D9)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Username",
                    style: TextStyle(
                      fontFamily: "PlusJakarta",
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Points",
                    style: TextStyle(
                      fontFamily: "PlusJakarta",
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Badge",
                    style: TextStyle(
                      fontFamily: "PlusJakarta",
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 2.0,
              width: 315.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ThemeColor.gold)),
          const SizedBox(
            height: 5,
          ),
          FutureBuilder(
              future: fetchUser(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                      width: 350,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                height: 60.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: const Color(0xFFD9D9D9)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "${snapshot.data![index].username}",
                                          style: const TextStyle(
                                            fontFamily: "PlusJakarta",
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "${snapshot.data![index].poin}",
                                          style: const TextStyle(
                                            fontFamily: "PlusJakarta",
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      //TODO BADGES
                                    ],
                                  ),
                                ),
                              )));
                }
              }),
          const SizedBox(
            height: 50,
          )
        ],
      ))),
    );
  }
}
