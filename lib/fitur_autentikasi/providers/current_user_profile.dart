import 'package:flutter/material.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/update_user.dart';
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

  void updateName(UpdateUser updateUser) {
    _user!.firstName = updateUser.firstName;
    _user!.lastName = updateUser.lastName;
    notifyListeners();
  }

  void updateContact(UpdateUser updateUser) {
    _user!.telephone = updateUser.telephone;
    _user!.whatsapp = updateUser.whatsapp;
    _user!.line = updateUser.line;
    notifyListeners();
  }

  void addUserPoin(int poin) {
    _user!.fields.poin += poin;
    notifyListeners();
  }

  bool hasCurrentUser() => _user != null;

  // Getter
  UserProfile? get user => _user;
}
