// ignore_for_file: unnecessary_const, unnecessary_string_escapes

import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';

import 'package:sayang_dibuang_mobile/information/pages/review.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({super.key});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

final List<String> imgList = [
  'https://github.com/khansajovita/imgTugasPBP_UAS/blob/main/slide1flutter.png',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.brown,
      ThemeColor.gold,
      ThemeColor.white,
      ThemeColor.darkGreen,
    ];

    const colorizeTextStyle = TextStyle(
        fontSize: 50.0, fontFamily: 'Verona', fontWeight: FontWeight.bold);

    return Scaffold(
        backgroundColor: ThemeColor.sand,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tulisan Information
                Container(
                  color: ThemeColor.darkGreen,
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    "Information",
                    style: TextStyle(
                        fontFamily: "Verona",
                        fontSize: 32,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),

                // Animated About Us
                // reference : https://pub.dev/packages/animated_text_kit
                SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText('About Us',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors),
                          ColorizeAnimatedText('Sayang-Dibuang',
                              textStyle: colorizeTextStyle,
                              colors: colorizeColors),
                        ],
                        repeatForever: true,
                      ),
                    )),

                const SizedBox(
                  height: 32,
                ),

                // corousel slider
                // references :
                // https://pub.dev/packages/carousel_slider/example
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: true),
                ),

                const SizedBox(
                  height: 100,
                ),

                Center(
                  child: Container(
                    width: 400,
                    height: 200,
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: ThemeColor.darkGreen,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Cape banget bos",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewPage()));
                      },
                    ),
                  ),
                ),

                Center(
                  child: Container(
                    width: 400,
                    height: 200,
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: ThemeColor.darkGreen,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Mau jadi awan aja",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ReviewPage()));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),

                const Center(
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                        fontFamily: "Verona",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Accordion(
                  maxOpenSections: 2,
                  scaleWhenAnimating: true,
                  openAndCloseAnimation: true,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      isOpen: false,
                      headerBackgroundColor: ThemeColor.gold,
                      headerBackgroundColorOpened: ThemeColor.gold,
                      header: const Text(
                        'Apa itu website dan/atau aplikasi SayangDibuang?',
                      ),
                      content: const Text(
                          "SayangDibuang merupakan website atau aplikasi yang memberikan kesempatan bagi mereka yang membutuhkan maupun yang ingin berbagi untuk menuangkan rasa keinginan mereka. Dengan begitu, masing-masing individu akan merasa terbantu dan membantu atas kehadiran website atau aplikasi kami.",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 0,
                    ),
                    AccordionSection(
                      isOpen: false,
                      headerBackgroundColor: ThemeColor.gold,
                      headerBackgroundColorOpened: ThemeColor.gold,
                      header: const Text(
                        'Apa tujuan SayangDibuang?',
                      ),
                      content: const Text(
                          "Tujuan SayangDibuang adalah untuk memberikan bantuan terhadap kehidupan bumi. Dengan adanya pengurangan sampah, maka kehidupan akan sehat dan nyaman serta mengurangi peningkatan gas metana dan karbon dioksida. SayangDibuang juga ingin membantu mereka yang membutuhkan barang secara gratis dari pemilik barang, dan mengadakan kampanye untuk orang-orang yang lebih membutuhkan",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 0,
                    ),
                    AccordionSection(
                      isOpen: false,
                      headerBackgroundColor: ThemeColor.gold,
                      headerBackgroundColorOpened: ThemeColor.gold,
                      header: const Text(
                        'Bagaimana cara membuat request barang?',
                      ),
                      content: const Text(
                          "Tekan tombol Menu di ujung kanan atas pada navigasi bar, tekan kembali pilihan request lalu create sebuah request Anda sesuai dengan barang yang dibutuhkan. Setelah Anda sudah mengisi semua form, tekan add atau submit dan request Anda akan muncul pada beranda request barang",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 0,
                    ),
                    AccordionSection(
                      isOpen: false,
                      headerBackgroundColor: ThemeColor.gold,
                      headerBackgroundColorOpened: ThemeColor.gold,
                      header: const Text(
                        'Fitur apa saja yang dimiliki oleh SayangDibuang',
                      ),
                      content: const Text(
                          "Aplikasi kami memiliki banyak fitur diantaranya: Membuat request barang, menawarkan barang, leaderboard, serta fitur kampanye yang dapat dibuka oleh siapapun! Kami tidak membatasi pengguna dalam menggunakan fitur kami, selamat menikmati!",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 0,
                    ),
                    AccordionSection(
                      isOpen: false,
                      headerBackgroundColor: ThemeColor.gold,
                      headerBackgroundColorOpened: ThemeColor.gold,
                      header: const Text(
                        'Untuk apa Crowdfunding di aplikasi SayangDibuang?',
                      ),
                      content: const Text(
                          "Fitur Crowdfunding digunakan oleh pengguna yang ingin menggalang barang bekas sejenis dalam jumlah banyak yang nantinya akan diberikan kepada mereka yang membutuhkan. Feedback yang diberikan oleh pengguna lain yang telah membantu kampanye, akan mendapatkan 5 poin untuk setiap satu kali bantu.",
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 0,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
