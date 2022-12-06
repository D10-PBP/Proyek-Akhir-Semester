import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';

class CurrentUserProfileModel extends ChangeNotifier {
  UserProfile? _user;

  void addUser(UserProfile user) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  bool hasCurrentUser() => _user != null;

  // Getter
  UserProfile? get user => _user;
}
