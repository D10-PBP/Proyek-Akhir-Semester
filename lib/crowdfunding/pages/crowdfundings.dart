import 'package:flutter/material.dart';

class CrowdfundingsPage extends StatefulWidget {
  const CrowdfundingsPage({super.key});
  final String title = 'Sayang Dibuang App';

  @override
  State<CrowdfundingsPage> createState() => _CrowdfundingsPageState();
}

class _CrowdfundingsPageState extends State<CrowdfundingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Crowdfundings",
      ),
    );
  }
}
