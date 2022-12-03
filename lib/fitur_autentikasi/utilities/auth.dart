import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class URL {
  static String userDataURL(username) =>
      "https://sayang-dibuang.up.railway.app/user-data/$username";
  static const String loginUrl =
      "https://sayang-dibuang.up.railway.app/login/ajax";
  static const String logoutUrl =
      "https://sayang-dibuang.up.railway.app/logout";
}

Future<void> login(BuildContext context, bool mounted, CookieRequest request,
    String username, String password1) async {
  // 'username' and 'password' should be the values of the user login form.
  await request.login(URL.loginUrl, {
    'username': username,
    'password': password1,
  });
  if (request.loggedIn) {
    // Code here will run if the login succeeded.
    final userDataJson = await getUserData(request, username);
    UserProfile userProfile = UserProfile.fromJson(userDataJson[0]);
    if (!mounted) return;
    context.read<CurrentUserProfileModel>().addUser(userProfile);
  } else {
    // Code here will run if the login failed (wrong username/password).
  }
}

Future<void> logout(
    BuildContext context, bool mounted, CookieRequest request) async {
  request.logout(URL.logoutUrl);
  if (!mounted) return;
  context.read<CurrentUserProfileModel>().removeUser();
}

Future<dynamic> getUserData(CookieRequest request, String username) async {
  final userDataJson = await request.get(URL.userDataURL(username));
  return userDataJson;
}
