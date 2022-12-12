import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/update_user.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/models/register_user.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';

class URL {
  static String userDataURL(username) =>
      "https://sayang-dibuang.up.railway.app/user-data/$username";
  static const String loginUrl =
      "https://sayang-dibuang.up.railway.app/login/ajax";
  static const String logoutUrl =
      "https://sayang-dibuang.up.railway.app/logout/ajax";
  static const String registerUrl =
      "https://sayang-dibuang.up.railway.app/register/ajax";
  static String updateUrl(username) =>
      "https://sayang-dibuang.up.railway.app/update-user-data/$username";
  // static String userDataURL(username) =>
  //     "http://127.0.0.1:8000/user-data/$username";
  // static const String loginUrl = "http://127.0.0.1:8000/login/ajax";
  // static const String logoutUrl = "http://127.0.0.1:8000/logout/ajax";
  // static const String registerUrl = "http://127.0.0.1:8000/register/ajax";
  // static String updateUrl(username) =>
  //     "http://127.0.0.1:8000/update-user-data/$username";
}

Future<String> login(CurrentUserProfileModel profile, bool mounted,
    CookieRequest request, String username, String password1) async {
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
      profile.addUser(userProfile);
      return response["message"];
    } else {
      // Code here will run if the login failed (wrong username/password).
      return response["message"];
    }
  } catch (e) {
    return e.toString();
  }
}

Future<String> logout(CurrentUserProfileModel profile, CookieRequest request,
    [bool mounted = true]) async {
  try {
    final response = await request.logout(URL.logoutUrl);
    if (!mounted) return "";
    profile.removeUser();
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
    final response = await request.post(URL.registerUrl, registerUser.toJson());

    return response["message"];
  } catch (e) {
    return e.toString();
  }
}

Future<String> updateUserData(CurrentUserProfileModel profile, bool mounted,
    CookieRequest request, UpdateUser updateUser) async {
  try {
    final response = await request.post(URL.updateUrl(updateUser.username),
        updateUser.toJson(request.cookies['csrftoken']));

    // Update firstname dan lastname
    if (!mounted) return "";
    profile.updateName(updateUser);

    if (response.runtimeType != String) {
      if (!mounted) return "";
      profile.updateContact(updateUser);
      return response["message"];
    } else {
      return response;
    }
  } catch (e) {
    return e.toString();
  }
}
