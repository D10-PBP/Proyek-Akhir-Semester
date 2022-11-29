import 'package:pbp_django_auth/pbp_django_auth.dart';

Future<void> login(CookieRequest request, String loginUrl, String username,
    String password1) async {
  // 'username' and 'password' should be the values of the user login form.
  final response = await request.login(loginUrl, {
    'username': username,
    'password': password1,
  });
  if (request.loggedIn) {
    // Code here will run if the login succeeded.
    print(response);
  } else {
    // Code here will run if the login failed (wrong username/password).
    print(response);
  }
}

Future<void> logout(CookieRequest request, String logoutUrl) async {
  request.logout(logoutUrl);
}
