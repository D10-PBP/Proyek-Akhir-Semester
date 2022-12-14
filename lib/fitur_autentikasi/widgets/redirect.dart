import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sayang_dibuang_mobile/core/providers/page_provider.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/redirect_login.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/dialog.dart';

class Redirect extends StatelessWidget {
  const Redirect({
    super.key,
    required this.currentWidget,
    required this.mainWidget,
    required this.destinationWidget,
  });

  final Widget currentWidget;
  final Widget mainWidget;
  final Widget destinationWidget;

  static pushToLogin(BuildContext context) {
    return Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RedirectLogin()));
  }

  static loginHandler(
    BuildContext context, {
    String message = "Anda harus login untuk mengakses fitur ini",
    required Widget currentWidget,
    required Widget mainWidget,
    required Widget destinationWidget,
  }) {
    return () {
      if (!context.read<CurrentUserProfileModel>().hasCurrentUser()) {
        loginDialog(context, message, "Login");
      }

      context.read<PageProvider>().changeCurrentPage(Redirect(
            currentWidget: currentWidget,
            mainWidget: mainWidget,
            destinationWidget: destinationWidget,
          ));
    };
  }

  @override
  Widget build(BuildContext context) {
    final profileWatch = context.watch<CurrentUserProfileModel>();
    final pageProvider = context.read<PageProvider>();

    if (profileWatch.hasCurrentUser()) {
      pageProvider.tabHistories[pageProvider.currentPageIndex]
          .add(currentWidget);
      // pageProvider.history.add(currentWidget);
      // print(pageProvider.history);
      return destinationWidget;
    } else {
      return mainWidget;
    }
  }
}
