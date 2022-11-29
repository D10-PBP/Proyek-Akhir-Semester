import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/widget/drawer.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  bool isPasswordVisible = false;
  String loginUrl = "http://127.0.0.1:8000/login/ajax";
  String logoutUrl = "http://127.0.0.1:8000/logout";

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
    return Scaffold(
      backgroundColor: ThemeColor.sand,
      drawer: const DrawerClass("Login", 2),
      body: Form(
        key: _loginFormKey,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text("LOGIN"),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
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
                  )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Colors.white,
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
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.gold),
                    ),
                    onPressed: () async {
                      print("test");
                      print(_loginFormKey.currentState!.validate());

                      if (_loginFormKey.currentState!.validate()) {
                        print(request);
                        await login(request, loginUrl, username, password1);
                      }
                    },
                    child: const SizedBox(
                        height: 40,
                        width: 200,
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ))),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
