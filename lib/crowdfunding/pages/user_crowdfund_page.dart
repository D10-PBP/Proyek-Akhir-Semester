import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/models/crowdfund.dart';

class UserCrowdfundPage extends StatefulWidget {
  Crowdfund crowdfund;
  UserCrowdfundPage({super.key, required this.crowdfund});

  @override
  State<UserCrowdfundPage> createState() => _UserCrowdfundPageState();
}

class _UserCrowdfundPageState extends State<UserCrowdfundPage> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      BackButton(
        onPressed: () {
          Provider.of<PageProvider>(context, listen: false).pop();
        },
      ),
      Text(widget.crowdfund.title),
      Text(widget.crowdfund.description),
      Text(widget.crowdfund.created.toString()),
    ]);
  }
}
