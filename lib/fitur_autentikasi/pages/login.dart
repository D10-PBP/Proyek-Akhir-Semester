import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sayang_dibuang_mobile/core/theme/theme_color.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/current_user_profile.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/providers/loading.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/auth.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/pages/register.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/utilities/dialog.dart';
import 'package:sayang_dibuang_mobile/fitur_autentikasi/widgets/form_field.dart';

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
  String username = "";
  String password1 = "";

  void setUsername(String? value) {
    setState(() {
      username = value!;
    });
  }

  void setPassword1(String? value) {
    setState(() {
      password1 = value!;
    });
  }

  validator(String message) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return message;
      }
      return null;
    };
  }

  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
        key: _loginFormKey,
        child: Column(
          children: [
            TextFormFieldAuth(
                placeholder: "Username",
                setFieldState: setUsername,
                validator: validator("Username tidak boleh kosong")),
            const SizedBox(height: 10.0),
            TextFormFieldAuth(
                placeholder: "Password",
                obscureText: !isPasswordVisible,
                setFieldState: setPassword1,
                validator: validator("Password tidak boleh kosong"),
                iconButton: IconButton(
                    onPressed: togglePasswordView,
                    icon: Icon(
                      (isPasswordVisible)
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ))),
            const SizedBox(
              height: 20,
            ),
            Consumer<Loading>(
                builder: (context, loading, child) {
                  return TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ThemeColor.gold),
                    ),
                    onPressed: (!loading.isLoading())
                        ? () async {
                            context.read<Loading>().toggleLoading();
                            if (_loginFormKey.currentState!.validate()) {
                              final response = await login(context, mounted,
                                  request, username, password1);
                              if (!mounted) return;
                              if (!context
                                  .read<CurrentUserProfileModel>()
                                  .hasCurrentUser()) {
                                myDialog(context, response);
                              }
                            }
                            if (!mounted) return;
                            context.read<Loading>().toggleLoading();
                          }
                        : null,
                    child: child!,
                  );
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
            const SizedBox(height: 5),
            InkWell(
              hoverColor: Colors.blue[50],
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()));
              },
              child: Text("Buat akun baru",
                  style: TextStyle(color: Colors.blue[400])),
            )
          ],
        ));
  }
}
