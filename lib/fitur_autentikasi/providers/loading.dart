import 'package:flutter/material.dart';

class Loading extends ChangeNotifier {
  bool loading = false;

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  bool isLoading() => loading;
}
