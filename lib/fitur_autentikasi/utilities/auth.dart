import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/register_user.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class URL {
  // static String userDataURL(username) =>
  //     "https://sayang-dibuang.up.railway.app/user-data/$username";
  // static const String loginUrl =
  //     "https://sayang-dibuang.up.railway.app/login/ajax";
  // static const String logoutUrl =
  //     "https://sayang-dibuang.up.railway.app/logout/ajax";
  // static const String registerUrl =
  //     "https://sayang-dibuang.up.railway.app/register/ajax";
  static String userDataURL(username) =>
      "http://127.0.0.1:8000/user-data/$username";
  static const String loginUrl = "http://127.0.0.1:8000/login/ajax";
  static const String logoutUrl = "http://127.0.0.1:8000/logout/ajax";
  static const String registerUrl = "http://127.0.0.1:8000/register/ajax";
}

Future<String> login(BuildContext context, bool mounted, CookieRequest request,
    String username, String password1) async {
  try {
    // 'username' and 'password' should be the values of the user login form.
    final response = await request.login(URL.loginUrl, {
      'username': username,
      'password': password1,
    });
    if (request.loggedIn) {
      // Code here will run if the login succeeded.
      final userDataJson = await getUserData(request, username);
      UserProfile userProfile = UserProfile.fromJson(userDataJson[0]);
      if (!mounted) return "";
      context.read<CurrentUserProfileModel>().addUser(userProfile);
      return response["message"];
    } else {
      // Code here will run if the login failed (wrong username/password).
      return response["message"];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> logout(BuildContext context, CookieRequest request,
    [bool mounted = true]) async {
  try {
    final response = await request.logout(URL.logoutUrl);
    if (!mounted) return "";
    context.read<CurrentUserProfileModel>().removeUser();
    return response["message"];
  } catch (e) {
    return "Logout Failed Try Again";
  }
}

Future<dynamic> getUserData(CookieRequest request, String username) async {
  final userDataJson = await request.get(URL.userDataURL(username));
  return userDataJson;
}

Future<String> register(
    bool mounted, CookieRequest request, RegisterUser registerUser) async {
  try {
    final response = await request.post(URL.registerUrl, {
      'username': registerUser.username,
      'password1': registerUser.password1,
      'password2': registerUser.password2,
      'first_name': registerUser.first_name,
      'last_name': registerUser.last_name,
      'email': registerUser.email,
      'telephone': registerUser.telephone,
      'whatsapp': registerUser.whatsapp,
      'line': registerUser.line,
    });

    return response["message"];
  } catch (e) {
    return e.toString();
  }
}
