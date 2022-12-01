import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';

class CrowdfundingsPage extends StatefulWidget {
  const CrowdfundingsPage({super.key});
  final String title = 'Sayang Dibuang App';

  @override
  State<CrowdfundingsPage> createState() => _CrowdfundingsPageState();
}

class _CrowdfundingsPageState extends State<CrowdfundingsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 16.0),
              child: Text(
                "Crowdfunding",
                style: TextStyle(
                    fontFamily: "Verona",
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ),

            const SizedBox(
              height: 32,
            ),

            // User Crowdfunds
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Kampanyeku",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              height: 210,
              child: ListView.builder(
                // physics: to remove bouncing effect on the edges after scrolling
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: ThemeColor.white,
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Butuh 20 karton",
                                style: TextStyle(
                                    fontFamily: "Verona", fontSize: 20),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                  "Halo teman-teman. Saya sedang mengerjakan proyek Seni Rupa..."),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(
                                        color: ThemeColor.darkGreen,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Text("Lihat",
                                              style: TextStyle(
                                                  color: ThemeColor.sand)),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // All Crowdfunds
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Semua Crowdfund",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Expanded(
              child: ListView.builder(
                // physics: to remove bouncing effect on the edges after scrolling
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: ThemeColor.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Butuh 20 karton",
                                style: TextStyle(
                                    fontFamily: "Verona", fontSize: 20),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                  "Halo teman-teman. Saya sedang mengerjakan proyek Seni Rupa..."),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4.0),
                                    child: Container(
                                        color: ThemeColor.darkGreen,
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8.0),
                                          child: Text("Lihat",
                                              style: TextStyle(
                                                  color: ThemeColor.sand)),
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
