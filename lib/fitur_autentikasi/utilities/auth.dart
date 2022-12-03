import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';

Future<UserProfile?> login(CookieRequest request, String loginUrl,
    String username, String password1) async {
  // 'username' and 'password' should be the values of the user login form.
  final response = await request.login(loginUrl, {
    'username': username,
    'password': password1,
  });
  if (request.loggedIn) {
    // Code here will run if the login succeeded.
    final userDataJson = await getUserData(request, username);
    UserProfile userProfile = UserProfile.fromJson(userDataJson[0]);
    return userProfile;
  } else {
    // Code here will run if the login failed (wrong username/password).
    return null;
  }
}

Future<void> logout(CookieRequest request, String logoutUrl) async {
  request.logout(logoutUrl);
}

Future<dynamic> getUserData(CookieRequest request, String username) async {
  // String userDataURL = "http://127.0.0.1:8000/user-data/$username";
  String userDataURL =
      "https://sayang-dibuang.up.railway.app/user-data/$username";
  final userDataJson = await request.get(userDataURL);
  return userDataJson;
}
