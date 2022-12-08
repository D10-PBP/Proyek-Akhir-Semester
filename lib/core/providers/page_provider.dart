import 'package:flutter/cupertino.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings_page.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/demo_pages/demo.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';

class PageProvider extends ChangeNotifier {
  Widget currentPage;
  int currentPageIndex;
  List<Widget> mainPages = [
    CrowdfundingsPage(), // nanti diganti sama Home
    BerandaBarangPage(),
    BerandaBarangPage(), // nanti diganti sama Request
    CrowdfundingsPage(),
    CrowdfundingsPage(), // nanti diganti sama Leaderboard
    Profile(),
    Redirect(mainWidget: MainWidget(), loginMessageWidget: NeedLoginWidget()),
  ];

  PageProvider({this.currentPageIndex = 0, this.currentPage = const Profile()});

  void changePageIndex(int newIndex) {
    currentPageIndex = newIndex;
    changeCurrentPage(mainPages[currentPageIndex]);
    notifyListeners();
  }

  void changeCurrentPage(Widget newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  Widget getCurrentPage() {
    return currentPage;
  }
}
