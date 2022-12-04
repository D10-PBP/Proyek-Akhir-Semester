import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/loading.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Loading(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Login",
              style: TextStyle(
                  fontFamily: "Verona",
                  fontWeight: FontWeight.bold,
                  fontSize: 32),
            ),
            Text(
              "Masuk ke Akun Anda",
              style: TextStyle(
                fontFamily: "PlusJakarta",
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 30),
            const LoginForm(),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  String username = "";
  String password1 = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(fontFamily: "PlusJakarta'", fontSize: 15),
              decoration: InputDecoration(
                labelText: "Username",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hoverColor: ThemeColor.sand,
              ),
              onChanged: (String? value) {
                setState(() {
                  username = value!;
                });
              },
              onSaved: (String? value) {
                setState(() {
                  username = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong!';
                }
                return null;
              },
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              obscureText: !isPasswordVisible,
              style: const TextStyle(fontFamily: "PlusJakarta'", fontSize: 15),
              decoration: InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: ThemeColor.sand,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  suffixIcon: IconButton(
                      onPressed: togglePasswordView,
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ))),
              onChanged: (String? value) {
                setState(() {
                  password1 = value!;
                });
              },
              onSaved: (String? value) {
                setState(() {
                  password1 = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong!';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ThemeColor.gold),
                ),
                onPressed: () async {
                  context.read<Loading>().toggleLoading();
                  if (_loginFormKey.currentState!.validate()) {
                    final response = await login(
                        context, mounted, request, username, password1);
                    if (!mounted) return;
                    if (!context
                        .read<CurrentUserProfileModel>()
                        .hasCurrentUser()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                            child: SizedBox(
                              width: 300,
                              height: 150,
                              child: Center(
                                child: ListView(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          response,
                                          textAlign: TextAlign.center,
                                        )),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Kembali'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  if (!mounted) return;
                  context.read<Loading>().toggleLoading();
                },
                child: SizedBox(
                    height: 40,
                    width: 200,
                    child: Center(
                      child: Consumer<Loading>(
                        builder: (context, loading, child) {
                          return (!loading.isLoading())
                              ? const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "PlusJakarta",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "PlusJakarta",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ))),
          ],
        ));
  }
}
