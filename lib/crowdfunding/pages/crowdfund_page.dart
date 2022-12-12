import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:intl/intl.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/edit_crowdfund_page.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/utils/crowdfund_api_handler.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class CrowdfundPage extends StatefulWidget {
  dynamic crowdfund;
  CrowdfundPage({super.key, required this.crowdfund});

  @override
  State<CrowdfundPage> createState() => _CrowdfundPageState();
}

class _CrowdfundPageState extends State<CrowdfundPage> {
  Future<void> _launchUrl(String urlString) async {
    final Uri _url = Uri.parse(urlString);
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final profile = context.read<CurrentUserProfileModel>();

    return SafeArea(
      // Header
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AppBar(
          elevation: 0,
          backgroundColor: ThemeColor.sand,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackButton(
                color: Colors.black,
                onPressed: () {
                  Provider.of<PageProvider>(context, listen: false).popInTab();
                },
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Crowdfunding",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 16,
              ),
              Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.crowdfund['title'],
                      style: TextStyle(
                          fontFamily: 'Verona',
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.user),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.crowdfund['profile']['user']['username'],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Button to Contact
                    profile.user!.pk == widget.crowdfund['user_id']
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditCrowdfundPage(
                                                  crowdfund:
                                                      widget.crowdfund)));
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ThemeColor.gold),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidPenToSquare,
                                        color: ThemeColor.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: ThemeColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
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
                                                        color: ThemeColor.sand,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Text(
                                                              'Hubungi ${widget.crowdfund['profile']['user']['first_name']}',
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Verona',
                                                                  fontSize: 20,
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
                                                                String lineId =
                                                                    widget.crowdfund[
                                                                            'profile']
                                                                        [
                                                                        'line'];

                                                                final response =
                                                                    await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                        request,
                                                                        widget.crowdfund[
                                                                            'id']);

                                                                // add user point in flutter
                                                                if (response[
                                                                        'poin'] !=
                                                                    null) {
                                                                  profile
                                                                      .addUserPoin(
                                                                          5);
                                                                }

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
                                                                String number =
                                                                    widget.crowdfund[
                                                                            'profile']
                                                                        [
                                                                        'whatsapp'];

                                                                final response =
                                                                    await CrowdfundAPIHandler.addUserPointWhenContacting(
                                                                        request,
                                                                        widget.crowdfund[
                                                                            'id']);

                                                                // add user point in flutter
                                                                if (response[
                                                                        'poin'] !=
                                                                    null) {
                                                                  profile
                                                                      .addUserPoin(
                                                                          5);
                                                                }

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
                                                              String telephone =
                                                                  widget.crowdfund[
                                                                          'profile']
                                                                      [
                                                                      'telephone'];

                                                              final response = await CrowdfundAPIHandler
                                                                  .addUserPointWhenContacting(
                                                                      request,
                                                                      widget.crowdfund[
                                                                          'id']);

                                                              // add user point in flutter
                                                              if (response[
                                                                      'poin'] !=
                                                                  null) {
                                                                profile
                                                                    .addUserPoin(
                                                                        5);
                                                              }

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
                                                                            Radius.circular(
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
                                                                EdgeInsets.zero,
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

                                                              final response = await CrowdfundAPIHandler
                                                                  .addUserPointWhenContacting(
                                                                      request,
                                                                      widget.crowdfund[
                                                                          'id']);

                                                              // add user point in flutter
                                                              if (response[
                                                                      'poin'] !=
                                                                  null) {
                                                                profile
                                                                    .addUserPoin(
                                                                        5);
                                                              }

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
                                                                            Radius.circular(
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
                                                                EdgeInsets.zero,
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
                            ],
                          ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0)),
                child: Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 300),
                  width: MediaQuery.of(context).size.width,
                  color: ThemeColor.white,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        // Created
                        Row(
                          children: [
                            FaIcon(FontAwesomeIcons.calendarDays),
                            SizedBox(
                              width: 8,
                            ),
                            Text(DateFormat("EEEE, d MMMM yyyy", "id_ID")
                                .format(DateTime.parse(
                                    widget.crowdfund['created']))),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Progress",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                backgroundColor: ThemeColor.sand,
                                color: ThemeColor.darkGreen,
                                value: widget.crowdfund['received'] /
                                    widget.crowdfund['target'],
                                minHeight: 12,
                              ),
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
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            ),
                            Text(
                              Bidi.stripHtmlIfNeeded(
                                  "${widget.crowdfund['description']}"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
