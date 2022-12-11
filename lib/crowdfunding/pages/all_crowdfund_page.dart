import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AllCrowdfundPage extends StatefulWidget {
  dynamic crowdfund;
  AllCrowdfundPage({super.key, required this.crowdfund});

  @override
  State<AllCrowdfundPage> createState() => _AllCrowdfundPageState();
}

class _AllCrowdfundPageState extends State<AllCrowdfundPage> {
  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Back Button
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BackButton(
              onPressed: () {
                Provider.of<PageProvider>(context, listen: false).popInTab();
              },
            ),
            const SizedBox(
              width: 4,
            ),
            const Text("Crowdfunding",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),

        const SizedBox(
          height: 16,
        ),

        // Contents
        Expanded(
          child: Column(
            children: [
              // Title
              Container(
                height: MediaQuery.of(context).size.height / 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        widget.crowdfund['title'],
                        style: const TextStyle(
                            fontFamily: 'Verona',
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // Details
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)),
                  child: Container(
                    width: double.infinity,
                    color: ThemeColor.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          // Progress
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Progress",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                    "${widget.crowdfund['received']} dari ${widget.crowdfund['target']} benda diperoleh."),

                                const SizedBox(
                                  height: 16,
                                ),
                                // Description
                                const Text(
                                  "Deskripsi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Html(
                                    data: "${widget.crowdfund['description']}"),
                              ],
                            ),
                          ),

                          // Button to Contact
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(16.0),
                                              topRight: Radius.circular(16.0)),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                // Header
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        16.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        16.0)),
                                                        child: Container(
                                                          color:
                                                              ThemeColor.sand,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16.0),
                                                            child: Text(
                                                                'Hubungi ${widget.crowdfund['profile']['user']['first_name']}',
                                                                style: const TextStyle(
                                                                    fontFamily:
                                                                        'Verona',
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 24.0),

                                                // Contact Buttons
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      // LINE
                                                      if (widget.crowdfund[
                                                                  'profile']
                                                              ['line'] !=
                                                          '')
                                                        Column(
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  String
                                                                      lineId =
                                                                      widget.crowdfund[
                                                                              'profile']
                                                                          [
                                                                          'line'];

                                                                  final response =
                                                                      await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                          request,
                                                                          widget
                                                                              .crowdfund['id']);

                                                                  // pop twice
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Provider.of<PageProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .popInTab();

                                                                  // show thank you message
                                                                  showModalBottomSheet(
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(16.0),
                                                                            topRight: Radius.circular(16.0)),
                                                                      ),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Container(
                                                                          height:
                                                                              200,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Image.asset('assets/crowdfunding/thank_you_asset.png'),
                                                                                  SizedBox(
                                                                                    width: 16,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${response['message']}",
                                                                                      style: TextStyle(fontFamily: 'Verona', fontWeight: FontWeight.bold, fontSize: 18),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });

                                                                  _launchUrl(
                                                                      "https://line.me/R/ti/p/~${lineId}");
                                                                },
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                icon:
                                                                    const FaIcon(
                                                                  FontAwesomeIcons
                                                                      .line,
                                                                  color: ThemeColor
                                                                      .darkGreen,
                                                                  size: 42,
                                                                )),
                                                            const Text(
                                                              "LINE",
                                                            )
                                                          ],
                                                        ),

                                                      // WhatsApp
                                                      if (widget.crowdfund[
                                                                  'profile']
                                                              ['whatsapp'] !=
                                                          '')
                                                        Column(
                                                          children: [
                                                            IconButton(
                                                                onPressed:
                                                                    () async {
                                                                  String
                                                                      number =
                                                                      widget.crowdfund[
                                                                              'profile']
                                                                          [
                                                                          'whatsapp'];

                                                                  final response =
                                                                      await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                          request,
                                                                          widget
                                                                              .crowdfund['id']);

                                                                  // pop twice
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Provider.of<PageProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .popInTab();

                                                                  // show thank you message
                                                                  showModalBottomSheet(
                                                                      shape:
                                                                          const RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft:
                                                                                Radius.circular(16.0),
                                                                            topRight: Radius.circular(16.0)),
                                                                      ),
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return Container(
                                                                          height:
                                                                              200,
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Row(
                                                                                children: [
                                                                                  Image.asset('assets/crowdfunding/thank_you_asset.png'),
                                                                                  SizedBox(
                                                                                    width: 16,
                                                                                  ),
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      "${response['message']}",
                                                                                      style: TextStyle(fontFamily: 'Verona', fontWeight: FontWeight.bold, fontSize: 18),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });

                                                                  _launchUrl(
                                                                      "https://wa.me/+62${number.startsWith('0') ? number.substring(1) : number.substring(3)}");
                                                                },
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                icon: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .whatsapp,
                                                                  color: ThemeColor
                                                                      .darkGreen,
                                                                  size: 42,
                                                                )),
                                                            Text("WhatsApp")
                                                          ],
                                                        ),

                                                      // Telephone
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                String
                                                                    telephone =
                                                                    widget.crowdfund[
                                                                            'profile']
                                                                        [
                                                                        'telephone'];

                                                                final response =
                                                                    await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                        request,
                                                                        widget.crowdfund[
                                                                            'id']);

                                                                // pop twice
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Provider.of<PageProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .popInTab();

                                                                // show thank you message
                                                                showModalBottomSheet(
                                                                    shape:
                                                                        const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              16.0),
                                                                          topRight:
                                                                              Radius.circular(16.0)),
                                                                    ),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Image.asset('assets/crowdfunding/thank_you_asset.png'),
                                                                                SizedBox(
                                                                                  width: 16,
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    "${response['message']}",
                                                                                    style: TextStyle(fontFamily: 'Verona', fontWeight: FontWeight.bold, fontSize: 18),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                _launchUrl(
                                                                    "tel:${telephone}");
                                                              },
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: FaIcon(
                                                                FontAwesomeIcons
                                                                    .mobileScreenButton,
                                                                color: ThemeColor
                                                                    .darkGreen,
                                                                size: 42,
                                                              )),
                                                          Text("Telepon"),
                                                        ],
                                                      ),

                                                      // Email
                                                      Column(
                                                        children: [
                                                          IconButton(
                                                              onPressed:
                                                                  () async {
                                                                String email = widget
                                                                            .crowdfund[
                                                                        'profile']
                                                                    [
                                                                    'user']['email'];

                                                                final response =
                                                                    await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                        request,
                                                                        widget.crowdfund[
                                                                            'id']);

                                                                // pop twice
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Provider.of<PageProvider>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .popInTab();

                                                                // show thank you message
                                                                showModalBottomSheet(
                                                                    shape:
                                                                        const RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              16.0),
                                                                          topRight:
                                                                              Radius.circular(16.0)),
                                                                    ),
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Container(
                                                                        height:
                                                                            200,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Image.asset('assets/crowdfunding/thank_you_asset.png'),
                                                                                SizedBox(
                                                                                  width: 16,
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(
                                                                                    "${response['message']}",
                                                                                    style: TextStyle(fontFamily: 'Verona', fontWeight: FontWeight.bold, fontSize: 18),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });

                                                                _launchUrl(
                                                                    "mailto:${email}");
                                                              },
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: FaIcon(
                                                                FontAwesomeIcons
                                                                    .at,
                                                                color: ThemeColor
                                                                    .darkGreen,
                                                                size: 42,
                                                              )),
                                                          Text("Email"),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ThemeColor.darkGreen),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Hubungi",
                                      style: TextStyle(
                                        color: ThemeColor.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
