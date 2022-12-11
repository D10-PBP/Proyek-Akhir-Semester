import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/barang_bekas/pages/beranda.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings_no_user_page.dart';
import 'package:sayang_dibuang_mobile/crowdfunding/pages/crowdfundings_page.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/demo_pages/demo.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/redirect.dart';
import 'package:sayang_dibuang_mobile/leaderboard/pages/leaderboard.dart';

class PageProvider extends ChangeNotifier {
  Widget currentPage;
  int currentPageIndex;
  List<Widget> history = [];

  List<List<Widget>> tabHistories = [[], [], [], [], [], []];

  List<Widget> mainPages = [
    CrowdfundingsNoUserPage(), // nanti diganti sama Home
    BerandaBarangPage(),
    CrowdfundingsNoUserPage(), // nanti diganti sama Request
    Redirect(
        currentWidget: const CrowdfundingsNoUserPage(),
        mainWidget: const CrowdfundingsNoUserPage(),
        destinationWidget: CrowdfundingsPage()),
    LeaderboardPage(),
    Profile(),
  ];

  PageProvider({
    this.currentPageIndex = 5,
    this.currentPage = const Profile(),
  });

  void pushInTab(Widget prevPage, Widget newPage) {
    tabHistories[currentPageIndex].add(currentPage);
    changeCurrentPage(newPage);
  }

  void popInTab() {
    changeCurrentPage(tabHistories[currentPageIndex].isEmpty
        ? mainPages[currentPageIndex]
        : tabHistories[currentPageIndex].removeLast());
  }

  void pop() {
    changeCurrentPage(history.removeLast());
  }

  void push(Widget prevPage, Widget newPage) {
    addHistory(prevPage);
    changeCurrentPage(newPage);
  }

  void addHistory(Widget prevPage) {
    history.add(prevPage);
  }

  void changePageIndex(int newIndex) {
    tabHistories[currentPageIndex].add(currentPage);
    currentPageIndex = newIndex;
    popInTab();
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
