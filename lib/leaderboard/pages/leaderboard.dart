// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/leaderboard/models/leaderboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sayang_dibuang_mobile/leaderboard/models/message.dart';

import '../../core/providers/page_provider.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textarea = TextEditingController();

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

  Future<List<Message>> fetchMessage() async {
    var url = Uri.parse(
        'https://sayang-dibuang.up.railway.app/leaderboard/json-message/');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    var messages = jsonDecode(utf8.decode(response.bodyBytes));

    List<Message> listMessage = [];

    for (var i in messages) {
      if (i != null) {
        listMessage.add(Message.fromJson(i));
      }
    }

    return listMessage;
  }

  String randomMessage = "";

  sendMessage(request, message) async {
    var response = await request.post(
        "https://sayang-dibuang.up.railway.app/leaderboard/get-message-flutter/",
        {"message": message});
    return response['test'];
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return SafeArea(
      child: SingleChildScrollView(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("Leaderboard",
              style: TextStyle(
                fontFamily: "Verona",
                fontWeight: FontWeight.bold,
                fontSize: 32,
              )),
          FutureBuilder(
              future: fetchMessage(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Text(" ");
                } else {
                  return Text('"${snapshot.data![0].message}"',
                      style: const TextStyle(
                        fontFamily: "PlusJakarta",
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic,
                        fontSize: 14,
                      ));
                }
              }),
          const Text("Here are our top gainers",
              style: TextStyle(
                fontFamily: "PlusJakarta",
                fontWeight: FontWeight.normal,
                fontSize: 16,
              )),
          const SizedBox(
            height: 8,
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
                                    horizontal: 16, vertical: 5),
                                height: 55.0,
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
                                      Expanded(
                                          flex: 3,
                                          child: (snapshot
                                                      .data![index].status ==
                                                  1)
                                              ? Image.asset(
                                                  'assets/leaderboard/Gold.png')
                                              : (snapshot.data![index].status ==
                                                      2)
                                                  ? Image.asset(
                                                      'assets/leaderboard/Silver.png')
                                                  : (snapshot.data![index]
                                                              .status ==
                                                          3)
                                                      ? Image.asset(
                                                          'assets/leaderboard/Bronze.png')
                                                      : Image.asset(
                                                          'assets/leaderboard/Standard.png'))
                                    ],
                                  ),
                                ),
                              )));
                }
              }),
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
            height: 8,
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const Text("Ayo kirim pesan ke pengguna lain!",
                    style: TextStyle(
                      fontFamily: "PlusJakarta",
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    )),
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    height: 65.0,
                    width: 320.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: ThemeColor.darkGreen),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: textarea,
                        style: const TextStyle(
                            color: ThemeColor.white,
                            fontFamily: "PlusJakarta",
                            fontSize: 14),
                        decoration: const InputDecoration(
                            labelText: "Kirim pesanmu",
                            labelStyle: TextStyle(
                                fontFamily: "PlusJakarta",
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: ThemeColor.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ThemeColor.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: ThemeColor.white),
                            ),
                            fillColor: ThemeColor.white),
                        onChanged: (String? value) {
                          setState(() {
                            randomMessage = value!;
                          });
                        },
                        onSaved: (String? value) {
                          setState(() {
                            randomMessage = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Pesan kosong';
                          }
                          return null;
                        },
                      ),
                    )),
                TextButton(
                  child: Text(
                    "Kirim",
                    style: TextStyle(
                        fontFamily: "PlusJakarta",
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: ThemeColor.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.darkGreen)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      sendMessage(request, randomMessage);
                    }
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: Container(
                              child: ListView(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  Center(child: const Text('Pesan Terkirim')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Kembali'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10.0,
          )
        ],
      ))),
    );
  }
}
